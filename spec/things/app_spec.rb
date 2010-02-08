require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::App" do

  describe '#instance' do
    
    it 'should return an instance of the Things app' do
      Things::App.instance.class.should == Appscript::Application
    end
    
  end
  
  describe '#activate' do
  
    it 'should start the app if it is not running' do
      
      # close if running
      #Things::App.instance!.quit if `ps x | grep Things`.include?('Things.app')
      #{}`ps x | grep Things`.should_not match('Things.app')
      #Things::App.instance!.activate
      #{}`ps x | grep Things`.should match('Things.app')
    end
    
  end
  
  describe '#lists' do
    
    it "should return Things::Collections::List" do
      Things::App.lists.should == Things::List
    end

  end
    
end
