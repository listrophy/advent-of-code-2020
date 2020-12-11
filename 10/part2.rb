input = File.foreach('./input.txt').map(&:to_i).sort

output = [0, 0, 1]

input = [-100, -100, 0] + input

puts(input.each_cons(4) do |(a, b, c, x)|
  ao, bo, co = output.last(3)
  output << ((x - a < 4 ? ao : 0) + (x - b < 4 ? bo : 0) + (x - c < 4 ? co : 0))
end.last)
