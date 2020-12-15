puts(File.readlines('./input.txt').count do |line|
  match = /(?<min>\d+)-(?<max>\d+) (?<char>\w): (?<pwd>\w+)/.match(line)
  min, max = match.values_at(:min, :max).map(&:to_i)
  (min..max).include?(match[:pwd].chars.select{|c| c == match[:char]}.count)
end)
