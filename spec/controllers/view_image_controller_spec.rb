require 'spec_helper'

describe(ViewImageController) do
  
  def app
    ViewImageController.new
  end
  
  it 'should respond to the "/thumbnail" path with specified height,width,aspect ratio, and id' do
    image_path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/snow-leopard-500.jpg")
    java_file = java.io.File.new(image_path)
    image_binary = ImageBinary.create( :file => ImageIOUtils.to_ruby_string(ImageIOUtils.to_byte_array(java_file)), 
                                                :file_size => java_file.length,
                                                :created_at => Time.now, 
                                                :updated_at => Time.now, 
                                                :mime_type => "image/jpg" )
    get "/views/thumbnail/200x200/1x1/#{image_binary.id}.jpg"
    last_response.ok?.should be_true
  end
  
  describe("the service returns a JSON response code on error") do
    
    it 'should have a status of 404 when the image is not found' do
      ImageBinary.stub(:find).and_return(nil)
      get "/views/thumbnail/200x200/1x1/12.jpg"
      last_response.status.should == 404
    end
    
    it 'should state the image was not found for whatever id was requested' do
      ImageBinary.stub(:find).and_return(nil)
      get "/views/thumbnail/200x200/1x1/12.jpg"
      JSON.parse(last_response.body).should == {"status" => 404, "message" => "The image you requested with id=12 was not found."}
    end

  end
  
end

