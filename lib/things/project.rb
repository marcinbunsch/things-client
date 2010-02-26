module Things
  # Things::Todo
  class Project < Reference::Record
    
    properties :name
    # identifier is required for creation
    identifier :project
    # collection is used for findings
    collection :projects
   
    class << self
      def all
        convert(Things::App.instance.projects.get)
      end
    end
    
    def todos
      Things::Todo.convert(reference.todos.get)
    end
    
  end
end