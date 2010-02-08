require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Things::Todo" do

  before do
    @todo = Things::Todo.new(:name => 'TEST - Foo', :notes => 'TEST - Fooer')
  end
  
  describe "#self.new" do
      
    it "should create a new Things::Todo instance with properties" do      
      @todo.name.should == "TEST - Foo"
      @todo.notes.should == "TEST - Fooer"
    end
    
    it "should not be sent to Things yet" do
      @todo.id_.should == nil
      active = (Things::App.instance.todos.get - Things::List.trash.reference.todos.get)
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
        active = (Things::App.instance.todos.get - Things::List.trash.reference.todos.get)
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
      Things::App.lists.inbox.reference.todos.name.get.should include(@todo.name)
    end
    
    it "should remove a todo" do
      @todo.delete
      Things::App.lists.inbox.reference.todos.name.get.should_not include(@todo.name)      
      Things::App.lists.trash.reference.todos.name.get.should include(@todo.name)
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
  
  describe "#self.all" do
    before do 
      @todo_a = Things::Todo.create(:name => 'TEST - AAA')
      @todo_b = Things::Todo.create(:name => 'TEST - BBB')
    end
    
    after do
      @todo_a.delete
      @todo_b.delete      
      Things::App.instance.empty_trash
    end
    
    it "should return a collection of all todos as Things::Todo objects" do
      Things::Todo.all.collect(&:id_).should include(@todo_a.id_)
      Things::Todo.all.collect(&:id_).should include(@todo_b.id_)
    end
    
  
  end
  
  describe "#self.active" do
    
    before do 
      @todo_a = Things::Todo.create(:name => 'TEST - AAA')
      @todo_b = Things::Todo.create(:name => 'TEST - BBB')
      Things::Todo.active.collect(&:id_).should include(@todo_a.id_)
      Things::Todo.active.collect(&:id_).should include(@todo_b.id_)
    end
    
    after do
      @todo_a.delete
      @todo_b.delete      
      Things::App.instance.empty_trash
    end
    
    it "should not include completed todos" do
      @todo_b.completion_date = Time.now
      @todo_b.save
      Things::Todo.active.collect(&:id_).should include(@todo_a.id_)
      Things::Todo.active.collect(&:id_).should_not include(@todo_b.id_)      
    end
    
    it "should not include deleted todos" do
      @todo_a.delete
      Things::Todo.active.collect(&:id_).should_not include(@todo_a.id_)
      Things::Todo.active.collect(&:id_).should include(@todo_b.id_)
    end
    
  end

end