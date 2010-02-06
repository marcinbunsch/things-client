# a small hack - Things references a collection of Todos as to_dos
# here we make an alias so todos is also possible
module Appscript #:nodoc:
  class Reference #:nodoc:
    def todos
      to_dos
    end
  end
end