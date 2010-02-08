require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::Project" do

  before do
    @project = Things::Project.new(:name => 'TEST - Foo')
  end
  
  describe "#self.new" do
      
    it "should create a new Things::Project instance with properties" do      
      @project.name.should == "TEST - Foo"
    end
    
    it "should not be sent to Things yet" do
      @project.id_.should == nil
      Things::App.instance.projects.get.collect { |project| project.name.get }.should_not include("TEST - Foo")
    end
    
  end
  
  describe "#new?" do

    it "should return whether the instance is new or not" do
      @project.new?.should == true
    end
    
  end
  
  describe "#save" do
    
    before do
      @project.save
    end
    
    after do
      @project.delete
      Things::App.instance.empty_trash
    end
    
    describe "on a new project" do

      it "should create the project" do
        @project.id_.should_not be_nil
        @project.new?.should == false
        
        Things::App.instance.projects.get.collect { |project| project.name.get }.should include("TEST - Foo")
      end
      
    end
    
    describe "on an existing project" do
      it "should update the project" do
        @project.name = 'TEST - Boo'
        @project.save
        @found = Things::Project.find_by_id(@project.id_)
        @found.name.should == 'TEST - Boo'
      end
    end
    
  end
  
  describe '#create' do

    before do
      @project.delete
      Things::App.instance.empty_trash
    end

    after do
      @project.delete
      Things::App.instance.empty_trash
    end
    
    it "should create a new project based on supplied properties" do
      @project = Things::Project.create(:name => 'TEST - Goo')
      @project.new?.should == false
      @project.id_.should_not be_nil
      @project.name.should == 'TEST - Goo'
    end
    
    
  end
  
  describe '#delete' do
    
    before do
      @project.save
      Things::App.instance.projects.name.get.should include(@project.name)
    end
    
    it "should remove a project" do
      @project.delete
      Things::App.instance.empty_trash
      Things::App.instance.projects.name.get.should_not include(@project.name)      
    end
    
  end
  
  describe 'finding' do

    before do
      @project.save
    end
    
    after do
      @found.class.should == Things::Project
      @found.id_.should == @project.id_
      @found.name.should == @project.name
      
      @project.delete
      Things::App.instance.empty_trash
    end
    
    describe '#find_by_name' do

      it "should find a project based on its name" do
        @found = Things::Project.find_by_name('TEST - Foo')
      end

    end
    
    describe '#find_by_id' do

      it "should find a project based on its id" do
        @found = Things::Project.find_by_id(@project.id_)
      end

    end
    
    describe '#find' do
      it "should find a project based on its name" do
        @found = Things::Project.find('TEST - Foo')
      end
      
      it "should find a project based on its id" do
        @found = Things::Project.find(@project.id_)
      end
    end
    
  end
  
  

end