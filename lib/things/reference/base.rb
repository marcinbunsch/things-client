module Things
  # Things::Reference
  module Reference

    class Base
      
      attr_accessor :reference
      
      extend Inheritance
        
      inheritable_attributes :_properties, :identifier, :collection
  
      def self.identifier(name = nil)
        name ? @identifier = name : @identifier
      end

      def self.collection(name = nil)
        name ? @collection = name : @collection
      end
      
      def self.properties(*args)
        @_properties = [] if !@_properties
        if args
          @_properties += args
          @_properties.each do |property|
            attr_writer(property) if !instance_methods.include?(property.to_s)
            if !instance_methods.include?(property.to_s )
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
          end
        end
      end
      # :id_ is always present
      properties :id_          
  
      def initialize(props = {})
        props.each_pair do |property, value|
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
          (self.class.properties - [:id_]).each do |property|
            properties[property] = self.send(property) if self.send(property)
          end
          self.reference = Things::App.instance.make(:new => self.class.identifier, :with_properties => properties)
        else
          (self.class.properties - [:id_]).each do |property|
            self.reference.send(property).set(self.send(property)) if self.send(property)
          end
        end
        self
      end
      
      # Delete a object
      # This places the object in the trash
      def delete
        Things::App.instance.delete(self.reference) rescue false
      end

      # create a new object based on that supplied properties and saves it
      def self.create(props)
        new(props).save
      end

      # build a new instance and link it to the supplied reference
      # Returns a object associated with a reference
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
        reference = Things::App.instance.send(self.collection)[name].get rescue nil
        build(reference) if reference
      end

      # find a todo by a id
      # Returns a Things::Todo object associated with a reference
      def self.find_by_id(id)
        reference = Things::App.instance.send(self.collection).ID(id).get rescue nil
        build(reference) if reference
      end
      
      
    end
    
  end
  
end