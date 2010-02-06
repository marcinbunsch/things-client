module Things
  module Collections
    class Todo
    
      class << self
        
        # Returns an Appscript Reference to the entire collection of todos
        def reference
          Things::App.instance.todos
        end
        
        # these are references and should be stored somewhere else...
        Things::List::DEFAULTS.each do |list|
          class_eval <<-"eval"
            def #{list}
              Things::App.lists.#{list}.todos
            end
          eval
        end
        
        # Returns an array of Things::Todo objects
        def all
          reference.get.collect { |todo| Things::Todo.build(todo) }
        end

        # Get all not completed Todos
        # Note this returns an array of Todos, not references
        # TODO: find a better way of filtering references
        def active
          result = (reference.get - Things::List.trash.todos.get).collect do |todo| 
            Things::Todo.build(todo) if todo.completion_date.get.to_s == 'missing_value'
          end
          result.compact
        end
    


      end
      
    end
  end
end