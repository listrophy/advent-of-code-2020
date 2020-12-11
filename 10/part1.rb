input = File.foreach('./input.txt').map(&:to_i).sort

input.unshift(0)

puts(input.each_cons(2).reduce([0, 1]) do |m, (a, b)|
  case b - a
  when 3 then [m[0], m[1] + 1]
  when 1 then [m[0] + 1, m[1]]
  else m
  end
end.reduce(&:*))
