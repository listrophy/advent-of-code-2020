puts(File.foreach('./input.txt').map do |d|
  d.tr('FLBR', '0011').to_i(2)
end.max)
