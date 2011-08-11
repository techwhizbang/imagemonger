require 'spec_helper'

describe(DatabaseConnection) do
  
  it 'should return a connection to the database' do
    DatabaseConnection.connect.class.should eq(Sequel::JDBC::Database)
  end
  
end