# -*- coding: utf-8 -*-
class Student
   def initialize(name, age)
	  @name = name
	  @age = age
   end

   def to_s
	  "#@name, #@age"
   end
end

shin = Student.new('久保秋　真', 45)
hiroshi = Student.new('久保秋　博', 41)

puts shin.to_s
puts hiroshi.to_s
