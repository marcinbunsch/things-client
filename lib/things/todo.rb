module Things
  # Things::Todo
  class Todo < Reference::Record
    
    properties :name, :notes, :completion_date, :delegate
    # identifier is required for creation
    identifier :to_do
    # collection is used for findings
    collection :todos
   
    # Move a todo to a different list <br />
    # Moving to Trash will delete the todo
    def move(list)
      Things::App.instance.move(reference, { :to => list })
    end
    
    # class methods, for accessing collections
    class << self
      
      # Returns an Appscript Reference to the entire collection of todos
      def reference
        Things::App.instance.todos
      end
      
      # Converts a collection of reference into a collection of objects
      def convert(references)
        references.to_a.collect { |todo| Things::Todo.build(todo) }
      end
      
      # these are references and should be stored somewhere else...
      Things::List::DEFAULTS.each do |list|
        class_eval <<-"eval"
          def #{list}
            convert(Things::App.lists.#{list}.todos.get)
          end
        eval
      end
      
      # Returns an array of Things::Todo objects
      def all
        convert(reference.get)
      end

      # Get all not completed Todos
      # Note this returns an array of Todos, not references
      # TODO: find a better way of filtering references
      def active
        result = (reference.get - Things::List.trash.todos.get).select do |todo| 
          todo.completion_date.get == :missing_value
        end
        convert(result.compact)
      end
  


    end
    
  end
end