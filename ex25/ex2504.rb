# -*- coding: utf-8 -*-
require 'webrick'
require 'date'

config = {
   :Port => 8099,
   :DocumentRoot => '.'
}

server = WEBrick::HTTPServer.new(config)

server.mount_proc("/testprog") { |req, res|

   res.body << "<html><head><meta charset='utf-8'></head><body><p>アクセスした日付は#{Date.today.to_s}です。</p>"
   res.body << "<p>リクエストのパスは#{req.path}でした。"
   res.body << "<ul>"
   req.each { |key, value|
	  res.body << "<li>#{key}:  #{value}</li>"
   }
   res.body << "</ul>"
   res.body << "</body></html>"
}




trap(:INT) do
   server.shutdown
end

server.start
