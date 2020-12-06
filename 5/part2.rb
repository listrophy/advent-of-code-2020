puts(File.foreach('./input.txt').map do |d|
  d.tr('FLBR', '0011').to_i(2)
end.sort.chunk_while do |bef, aft|
  bef + 1 == aft
end.first.last + 1)

