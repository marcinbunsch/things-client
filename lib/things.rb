require 'appscript'
require "#{File.dirname(__FILE__)}/appscript/reference"
#
# Things is a client for the Mac OS X GTD app Things
#
# It uses AppleScript to gain access to the Things scripting API
#
module Things
  autoload :App, File.dirname(__FILE__) + '/things/app'
  autoload :Todo, File.dirname(__FILE__) + '/things/todo'
  autoload :List, File.dirname(__FILE__) + '/things/list'
  autoload :Status, File.dirname(__FILE__) + '/things/status'
  autoload :Area, File.dirname(__FILE__) + '/things/area'
  autoload :Project, File.dirname(__FILE__) + '/things/project'
  autoload :Tag, File.dirname(__FILE__) + '/things/tag'
  autoload :Person, File.dirname(__FILE__) + '/things/person'
  
  module Collections
    autoload :Todo, File.dirname(__FILE__) + '/things/collections/todo'
  end
  
  module Reference
    autoload :Base, File.dirname(__FILE__) + '/things/reference/base'
    autoload :Inheritance, File.dirname(__FILE__) + '/things/reference/inheritance'
    autoload :Record, File.dirname(__FILE__) + '/things/reference/record'
  end
  
end

