require 'spec_helper'

describe(ThumbnailServer) do
  
  def app
    ThumbnailServer.new
  end
  
  it 'should respond to the "/thumbnails" path with height and width' do
    get "/thumbnails/200/200.jpg"
    last_response.ok?.should be_true
  end
  
end

