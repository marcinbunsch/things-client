module Things
  # Things::Todo
  class Area < Reference::Record
    
    properties :name
    # identifier is required for creation
    identifier :area
    # collection is used for findings
    collection :areas
   
    def todos
      Things::Todo.convert(reference.todos.get)
    end
   
  end
  
end