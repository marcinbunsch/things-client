require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "Things::Collections::Todo" do
  
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
      Things::Collections::Todo.all.collect(&:id_).should include(@todo_a.id_)
      Things::Collections::Todo.all.collect(&:id_).should include(@todo_b.id_)
    end
    
  
  end
  
  describe "#self.active" do
    
    before do 
      @todo_a = Things::Todo.create(:name => 'TEST - AAA')
      @todo_b = Things::Todo.create(:name => 'TEST - BBB')
      Things::Collections::Todo.active.collect(&:id_).should include(@todo_a.id_)
      Things::Collections::Todo.active.collect(&:id_).should include(@todo_b.id_)
    end
    
    after do
      @todo_a.delete
      @todo_b.delete      
      Things::App.instance.empty_trash
    end
    
    it "should not include completed todos" do
      @todo_b.completion_date = Time.now
      @todo_b.save
      Things::Collections::Todo.active.collect(&:id_).should include(@todo_a.id_)
      Things::Collections::Todo.active.collect(&:id_).should_not include(@todo_b.id_)      
    end
    
    it "should not include deleted todos" do
      @todo_a.delete
      Things::Collections::Todo.active.collect(&:id_).should_not include(@todo_a.id_)
      Things::Collections::Todo.active.collect(&:id_).should include(@todo_b.id_)
    end
    
  end
end
