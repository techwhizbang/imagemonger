require 'spec_helper'

describe(ThumbnailServer) do
  
  def app
    ThumbnailServer.new
  end
  
  it 'should respond to the "/thumbnail" path with specified height,width,aspect ratio, and id' do
    get "/thumbnail/200x200/1x1/12.jpg"
    last_response.ok?.should be_true
  end
  
end

