mem = {}
mask = ''

File.foreach('./input.txt') do |line|
  if line =~ /^mask = (\w+)$/
    mask = $1.chars
  else
    _, addr, preval = line.match(/^mem\[(\d+)\] = (\d+)$/).to_a
    bval = preval.to_i.to_s(2).rjust(36, '0').chars
    val = bval.zip(mask).map do |b, m|
      case m
      when ?X then b
      when ?1 then '1'
      when ?0 then '0'
      end
    end.join.to_i(2)
    mem[addr] = val
  end
end

puts mem.values.sum
