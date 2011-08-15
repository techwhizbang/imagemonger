require 'spec_helper'
require 'tempfile'

describe(ImageIOUtils) do
  
  before do
    @image_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/snow-leopard-500.jpg")
    @java_file = java.io.File.new(@image_path)
  end
  
  it('should convert a file to a Java byte[]') do
    ImageIOUtils.to_byte_array(@java_file).is_a?(Java::byte[]).should be_true
  end
  
  it('should convert a Java byte[] into a Java BufferedImage') do
    ImageIOUtils.to_buffered_image(ImageIOUtils.to_byte_array(@java_file)).is_a?(java.awt.image.BufferedImage)
  end
  
  it('should convert a Java byte[] into a Ruby String') do
    ImageIOUtils.to_ruby_string(ImageIOUtils.to_byte_array(@java_file)).is_a?(String).should be_true
  end
  
  it('should convert a Tempfile into a a Ruby String') do
    tempfile = Tempfile.new("temp testing")
    tempfile.write("temporary testing contents")
    ImageIOUtils.to_ruby_string(tempfile).is_a?(String).should be_true 
    tempfile.close
  end
  
end