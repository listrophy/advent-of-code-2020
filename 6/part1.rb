puts(File.read('./input.txt').split("\n\n").sum do |grp|
  grp.scan(/\w/).uniq.count
end)
