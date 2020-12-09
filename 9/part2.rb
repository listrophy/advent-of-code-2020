input = File.foreach('./input.txt').map(&:to_i)

output = input.map.with_index do |a, idx|
  input[([0, idx - 24].max)...idx].map { |b| a + b }
end.flatten

invalid = (input[25..-1] - (output & input[25..-1])).first

result = catch(:done) do
  input.each_with_index do |a, i|
    input.drop(i).each_with_index.reduce(0) do |m, (b, j)|
      m += b
      throw(:done, input.drop(i).take(j).minmax.sum) if m == invalid
      break if m > invalid
      m
    end
  end
end

puts result
