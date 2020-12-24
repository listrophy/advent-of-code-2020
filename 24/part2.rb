require 'set'

inp = File.readlines('./input.txt')

flips = inp.map do |line|
  line.strip.chars.reduce([0,0]) do |m, c|
    if m.length == 2
      if c == ?e
        [m[0] + 1, m[1]]
      elsif c == ?w
        [m[0] - 1, m[1]]
      else
        m << c
      end
    else
      last = m.pop
      case "#{last}#{c}"
      when "ne" then [m[0], m[1] + 1]
      when "se" then [m[0] + 1, m[1] - 1]
      when "nw" then [m[0] - 1, m[1] + 1]
      when "sw" then [m[0], m[1] - 1]
      end
    end
  end
end

flips = Set.new(flips.tally.map {|(k,v)| v.odd? ? k : nil}.compact)

vec = [
  [1,0],
  [0,1],
  [-1,1],
  [-1,0],
  [0,-1],
  [1,-1]
]

def dotsum(a, b)
  a.zip(b).map(&:sum)
end

100.times do |i|
  seeds = Set.new(flips.flat_map do |seed|
    [seed] + vec.map {|v| dotsum(v, seed)}
  end)

  flips = seeds.keep_if do |seed|
    count = vec.count {|v| flips.include?(dotsum(v,seed))}
    (flips.include?(seed) ? (1..2) : 2) === count
  end
end


puts "act: #{flips.flatten.count { _1 }}"
puts "exp: 4012"
