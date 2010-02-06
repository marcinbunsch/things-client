module Things
  module Collections
    class Todo
    
      class << self
        
        # Get all todos
        def all
          reference.get.collect { |todo| Things::Todo.build(todo) }
        end

        # get references to all todos
        def reference
          Things::App.instance.todos
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
    
        Things::List::DEFAULTS.each do |list|
          class_eval <<-"eval"
            def #{list}
              Things::App.lists.#{list}.todos
            end
          eval
        end

      end
      
    end
  end
end