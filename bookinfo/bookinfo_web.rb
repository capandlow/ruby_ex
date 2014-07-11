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

server.mount_proc("/list") { |req, res|
   p req.query
   if /(.*)\.(delete|edit)$/ =~ req.query['operation']
	  target_id = $1
	  operation = $2
	  if operation == 'delete'
		 templete = ERB.new(File.read('delete.erb'))
	  elsif operation == 'edit'
		 templete = ERB.new(Fire.read('edit.erb'))
	  end
	  res.body << templete.result(binding)
   else
	  templete = ERB.new(Fire.read('noselected.erb'))
	  res.body << templete.result(binding)
   end

}

trap(:INT) do
   server.shutdown
end

server.start
