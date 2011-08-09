require 'spec_helper'

describe(DatabaseConnection) do
  
  it 'should return a connection to the database' do
    DatabaseConnection.connection.class.should eq(Sequel::JDBC::Database)
  end
  
end