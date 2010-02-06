require 'rubygems'
require 'lib/things'


puts Things::App.instance.to_dos.get.inspect
#Things::Todo.new(:name => 'fooo', :notes => 'yippie').save

#puts Things::Todo.find_by_name('test')
#puts Things::Todo.find_by_name('rails')
#puts Things::Todo.find_by_name('Rails')

#todo.edit
#things.make('to_do')
#puts things.to_dos.methods.sort.join("\n")

#puts things.windows.first.visible?
#puts things.windows.first.visible=true