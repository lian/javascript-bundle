require File.dirname(__FILE__) + '/spec_helper.rb'
require File.dirname(__FILE__) + '/../lib/extjs/extjs.rb'

Ext = JavascriptBundle::Ext

describe Ext::ExtBase do
  it "should know it's name" do
    @extbase = Ext::ExtBase.new("Ext.Action", {} )
    @extbase.name.should == "Ext.Action"
  end
  it "should have a hash of options" do
    @extbase = Ext::ExtBase.new("Ext.Action", { :text => 'foo' } )
    @extbase.options.should == { :text => 'foo' }
    @extbase.options.to_json.should == '{"text":"foo"}'
  end
  it "to_json returns class with options as javascript" do
    @extbase = Ext::ExtBase.new("Ext.Action", { :text => 'foo' } )
    @extbase.to_json.should == 'new Ext.Action( {"text":"foo"} )'
  end
end

describe Ext::Scope::This do
  it "to_json returns scope variable as javascript" do
    Ext::Scope::This.new.to_json.should == "this"
  end
end

describe Ext::Handler do
  it "inherited from ExtBase" do
    Ext::Handler.new("").class.superclass.should == Ext::ExtBase
  end
  it "to_json returns a plain javascript function" do
    Ext::Handler.new("").to_json.should == " function(){  } "
  end
end

describe Ext::Menu::Menu do
  before(:each) do
    @menu = Ext::Menu::Menu.new( {} )
  end
  it "inherited from ExtBase" do
    @menu.class.superclass.should == Ext::ExtBase
  end
  it "should have a items list" do
    @menu.options[:items].should == nil
    @menu.items.size.should == 0
  end
  it "should be able to add items" do
    @menu.items.size.should == 0
    @menu.items << { :text => "foo" }
    @menu.items.size.should == 1
    @menu.items << { :text => "bar" }
    @menu.items.size.should == 2
  end
end
