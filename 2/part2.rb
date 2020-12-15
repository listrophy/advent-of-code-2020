puts(File.readlines('./input.txt').count do |line|
  match = /(?<min>\d+)-(?<max>\d+) (?<char>\w): (?<pwd>\w+)/.match(line)

  min, max = match.values_at(:min, :max).map(&:to_i)
  pwd, char = match.values_at(:pwd, :char)

  (pwd[min - 1] == char) ^ (pwd[max - 1] == char)
end)
