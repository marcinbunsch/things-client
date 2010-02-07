module Things
  # Things::Todo
  class Tag < Reference::Record
    
    properties :name
    # identifier is required for creation
    identifier :tag
    # collection is used for findings
    collection :tags
   
  end
end