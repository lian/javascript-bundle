require File.dirname(__FILE__) + "/../javascript-bundle.rb"

module JavascriptBundle
module Backend
  module Sinatra
    def self.init
      
      get "/javascript-bundle/*/*" do
        if lib = JavascriptBundle.find(params[:splat][0])
          file_path = params[:splat][1]
          
          unless file_path.empty?
            case file_path.split(".").last
            when "css"
              content_type('text/css', :charset => 'utf-8')
            when "js"
              content_type('text/javascript', :charset => 'utf-8')
            end
            lib.read_file(file_path)
          end
          
        end
      end
      
    end
  end # Sinatra
end # Backend
end ## JavascriptBundle
