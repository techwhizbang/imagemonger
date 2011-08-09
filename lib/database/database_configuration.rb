class DatabaseConfiguration
  
  class << self
  
    def configure(environment = "development")
      @@db_configuration ||= YAML.load(ERB.new(File.read(File.expand_path(File.dirname(__FILE__) + "/../../config/database.yml"))).result)[environment]
    end
    
    def user
      configure["user"]
    end
    
    def password
      configure["password"]
    end
    
    def adapter
      configure["adapter"]
    end
    
    def pool
      configure["pool"]
    end
    
    def url
      configure["url"]
    end
    
    def timeout
      configure["timeout"]
    end
      
  end
  
end