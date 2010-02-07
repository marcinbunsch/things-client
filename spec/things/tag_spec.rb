require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::Tag" do

  before do
    Things::App.activate
    @tag = Things::Tag.new(:name => 'TEST - Foo')
  end
  
  after do
    # close all windows when done
    Things::App.instance.windows.get.each do |window|
      Things::App.instance!.close(window)
    end
  end
  
  describe "#self.new" do
      
    it "should create a new Things::Tag instance with properties" do      
      @tag.name.should == "TEST - Foo"
    end
    
    it "should not be sent to Things yet" do
      @tag.id_.should == nil
      Things::App.instance.tags.get.collect { |tag| tag.name.get }.should_not include("TEST - Foo")
    end
    
  end
  
  describe "#new?" do

    it "should return whether the instance is new or not" do
      @tag.new?.should == true
    end
    
  end
  
  describe "#save" do
    
    before do
      @tag.save
    end
    
    after do
      @tag.delete
      Things::App.instance.empty_trash
    end
    
    describe "on a new tag" do

      it "should create the tag" do
        @tag.id_.should_not be_nil
        @tag.new?.should == false
        
        Things::App.instance.tags.get.collect { |tag| tag.name.get }.should include("TEST - Foo")
      end
      
    end
    
    describe "on an existing tag" do
      it "should update the tag" do
        @tag.name = 'TEST - Boo'
        @tag.save
        @found = Things::Tag.find_by_id(@tag.id_)
        @found.name.should == 'TEST - Boo'
      end
    end
    
  end
  
  describe '#create' do

    before do
      @tag.delete
      Things::App.instance.empty_trash
    end

    after do
      @tag.delete
      Things::App.instance.empty_trash
    end
    
    it "should create a new tag based on supplied properties" do
      @tag = Things::Tag.create(:name => 'TEST - Goo')
      @tag.new?.should == false
      @tag.id_.should_not be_nil
      @tag.name.should == 'TEST - Goo'
    end
    
    
  end
  
  describe '#delete' do
    
    before do
      @tag.save
      Things::App.instance.tags.name.get.should include(@tag.name)
    end
    
    it "should remove a tag" do
      @tag.delete
      Things::App.instance.empty_trash
      Things::App.instance.tags.name.get.should_not include(@tag.name)      
    end
    
  end
  
  describe 'finding' do

    before do
      @tag.save
    end
    
    after do
      @found.class.should == Things::Tag
      @found.id_.should == @tag.id_
      @found.name.should == @tag.name
      
      @tag.delete
      Things::App.instance.empty_trash
    end
    
    describe '#find_by_name' do

      it "should find a tag based on its name" do
        @found = Things::Tag.find_by_name('TEST - Foo')
      end

    end
    
    describe '#find_by_id' do

      it "should find a tag based on its id" do
        @found = Things::Tag.find_by_id(@tag.id_)
      end

    end
    
    describe '#find' do
      it "should find a tag based on its name" do
        @found = Things::Tag.find('TEST - Foo')
      end
      
      it "should find a tag based on its id" do
        @found = Things::Tag.find(@tag.id_)
      end
    end
    
  end
  
  

end