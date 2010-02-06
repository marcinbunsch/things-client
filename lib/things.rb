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
  
  module Collections
    autoload :Todo, File.dirname(__FILE__) + '/things/collections/todo'
  end
  
end

