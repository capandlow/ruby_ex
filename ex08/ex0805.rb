# -*- coding: utf-8 -*-
require 'date'

publish_date = Date.new(2005, 1, 25)
mon_name = Date::MONTHNAMES[publish_date.mon]
abbr_mon_name  = Date::ABBR_MONTHNAMES[publish_date.mon]

puts "出版年：　" + publish_date.year.to_s
puts "出版月（長い名前）：　" + mon_name.to_s
puts "出版月（短い名前）：　" + abbr_mon_name.to_s
