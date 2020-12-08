original_inss = File.foreach('./input.txt').to_a

seen = []
next_ins = 0
acc = 0

def twiddle(orig, &blk)
  orig.each_with_index do |line, idx|
    next if line.start_with?('acc')
    ret = blk.call(orig.map.with_index do |l, i|
      if i == idx
        z = l.dup
        z[0..2] = l.start_with?('nop') ? 'jmp' : 'nop'
        z
      else
        l
      end
    end)
    break if ret
  end
end

twiddle(original_inss) do |inss|
  seen = []
  next_ins = 0
  acc = 0
  while !seen.include?(next_ins) && next_ins < inss.length
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
  next_ins == inss.length
end

puts acc
