reqd = %w[byr iyr eyr hgt hcl ecl pid]

puts(File.read('./input.txt').split("\n\n").count do |pp|
  reqd & pp.split(/[\n ]/).map { |kv| kv.split(':').first } == reqd
end)
