require File.dirname(__FILE__) + '/spec_helper.rb'
require File.dirname(__FILE__) + '/../lib/javascript-bundle.rb'

describe JavascriptBundle do
  it "should find and include resources" do
    JavascriptBundle.resources.class.should == Array
    JavascriptBundle.resources.size.should > 0
    found_framework_names = JavascriptBundle.resources.collect { |f| f.name }
    ["extjs","ruby-js","jquery"].each do |name|
      found_framework_names.include?(name).should == true
    end
  end
end

describe JavascriptLibrary do
  describe "#deploy_to" do
    before(:each) do
      @tmp_dir = "/tmp/rspec_webmate_deploy"
      Dir.mkdir(@tmp_dir) unless File.exists?(@tmp_dir)
    end
    it "should deploy latest version of resource to target_dir" do
      if lib = JavascriptBundle.find("jquery")
        jquery_file = "#{@tmp_dir}/#{lib.name}/#{lib.latest_version}/jquery-min.js"
        lib.deploy_to(@tmp_dir).should == true
        File.exists?(jquery_file).should == true
      end
    end
  end
end

describe JavascriptRequire do
  before(:each) do
    @js = JavascriptRequire.new
  end

  it "should be empty when created" do
    @js.size.should == 0
  end

  it "should add resource" do
    @js.add("extjs").should == true
    @js.list.should == [ 'extjs' ]
  end

  it "should not add resource when not found" do
    @js.add("missing_library").should == nil
    @js.list.should == [ ]
  end

  it "should add resources when found" do
    @js.add("extjs").should == true
    @js.list.should == [ 'extjs' ]
    @js.add("ruby-js").should == true
    @js.list.should == [ 'extjs', 'ruby-js' ]
    @js.add("missing_library").should == nil
    @js.list.should == [ 'extjs', 'ruby-js' ]
  end
  
  it "should require dependencies" do
    @js.add("ruby-js").should == true
    @js.list.should == [ 'extjs', 'ruby-js' ]
    @js.items[0].dependencies.should == [ ]
    @js.items[1].dependencies.should == [ "extjs" ]
  end

  it "returns to_html" do
    res1 = "<link href=\"/javascript-bundle/extjs/2.2/resources/css/ext-all.css\" media=\"screen\" rel=\"stylesheet\" type=\"text/css\" />\n<script src=\"/javascript-bundle/extjs/2.2/adapter/ext-base.js\" type=\"text/javascript\"></script>\n<script src=\"/javascript-bundle/extjs/2.2/ext-core.js\" type=\"text/javascript\"></script>\n<script src=\"/javascript-bundle/extjs/2.2/ext-all.js\" type=\"text/javascript\"></script>"
    res2 = "\n<script src=\"/javascript-bundle/ruby-js/trunk/ruby-js.js\" type=\"text/javascript\"></script>"
    @js.add("extjs").should == true
    @js.to_html.should == res1
    @js.add("ruby-js").should == true
    @js.to_html.should == res1+res2
  end
  
end
