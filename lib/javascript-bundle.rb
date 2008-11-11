require 'rubygems'
require 'yaml'

module JavascriptBundle
  def self.resources_path
    File.dirname(__FILE__) + "/../resources"
  end
  def self.load(name)
    if lib = find(name)
      lib.load
    end
  end
  def self.find(name)
    res = resources.select { |i| i.name == name }
    (res.size > 0) ? res.first : nil
  end
  def self.resources
    Dir["#{JavascriptBundle.resources_path}/*"].collect { |i| JavascriptLibrary.new i }
  end
end

class JavascriptLibrary
  attr_accessor :path, :meta
  def initialize(dir_path)
    @path = dir_path
    @meta = YAML.load_file(@path+"/#{File.basename @path}.meta")
  end
  def name;@meta['name'];end
  def desc;@meta['desc'];end
  def dependencies;@meta['dependencies'];end
  def versions;@meta['versions'];end
  def latest_version;versions.last;end
  def set_env(env); @env ||= env; end
  def set_env!(env); @env = env; end

  def read_file(file_path)
    file = "#{@path}/#{file_path}"
    File.readlines(file) if File.exists?(file)
  end

  def build_require_html(file_list, path_prefix="/javascript-bundle")
    file_list.collect { |file_path|
      file_path = "#{path_prefix}/#{name}/#{latest_version}/#{file_path}"
      case File.extname file_path
        when ".js"
          %{<script src="#{file_path}" type="text/javascript"></script>}
        when ".css"
          %{<link href="#{file_path}" media="screen" rel="stylesheet" type="text/css" />}
        when ".css"
          %{<!-- #{file_path} not loaded. unknown -->}
      end
    }.join("\n")
  end

  def render_html(renderer_env=:development)
    set_env "dev"
    if @meta['env']
      if file_list = @meta['env'][@env]
        case renderer_env
        when :production
          build_require_html file_list, "js" # rewrite /javascript-bundle/ path to js/
        else
          build_require_html file_list
        end
      end
    end
  end

end

class JavascriptRequire
  def initialize
    @items = []
  end
  def list; @items.collect { |i| i.name }; end
  def items; @items; end
  def size; @items.size; end
  def add(item,env="dev")
    lib_name = item.split("/").first
    if lib = JavascriptBundle.find(lib_name)
      lib.dependencies.each { |dep| add(dep,env) unless @items.collect{ |i| i.name }.include?(dep) }
      lib.set_env(env)
      unless @items.include? lib
        @items << lib
        true
      else
        false
      end
    end  
  end
  def to_html; @items.collect { |lib| lib.render_html }.join("\n"); end
end
