mem = {}
mask = ''

File.foreach('./input.txt') do |line|
  if line =~ /^mask = (\w+)$/
    mask = $1.chars
  else
    _, preaddr, val = line.match(/^mem\[(\d+)\] = (\d+)$/).to_a
    baddr = preaddr.to_i.to_s(2).rjust(36, '0').chars
    addr = baddr.zip(mask).map do |(a, k)|
      case k
      when ?X then ?X
      when ?1 then '1'
      when ?0 then a
      end
    end
    addrs = [addr.join]
    while addrs[0].include?('X')
      addrs = addrs.map do |a|
        idx = a.index('X')
        [(a[0...idx] + '0' + a[(idx+1)..-1]),
         (a[0...idx] + '1' + a[(idx+1)..-1])]
      end.flatten
    end
    puts addrs.inspect
    addrs.each do |a|
      mem[a.to_i(2)] = val.to_i
    end
  end
end

puts mem.values.sum
