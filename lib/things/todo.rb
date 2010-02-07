module Things
  # Things::Todo
  class Todo < Reference::Record
    
    properties :name, :notes, :completion_date
    # identifier is required for creation
    identifier :to_do
    # collection is used for findings
    collection :todos
   
    # Move a todo to a different list <br />
    # Moving to Trash will delete the todo
    def move(list)
      Things::App.instance.move(reference, { :to => list })
    end
    
  end
end