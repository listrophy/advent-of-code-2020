time_txt, bus_txt = File.readlines('./input.txt')


time = time_txt.to_i
buses = bus_txt.split(',').reject { _1 == 'x' }.map do |b|
  bi = b.to_i
  [bi, (bi - (time % bi))]
end

puts buses.min_by(&:last).reduce(&:*)
