class UploadImageController < Sinatra::Base
  
  set :views, File.dirname(__FILE__) + '/../views/uploads'
  
  get "/new" do
    erb :new
  end
  
  post "/create" do
    image_file = params["image_file"][:tempfile]
    image_binary = ImageBinary.create( :file => ImageIOUtils.to_ruby_string(image_file), 
                                       :file_size => image_file.size,
                                       :mime_type => params["image_file"][:type] )
    image_binary.image_attribute = ImageAttribute.new( :caption => params["image_caption"], :description => params["image_description"] )
    image_binary.save
    content_type :json
    { :status => 200, :image => {:id => image_binary.id, 
                                 :caption => image_binary.image_attribute.caption, 
                                 :description => image_binary.image_attribute.description}}.to_json
  end
  
end