require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::Person" do
  
  before do
    Appscript.app('Address Book').make(:new => :person, :with_properties => { :organization => 'ThingsClientTest', :company => true })
  end
  
  it "should add a new person" do
    @person = Things::Person.create('ThingsClientTest')
    
  end
end