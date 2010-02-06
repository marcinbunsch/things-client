require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::Todo" do

  before do
    Things::App.activate
    @todo = Things::Todo.new(:name => 'TEST - Foo', :notes => 'TEST - Fooer')
  end
  
  after do
    # close all windows when done
    Things::App.instance.windows.get.each do |window|
      Things::App.instance!.close(window)
    end
  end
  
  describe "#self.new" do
      
    it "should create a new Things::Todo instance with properties" do      
      @todo.name.should == "TEST - Foo"
      @todo.notes.should == "TEST - Fooer"
    end
    
    it "should not be sent to Things yet" do
      @todo.id_.should == nil
      active = (Things::App.instance.todos.get - Things::List.trash.todos.get)
      active.collect { |todo| todo.name.get }.should_not include("TEST - Foo")
    end
    
  end
  
  describe "#new?" do

    it "should return whether the instance is new or not" do
      @todo.new?.should == true
    end
    
  end
  
  describe "#save" do
    
    before do
      @todo.save
    end
    
    after do
      @todo.delete
      Things::App.instance.empty_trash
    end
    
    describe "on a new todo" do

      it "should create the todo" do
        @todo.id_.should_not be_nil
        @todo.new?.should == false
        active = (Things::App.instance.todos.get - Things::List.trash.todos.get)
        active.collect { |todo| todo.name.get }.should include("TEST - Foo")
      end
      
    end
    
    describe "on an existing todo" do
      it "should update the todo" do
        @todo.name = 'TEST - Boo'
        @todo.save
        @found = Things::Todo.find_by_id(@todo.id_)
        @found.name.should == 'TEST - Boo'
      end
    end
    
  end
  
  describe '#create' do

    before do
      @todo.delete
      Things::App.instance.empty_trash
    end

    after do
      @todo.delete
      Things::App.instance.empty_trash
    end
    
    it "should create a new todo based on supplied properties" do
      @todo = Things::Todo.create(:name => 'TEST - Goo')
      @todo.new?.should == false
      @todo.id_.should_not be_nil
      @todo.name.should == 'TEST - Goo'
    end
    
    
  end
  
  describe '#delete' do
    
    before do
      @todo.save
      Things::App.lists.inbox.todos.name.get.should include(@todo.name)
    end
    
    it "should remove a todo" do
      @todo.delete
      Things::App.lists.inbox.todos.name.get.should_not include(@todo.name)      
      Things::App.lists.trash.todos.name.get.should include(@todo.name)
    end
    
    after do
      Things::App.instance.empty_trash
    end
    
  end
  
  describe 'finding' do

    before do
      @todo.save
    end
    
    after do
      @found.class.should == Things::Todo
      @found.id_.should == @todo.id_
      @found.name.should == @todo.name
      @found.notes.should == @todo.notes
      
      @todo.delete
      Things::App.instance.empty_trash
    end
    
    describe '#find_by_name' do

      it "should find a todo based on its name" do
        @found = Things::Todo.find_by_name('TEST - Foo')
      end

    end
    
    describe '#find_by_id' do

      it "should find a todo based on its id" do
        @found = Things::Todo.find_by_id(@todo.id_)
      end

    end
    
    describe '#find' do
      it "should find a todo based on its name" do
        @found = Things::Todo.find('TEST - Foo')
      end
      
      it "should find a todo based on its id" do
        @found = Things::Todo.find(@todo.id_)
      end
    end
    
  end
  
  

end