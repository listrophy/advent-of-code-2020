fields, _, nearby = File.read('./input.txt').split("\n\n")

ranges = fields.scan(/\b(\d+)\-(\d+)\b/).map {|(a,b)| (a.to_i)..(b.to_i)}

puts(nearby.split("\n").drop(1).map do |line|
  line.split(",").map(&:to_i).reject do |entry|
    ranges.any? {|range| range.include? entry }
  end
end.flatten.reduce(&:+))
