require 'spec_helper'

describe(ImageBinary) do
  
  before do
    image_path = File.expand_path(File.dirname(__FILE__) + "/../../fixtures/snow-leopard-500.jpg")
    @java_file = java.io.File.new(image_path)
    @new_image = Proc.new { ImageBinary.create( :file => ImageIOUtils.to_ruby_string(ImageIOUtils.to_byte_array(@java_file)), 
                                                :file_size => @java_file.length,
                                                :created_at => Time.now, 
                                                :updated_at => Time.now, 
                                                :mime_type => "image/jpg" ) }  
                                    
  end
  
  it('should create a new record') do
    image_binary = @new_image.call
    ImageBinary.find(:id => image_binary.id).should_not be_nil
  end
  
  it('should return the file binary') do
    image_binary = @new_image.call
    image_binary.file.is_a?(Sequel::SQL::Blob).should be_true
  end
  
  it('should return the created at timestamp') do
    image_binary = @new_image.call
    image_binary.created_at.is_a?(Time).should be_true
  end
  
  it('should return the updated at timestamp') do
    image_binary = @new_image.call
    image_binary.updated_at.is_a?(Time).should be_true
  end
  
  it('should return the file size') do
    image_binary = @new_image.call
    image_binary.file_size.should be > 0
  end
  
  it('should return the mime type') do
    image_binary = @new_image.call
    image_binary.mime_type.should == "image/jpg"
  end
    
end