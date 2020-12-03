puts(File.foreach('./input.txt', chomp: true).with_index.reduce(0) do |m, (line, idx)|
  m + (line[idx * 3 % line.length] == '#' ? 1 : 0)
end)
