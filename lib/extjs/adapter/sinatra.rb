require File.dirname(__FILE__) + "/../extjs.rb"

module JavascriptBundle
module Ext
module Backend
  module Sinatra
    
    def self.init
       get('/javascript-bundle-ext/:window_name/:window_action') { Backend::Sinatra.forward_extjs_request(params) }
      post('/javascript-bundle-ext/:window_name/:window_action') { Backend::Sinatra.forward_extjs_request(params) }
    end
    
    def self.forward_extjs_request(params,scope=nil)
      if win = Backend::Widgets.find(params[:window_name])
        if win[:actions].include? params[:window_action].to_sym
          begin
            win[:klass].send("handle_#{params[:window_action]}".to_sym, params, scope)
          rescue Exception => e
            puts "ERROR DISPATCHING WINDOW ACTION! :.( => #{e.inspect}"
            "ERROR IN WINDOW '#{params[:window_name]}' ACTION '#{params[:window_acion]}' !! => <br /> #{e.inspect} <br /><br />  #{e.backtrace.join("<br />")}"
          end
        else
          "// action: #{params[:window_action]} for window: #{params[:window_name]} not found"
        end
      else
        "// window: #{params[:window_name]} not found"
      end
    end

  end # Sinatra
end # Backend
end ## Ext
end ## JavascriptBundle
