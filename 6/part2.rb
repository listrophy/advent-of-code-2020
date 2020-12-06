puts(File.read('./input.txt').split("\n\n").sum do |grp|
  grp.split("\n").map(&:chars).reduce(&:&).count
end)
