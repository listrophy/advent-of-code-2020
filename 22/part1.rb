a, b = File.read('./input.txt').split("\n\n").map do |chunk|
  chunk.split("\n").drop(1).map(&:to_i)
end

until a.empty? || b.empty?
  aa, bb = a.shift, b.shift
  aa > bb ? a << aa << bb : b << bb << aa
end

puts([a, b].detect(&:any?).reverse.zip(1...).reduce(0) {|m,(c,i)| m + c*i})
