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

# 一覧表示処理
server.mount_proc("/list") { |req, res|
   p req.query
   if /(.*)\.(delete|edit)$/ =~ req.query['operation']
	  target_id = $1
	  operation = $2
	  if operation == 'delete'
		 template = ERB.new(File.read('delete.erb'))
	  elsif operation == 'edit'
		 template = ERB.new(File.read('edit.erb'))
	  end
	  res.body << template.result(binding)
   else
	  template = ERB.new(File.read('noselected.erb'))
	  res.body << template.result(binding)
   end

}

# 登録処理
server.mount_proc("/entry") { |req, res|
   p req.query
   dbh = DBI.connect('DBI:SQLite3:bookinfo_sqlite.db')

   rows = dbh.select_one("select * from bookinfos where id='#{req.query['id']}';")
   if rows then
	  dbh.disconnect

	  template = ERB.new(File.read('noentried.erb'))
	  res.body << template.result(binding)
   else
	  dbh.do("insert into bookinfos values ('#{req.query['id']}', '#{req.query['title']}', '#{req.query['author']}', '#{req.query['page']}', '#{req.query['publish_date']}');")

	  dbh.disconnect

	  template = ERB.new(File.read('entried.erb'))
	  res.body << template.result(binding)
   end
}

# 検索処理
server.mount_proc("/retrieve"){ |req, res|
   p req.query

   a = ['id', 'title', 'author', 'page', 'publish_date']
   a.delete_if { |name| req.query[name]  == "" }

   if a.empty?
	  where_data = ""
   else
	  a.map! { |name| "#{name}=\'#{req.query[name]}\'" }
	  where_data = "where " + a.join(' or ')
   end

   template = ERB.new(File.read('retrieved.erb'))
   res.body << template.result(binding)
}

trap(:INT) do
   server.shutdown
end

server.start
