import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.RenderingHints
import java.awt.AlphaComposite

class ThumbnailServer < Sinatra::Base

  get "/thumbnails/:height/:width" do |path, ext|
    image_type = ext.split(".").last
    buffered_image = read_original_image(nil)
    @scale_height = params[:height].to_i
    @scale_width = params[:width].to_i
    
    assign_proper_scale(buffered_image)
    resized_image = resize(buffered_image)
    
    byte_array_stream = java.io.ByteArrayOutputStream.new
    ImageIO.write(resized_image, image_type, byte_array_stream)
    image_byte_array = byte_array_stream.to_byte_array
    
    # Memory! => close everything and be sure to not let anything linger longer than necessary
    byte_array_stream.close
    buffered_image = nil
    resized_image = nil
    
    response.headers['Content-Type'] = "image/#{image_type}"
    response.write(String.from_java_bytes(image_byte_array))
  end

  private

  def assign_proper_scale(buffered_image)
    actual_aspect_ratio = aspect_ratio(buffered_image)
    if (requested_aspect_ratio(@scale_height, @scale_width) > actual_aspect_ratio)
      @scale_width = (actual_aspect_ratio * @scale_height).round.to_i
    else
      @scale_height = (@scale_width / actual_aspect_ratio).round.to_i
    end
  end

  def read_original_image(path)
    image_path = File.expand_path(File.dirname(__FILE__) + "/../images/snow-leopard-500.jpg")
    puts "the image path #{image_path}"
    ImageIO.read(java.io.File.new(image_path))
  end

  def aspect_ratio(buffered_image)
    ((buffered_image.get_width.to_f) / buffered_image.get_height)
  end

  def requested_aspect_ratio(height, width)
    ((width.to_f) / height)
  end

  def resize(buffered_image)
    type = buffered_image.get_type == 0 ? BufferedImage.TYPE_INT_ARGB : buffered_image.get_type
    resized_image = BufferedImage.new(@scale_width, @scale_height, type)
    g = resized_image.create_graphics
    g.set_composite(AlphaComposite::Src)

    g.set_rendering_hint(RenderingHints::KEY_INTERPOLATION,
                         RenderingHints::VALUE_INTERPOLATION_BILINEAR)

    g.set_rendering_hint(RenderingHints::KEY_RENDERING,
                         RenderingHints::VALUE_RENDER_QUALITY)

    g.set_rendering_hint(RenderingHints::KEY_ANTIALIASING,
                         RenderingHints::VALUE_ANTIALIAS_ON)

    g.draw_image(buffered_image, 0, 0, @scale_width, @scale_height, nil)
    g.dispose
    resized_image
  end

end