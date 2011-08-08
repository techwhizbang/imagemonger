import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.RenderingHints
import java.awt.AlphaComposite

class ThumbnailServer < Sinatra::Base

  SUPPORTED_ASPECT_RATIOS = {"16x9" => ((16.to_f)/9), "5x3" => ((5.to_f)/3), 
                             "3x2" => ((3.to_f)/2), "4x3" => ((4.to_f)/3), 
                             "3x4" => ((3.to_f)/4), "1x1" => 1}.freeze

  get "/thumbnails/:height/:width" do |path, ext|
    image_type = ext.split(".").last
    buffered_image = read_original_image(nil)
    @scale_height = params[:height].to_i
    @scale_width = params[:width].to_i
    
    assign_proper_scale(buffered_image)
    resized_image = resize(buffered_image)
    
    response.headers['Content-Type'] = "image/#{image_type}"
    response.write(buffered_image_to_string(resized_image, image_type))
  end
  
  # Format /thumbnails/200x200/3x2.jpg
  get "/thumbnails-aspect/:height_by_width/:aspect_ratio" do |path, ext|
    image_type = ext.split(".").last
    @scale_height = params[:height_by_width].split("x")[0].to_i
    @scale_width = params[:height_by_width].split("x")[1].to_i
    puts "the param aspect ratio #{params[:aspect_ratio].split(".")[0]}"
    @aspect_ratio = SUPPORTED_ASPECT_RATIOS[params[:aspect_ratio].split(".")[0]] || 1
    
    puts "the height #{@scale_height}, the width #{@scale_width}, #{@aspect_ratio}"
    
    buffered_image = read_original_image(nil)
    assign_proper_scale(buffered_image)
    resized_image = resize(buffered_image)
    
    aspect_height = calculate_height_aspect_window(resized_image, @aspect_ratio)
    aspect_width = calculate_width_aspect_window(resized_image, @aspect_ratio)
    
    puts "the aspect height #{aspect_height}, the aspect width #{aspect_width}"
    
    desired_aspect_window = java.awt.Rectangle.new(aspect_width, aspect_height)
    cropped_aspect_window = desired_aspect_window.intersection(java.awt.Rectangle.new(resized_image.get_width, resized_image.get_height))
    
    # for now just assume start at 0,0 for the x,y coordinates...
    puts "the cropped aspect x coor #{cropped_aspect_window.get_x}"
    puts "the cropped aspect y coor #{cropped_aspect_window.get_y}"
    resized_cropped_image = resized_image.get_subimage(cropped_aspect_window.get_x, cropped_aspect_window.get_y, cropped_aspect_window.width, cropped_aspect_window.height) 
    response.headers['Content-Type'] = "image/#{image_type}"
    response.write(buffered_image_to_string(resized_cropped_image, image_type))    
  end
  
  # Format /full/3x2
  get "/full/:aspectRatio" do |path, ext|
    image_type = ext.split(".").last

  end

  private
  
  def buffered_image_to_string(buffered_image, image_type)
    byte_array_stream = java.io.ByteArrayOutputStream.new
    ImageIO.write(buffered_image, image_type, byte_array_stream)
    image_byte_array = byte_array_stream.to_byte_array
    
    # Memory! => close everything and be sure to not let anything linger longer than necessary
    byte_array_stream.close
  
    buffered_image = nil
    resized_image = nil
    String.from_java_bytes(image_byte_array)
  end
  
  def calculate_height_aspect_window(buffered_image, specified_aspect_ratio)
    (buffered_image.get_width.to_f) / specified_aspect_ratio
  end
  
  def calculate_width_aspect_window(buffered_image, specified_aspect_ratio)
    buffered_image.get_height.to_f * specified_aspect_ratio
  end

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