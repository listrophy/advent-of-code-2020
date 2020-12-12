puts(File.foreach('./input.txt').reduce([0, 0, 10, 1]) do |(x, y, a, b), l|
  _, i, amt_s = l.match(/^(\w)(\d+)$/).to_a
  amt = amt_s.to_i
  case i
  when ?N then b += amt
  when ?S then b -= amt
  when ?E then a += amt
  when ?W then a -= amt
  when ?L then (amt / 90).times { a, b = -b, a }
  when ?R then (amt / 90).times { a, b = b, -a }
  when ?F then x, y = x + amt * a, y + amt * b
  end
  [x, y, a, b]
end.map(&:abs)[0..1].sum)
