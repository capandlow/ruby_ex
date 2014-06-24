# -*- coding: utf-8 -*-

friends = {
   :shin => "Shin Kuboaki",
   :shinichirou => "Shinichirou Ooba",
   :shingo => "Shingo Katori"
}

friends.each_key { |key|
   puts "#{key}"
}

friends.each_value { |value|
   puts "#{value}"
}
