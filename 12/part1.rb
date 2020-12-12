require 'complex'

I = Complex::I

puts(File.foreach('./input.txt').reduce([Complex(0, 0), 1]) do |(n, dir), l|
  _, i, amt_s = l.match(/^(\w)(\d+)$/).to_a
  amt = amt_s.to_i
  case i
  when ?N then n += amt * I
  when ?S then n -= amt * I
  when ?E then n += amt
  when ?W then n -= amt
  when ?L then (amt / 90).times { dir *= I }
  when ?R then (amt / 90).times { dir *= -I }
  when ?F then n += amt * dir
  end
  [n, dir]
end[0].rect.map(&:abs).sum)
