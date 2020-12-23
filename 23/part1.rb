require 'byebug'

# between
# 80763452
# 87456329

cups = '685974213'.split('').map(&:to_i)

100.times do |i|
  curr = cups[0]
  pickup = cups[1..3]
  cups = [cups[0]] + cups[4..-1]

  dest = curr
  loop do
    dest -= 1
    dest = 9 if dest == 0
    break unless pickup.include?(dest)
  end

  cups.insert(cups.index(dest) + 1, *pickup)
  s = cups.shift
  cups.push s
end

puts (cups + cups).join.match(/1(.{8})/)[1]
