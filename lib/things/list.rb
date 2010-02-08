module Things
  class List < Reference::Base
    
    DEFAULTS = [:inbox, :today, :next, :scheduled, :someday, :projects, :logbook, :trash]
    
    def todos
      Things::Todo.convert(reference.todos.get)
    end
    
    class << self
      
      # Returns an Appscript Reference to the entire collection of todos
      def reference
        Things::App.instance.lists
      end

      # Converts a collection of reference into a collection of objects
      def convert(references)
        references = [references] if !references.is_a?(Array)
        references.collect { |todo| build(todo) }
      end
      
      def all
        convert(reference.get)
      end
      
      # build a new instance and link it to the supplied reference
      #
      # Returns a object associated with a reference
      def build(reference)
        todo = self.new
        todo.reference = reference
        todo
      end

      DEFAULTS.each do |list|
        class_eval <<-"eval"
          def #{list}
            convert(reference['#{list.to_s.capitalize}'].get).first
          end
        eval
      end
    end
  end
end