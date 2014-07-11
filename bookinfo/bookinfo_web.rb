# -*- coding: utf-8 -*-
require 'webrick'
require 'erb'
require 'rubygems'
require 'dbi'

class String
   alias_method(:orig_concat, :concat)
   def concat(value)
	  if RUBY_VERSION > "1.9"
		 orig_concat value.force_encoding('UTF-8')
	  else
		 orig_concat value
	  end
   end
end

config = {
   :Port => 8099,
   :DocumentRoot => '.'
}

WEBrick::HTTPServlet::FileHandler.add_handler("erb", WEBrick::HTTPServlet::ERBHandler)

server = WEBrick::HTTPServer.new(config)

server.config[:MimeTypes]["erb"] = "text/html"

trap(:INT) do
   server.shutdown
end

server.start
