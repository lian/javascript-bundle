require 'rubygems'
require 'json'

module JavascriptBundle
module Ext
  module Backend
    module Widgets
      @@widgets = {}
      def self.all; @@widgets; end
      def self.find(name); @@widgets[name]; end
      def self.add(klass,name=nil)
        name = (klass.respond_to?("name") ? klass.name.downcase : klass.id.to_s) unless name
        @@widgets[name] = { :klass => klass, :actions => self.get_handler(klass) }
      end
      def self.get_handler(klass)
        klass.methods.select { |m| m.match(/handle_/) }.collect { |i| i.gsub("handle_","").to_sym }
      rescue Exception => e
        []
      end
    end # Widgets
  end # Backend

  class ExtBase
    attr_accessor :options, :name
    def initialize(name,options); @name, @options = name, options; end
    def to_json(*args); "new #{@name}( "+@options.to_json+" )"; end
  end

  class Action < ExtBase; def initialize(options); super("Ext.Action",options); end; end
  class Window < ExtBase; def initialize(options); super("Ext.Window",options); end; end
  class Panel < ExtBase; def initialize(options); super("Ext.Panel",options); end; end
  class TabPanel < ExtBase; def initialize(options); super("Ext.TabPanel",options); end; end
  class DataView < ExtBase; def initialize(options); super("Ext.DataView",options); end; end
  class XTemplate < ExtBase; def initialize(options); super("Ext.XTemplate",options); end; end
  class FormPanel < ExtBase; def initialize(options); super("Ext.FormPanel",options); end; end

  module Data
    class Store < ExtBase; def initialize(options); super("Ext.data.Store",options); end; end
    class SimpleStore < ExtBase; def initialize(options); super("Ext.data.SimpleStore",options); end; end
    class JsonStore < ExtBase; def initialize(options); super("Ext.data.JsonStore",options); end; end
    class JsonReader < ExtBase; def initialize(options); super("Ext.data.JsonReader",options); end; end
    #class ArrayReader < ExtBase; def initialize(options); super("Ext.data.ArrayReader",options); end; end
    class ArrayReader < ExtBase
      def initialize(options); super("Ext.data.ArrayReader",options);end;
      def to_json(*args); "new #{@name}( {} , "+@options.to_json+" )"; end
    end
  end
  
  module Menu
    class Menu < ExtBase;
      def initialize(options); super("Ext.menu.Menu",options); end;
      def items; @options[:items] ||= []; end
    end
  end

  module Form
    class TextField < ExtBase; def initialize(options); super("Ext.form.TextField",options); end; end
  end
  
  module Scope
    class This; def to_json(*args);"this";end; end
  end
  
  module Grid
    class GridPanel < ExtBase; def initialize(options); super("Ext.grid.GridPanel",options); end; end
    class ColumnModel < ExtBase; def initialize(options); super("Ext.grid.ColumnModel",options); end; end
    class EditorGridPanel < ExtBase; def initialize(options); super("Ext.grid.ColumnModel",options); end; end
  end
  
  module Tree
    class TreePanel < ExtBase; def initialize(options); super("Ext.tree.TreePanel",options); end; end
    class TreeLoader < ExtBase; def initialize(options); super("Ext.tree.TreeLoader",options); end; end
    class AsyncTreeNode < ExtBase; def initialize(options); super("Ext.tree.AsyncTreeNode",options); end; end
  end

  # very basic javascript function wrapper
  class Handler < ExtBase
    def initialize(js_script); @script = js_script; end
    def to_json(*args); %{ function(){ #{@script} } }; end
  end
  Function = Handler; Fn = Handler;
  
  # plugins ..
  module Ux
    module UploadDialog
      class Dialog < ExtBase; def initialize(options); super("Ext.ux.UploadDialog.Dialog",options); end; end
    end
  end
  
end ## Ext
end ## JavascriptBundle
