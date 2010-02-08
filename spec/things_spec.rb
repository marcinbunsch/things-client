require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Things" do

  it "should load appropriate classes and modules" do
    lambda do
      Things::App
      Things::Todo
      Things::List
      Things::Status
      Things::Area
      Things::Project
      Things::Tag
      Things::Person
    end.should_not raise_error(NameError)
  end
  
end
