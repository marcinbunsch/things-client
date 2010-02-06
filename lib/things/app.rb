module Things
  class App
    extend Appscript
    # get the singleton Application instance
    def self.instance
      @things ||= app('Things')
    end
    
    # refresh the Application instance
    def self.instance!
      @things = app('Things')
    end
    
    # get a collection of Lists
    def self.lists
      List
    end
    
    # get a collection of Todos
    def self.todos
      Collections::Todo
    end
    
    # activate the app and bring it to front
    def self.activate
      instance!.activate
    end
    
  end
end