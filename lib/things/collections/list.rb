module Things
  module Collections
    class List
      DEFAULTS = [:inbox, :today, :next, :scheduled, :someday, :projects, :logbook, :trash]
      class << self
        
        def all
          Things::App.instance.lists
        end

        DEFAULTS.each do |list|
          class_eval <<-"eval"
            def #{list}
              all['#{list.to_s.capitalize}']
            end
          eval
        end

      end
      
    end
  end
end