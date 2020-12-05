puts(File.read('./input.txt').split("\n").map do |data|
  data.tr('FL', '0').tr('BR', '1').to_i(2)
end.max)

