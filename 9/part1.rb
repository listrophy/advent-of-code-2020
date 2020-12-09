input = File.foreach('./input.txt').map(&:to_i)

output = input.map.with_index do |a, idx|
  input[([0, idx - 24].max)...idx].map { |b| a + b }
end.flatten

puts(input[25..-1] - (output & input[25..-1]))
