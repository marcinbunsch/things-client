module Things
  # Things::Todo
  class Project < Reference::Record
    
    properties :name
    # identifier is required for creation
    identifier :project
    # collection is used for findings
    collection :projects
   
  end
end