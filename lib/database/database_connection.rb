class DatabaseConnection
  
  def self.connect(environment = "development")
    @@db_connection ||= Sequel.connect(:adapter=> DatabaseConfiguration.adapter, 
                                       :database => DatabaseConfiguration.url, 
                                       :user=> DatabaseConfiguration.user, 
                                       :password=> DatabaseConfiguration.password,
                                       :pool_timeout => DatabaseConfiguration.timeout,
                                       :max_connections => DatabaseConfiguration.pool)
 
  end
  

end