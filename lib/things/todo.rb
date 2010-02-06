module Things
  # Things::Todo
  class Todo < Reference::Base
    
    properties :name, :notes, :completion_date
    identifier :to_do
    collection :todos
   
  end
end