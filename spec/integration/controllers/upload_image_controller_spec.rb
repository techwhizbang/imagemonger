require 'spec_helper'

describe(UploadImageController) do
  
  def app
    UploadImageController.new
  end
  
  before do
    @image_path = File.expand_path(File.dirname(__FILE__) + "/../../fixtures/snow-leopard-500.jpg")
  end
  
  describe("when uploading") do
  
    describe("the service accepts requests") do
      
      it('with an image') do
        post "/create", "image_file" => Rack::Test::UploadedFile.new(@image_path, "image/jpeg")
        last_response.ok?.should be_true
      end

      it('with an image and caption') do
        post "/create", "image_file" => Rack::Test::UploadedFile.new(@image_path, "image/jpeg"),
                        "image_caption" => "My caption"
        last_response.ok?.should be_true        
      end

      it('with an image, caption, and a description') do
        post "/create", "image_file" => Rack::Test::UploadedFile.new(@image_path, "image/jpeg"),
                        "image_caption" => "My caption",
                        "image_description" => "My description"
        last_response.ok?.should be_true
      end
      
    end
    
    describe("the service returns a JSON response") do
      
      describe("when it is a failure") do
        
        describe("due to a user error") do
          
          it('has a list of missing required parameters')
          
          it('has a list of fields that exceed the size limit')
          
          it('has a list of supported image types')
          
        end
        
        describe("due to a system error") do
          
          it('has a 500 status code when there is an exception')
          
        end
        
      end
      
      describe("when it is a success") do
    
        it('with a UUID for the image')
    
        it('with the image details')
        
        it('has a 200 status code')
    
      end
      
    end
        
  end
  
end