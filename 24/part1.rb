flips = File.readlines('./input.txt').map do |line|
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

puts(flips.tally.count {|_,v| v.odd? })
