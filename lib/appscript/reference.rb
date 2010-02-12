# a small hack - Things references a collection of Todos as to_dos
# here we make an alias so todos is also possible
module Appscript #:nodoc:
  class Reference #:nodoc:
    def todos
      to_dos
    end
    
    def identify
      name = self.to_s.match(/Things.app"\)\.([^\.]*)/)[1]
    
      begin
        name = name.gsub('_', '')
        # inflections
        name = 'persons' if name == 'people'
        Things.const_get(name.capitalize[0..-2]) 
      rescue NameError
        nil
      end
    end
    
  end
end