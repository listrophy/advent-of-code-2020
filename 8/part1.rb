inss = File.foreach('./input.txt').to_a

seen = []
next_ins = 0
acc = 0

until seen.include?(next_ins)
  seen << next_ins
  ins = inss[next_ins]
  if ins =~ /^acc ([\+-]\d+)$/
    acc += $1.to_i
    next_ins += 1
  elsif ins =~ /^jmp ([\+-]\d+)$/
    next_ins += $1.to_i
  else
    next_ins += 1
  end
end

puts acc
