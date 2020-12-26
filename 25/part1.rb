a, b = File.foreach('./input.txt').map(&:to_i)

a_loop = 0

card_val = 1

loop do
  a_loop += 1
  card_val = card_val * 7 % 20201227
  break if card_val == a
end

door_val = 1

a_loop.times do
  door_val = door_val * b % 20201227
end

puts door_val
