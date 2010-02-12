require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::App" do

  describe '#instance' do
    
    it 'should return an instance of the Things app' do
      Things::App.instance.class.should == Appscript::Application
    end
    
  end
  
  describe '#activate' do
  
    it 'should put the app in the front' do      
      Things::App.instance!.activate
      Things::App.instance.frontmost.get.should == true
    end
    
  end
  
  describe '#lists' do
    
    it "should return Things::Collections::List" do
      Things::App.lists.should == Things::List
    end

  end
    
end
