require 'spec_helper'

describe(DatabaseConfiguration) do

  before do
    DatabaseConfiguration.configure
  end

  it('should return the user') do
    DatabaseConfiguration.user.should == "default"
  end
  
  it('should return the password') do
    DatabaseConfiguration.password.should be_nil  
  end
  
  it('should return the url') do
    DatabaseConfiguration.url.should == "jdbc:postgresql://localhost/images_development"
  end
  
  it('should return the pool') do
    DatabaseConfiguration.pool.should == 5
  end
  
  it('should return the timeout') do
    DatabaseConfiguration.timeout.should == 5
  end
  
  it('should return the adapter') do
    DatabaseConfiguration.adapter.should == "jdbc"
  end

end