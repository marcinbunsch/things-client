module Things
  # Things::Todo
  class Todo
    
    PROPERTIES = [ :id_, 
                   :name, 
                   :notes, 
                   :project, 
                   :area, 
                   :cancellation_date, 
                   :completion_date, 
                   :creation_date, 
                   :delegate, 
                   :due_date, 
                   :tag_names ]

    attr_writer *PROPERTIES
    attr_accessor :reference
    
    # Create accessors for reference-based properties
    # This allows lazy loading of properties
    PROPERTIES.each do |property|
      class_eval <<-"eval"
        def #{property}
          if !@#{property}
            fetched = @reference.#{property}.get rescue nil
            @#{property} = fetched if fetched and fetched != :missing_value
          else
            @#{property}
          end
        end
      eval
    end
    
    def initialize(properties = {})
      properties.each_pair do |property, value|
        self.send("#{property}=", value)
      end
    end
    
    # Returns whether the instance if new or has already been saved
    def new?
      id_.nil?  
    end
    
    # Save a Todo
    # If a todo is new, it will be created
    # If not, it will be updated
    def save
      if new?
        properties = {}
        (PROPERTIES - [:id_]).each do |property|
          properties[property] = self.send(property) if self.send(property)
        end
        self.reference = Things::App.instance.make(:new => :to_do, :with_properties => properties)
      else
        (PROPERTIES - [:id_]).each do |property|
          self.reference.send(property).set(self.send(property)) if self.send(property)
        end
      end
      self
    end
    
    # Delete a Todo
    # This places a Todo in the trash
    def delete
      Things::App.instance.delete(self.reference) rescue false
    end
    
    # create a new Things::Todo object based on that supplied properties and save it
    def self.create(properties)
      new(properties).save
    end
    
    # build a new Things:Todo instance and link it to the supplied reference
    # Returns a Things::Todo object associated with a reference
    def self.build(reference)
      todo = self.new
      todo.reference = reference
      todo
    end
    
    # find a todo by a name or id
    # Returns a Things::Todo object associated with a reference
    def self.find(name_or_id)
      find_by_name(name_or_id) || find_by_id(name_or_id)
    end
    
    # find a todo by a name
    # Returns a Things::Todo object associated with a reference
    def self.find_by_name(name)
      reference = Things::App.instance.todos[name].get rescue nil
      build(reference) if reference
    end

    # find a todo by a id
    # Returns a Things::Todo object associated with a reference
    def self.find_by_id(id)
      reference = Things::App.instance.todos.ID(id).get rescue nil
      build(reference) if reference
    end

  end
end