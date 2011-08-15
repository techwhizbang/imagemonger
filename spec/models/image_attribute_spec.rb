require 'spec_helper'

describe(ImageAttribute) do
  
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
  
  it('should create a new record') do
    image_binary = @new_image.call
    image_binary.image_attribute = ImageAttribute.new(:caption => "My caption", :description => "My description")
    image_binary.image_attribute.new?.should be_false
  end
  
  it('should return a caption') do
    ImageAttribute.new(:caption => "My caption").caption.should == "My caption"
  end
  
  it('should return a description') do
    ImageAttribute.new(:description => "My description").description.should == "My description"
  end
  
end