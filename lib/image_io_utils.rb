class ImageIOUtils
  
  class << self
    
    # Takes a Java file, and converts the file contents into a Java byte array
    def to_byte_array(java_file)
      fis = java.io.FileInputStream.new(java_file)
      byte_array = org.apache.commons.io.IOUtils.to_byte_array(fis)
      fis.close
      byte_array
    end
    
    def to_buffered_image(byte_array)
      javax.imageio.ImageIO.read(java.io.ByteArrayInputStream.new(byte_array))
    end
    
    # Take a Java byte array or Tempfile
    def to_ruby_string(input)
      if(input.is_a?(Java::byte[]))
        String.from_java_bytes(input)
      else
        read_buffer = ""
        image_contents = ""
        while input.read(1024, read_buffer)
          image_contents << read_buffer
        end
        image_contents
      end
    end
    
  end
  
end