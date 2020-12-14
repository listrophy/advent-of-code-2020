f = File.readlines('./input.txt').last

b = f.split(',').map(&:to_i).each_with_index.reject { _1.first == 0 }.sort.reverse.map do |(bus, off)|
  [bus, (bus - (off % bus)) % bus]
end

# chinese remainder theorem

i = 0
x = b[i][1]

loop do
  m = b[i+1][0]
  d = b[i+1][1]

  until x % m == d
    x += b[0..i].map(&:first).reduce(&:*)
  end

  i += 1
  break if i >= b.length - 1
end

puts x
