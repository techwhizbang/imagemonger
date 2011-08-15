require 'spec_helper'

describe(ImageCropping) do
    
  before do
    image_path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/snow-leopard-500.jpg")
    @java_file = java.io.File.new(image_path)
    @new_image = Proc.new {
      ImageBinary.create( :file => ImageIOUtils.to_ruby_string(ImageIOUtils.to_byte_array(@java_file)), 
                                                  :file_size => @java_file.length,
                                                  :created_at => Time.now, 
                                                  :updated_at => Time.now, 
                                                  :mime_type => "image/jpg")
    }
  end
  
  it('should add a new image cropping') do
    image_binary = @new_image.call
    image_binary.add_image_cropping(:x_coordinate => 0, :y_coordinate => 0, :aspect_ratio => "4x3")
    image_binary.image_croppings.size.should == 1
  end
  
  
  
end