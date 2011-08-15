require 'spec_helper'

describe(UploadImageController) do
  
  describe("when uploading") do
  
    describe("the service accepts requests") do
      
      it('with an image') do
       
      end

      it('with an image and caption')

      it('with an image, caption, and a description')
      
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