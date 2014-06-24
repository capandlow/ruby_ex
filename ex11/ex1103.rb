# -*- coding: utf-8 -*-

friends = {
   :shin => "Shin Kuboaki",
   :shinichirou => "Shinichirou Ooba",
   :shingo => "Shingo Katori"
}

friends[:shinsaku] = "Shinsaku Takasugi"

puts friends.include?(:shinsaku)
puts friends[:shinsaku]

friends.delete(:shinsaku)

if friends.include?(:shinsaku) then
   puts friends[:shinsaku]
else
   puts "見つかりません"
end
