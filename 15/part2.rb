
e = Enumerator.new do |y|
  start = [0,3,1,6,7,5]
  said = Hash.new { [] }
  last_spoken = 0
  count = 0

  until start.empty?
    last_spoken = start.shift
    said[last_spoken] += [count]
    y << last_spoken
    count += 1
  end

  loop do
    next_spoken = said[last_spoken][-2]
    if next_spoken
      next_spoken = said[last_spoken][-1] - next_spoken
    else
      next_spoken = 0
    end
    said[next_spoken] = [said[next_spoken].last, count]
    y << next_spoken
    count += 1
    last_spoken = next_spoken
  end
end

puts e.take(30000000).last
