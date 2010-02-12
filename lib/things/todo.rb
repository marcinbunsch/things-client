module Things
  # Things::Todo
  class Todo < Reference::Record
    
    properties :name, :notes, :completion_date, :delegate, :status, :area, :project
    # identifier is required for creation
    identifier :to_do
    # collection is used for findings
    collection :todos
   
    # Move a todo to a different list <br />
    # Moving to Trash will delete the todo
    def move(list)
      list = list.reference if !list.is_a?(Appscript::Reference)
      Things::App.instance.move(reference, { :to => list })
    end
    
    # Set the status to :completed
    #
    # Does not save the Todo
    def complete
      self.status = :completed
    end

    # Set the status to :completed
    #
    # Saves the Todo
    def complete!
      complete
      self.save
    end

    # Check whether the Todo is completed or not
    def completed?
      self.status == :completed
    end
    
    # Set the status to :open
    #
    # Does not save the Todo
    def open
      self.status = :open
    end

    # Set the status to :open
    #
    # Saves the Todo
    def open!
      open
      self.save
    end

    # Check whether the Todo is open or not
    def open?
      self.status == :open
    end
    
    # class methods, for accessing collections
    class << self
      
      # Returns an Appscript Reference to the entire collection of todos
      def reference
        Things::App.instance.todos
      end
      
      # Converts a collection of reference into a collection of objects
      def convert(references)
        references.to_a.collect { |todo| build(todo) }
      end
      
      # these are references and should be stored somewhere else...
      Things::List::DEFAULTS.each do |list|
        class_eval <<-"eval"
          def #{list}
            convert(Things::List.#{list}.reference.todos.get)
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
        result = (reference.get - Things::List.trash.reference.todos.get).select do |todo| 
          todo.completion_date.get == :missing_value
        end
        convert(result.compact)
      end

    end
    
  end
end