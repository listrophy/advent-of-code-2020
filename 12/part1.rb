dir = 0
puts(File.foreach('./input.txt').reduce([0, 0]) do |(x, y), l|
  _, i, amt_s = l.match(/^(\w)(\d+)$/).to_a
  amt = amt_s.to_i
  case i
  when ?N then y += amt
  when ?S then y -= amt
  when ?E then x += amt
  when ?W then x -= amt
  when ?L then dir += amt / 90
  when ?R then dir -= amt / 90
  when ?F
    case dir % 4
    when 0 then x += amt
    when 1 then y += amt
    when 2 then x -= amt
    when 3 then y -= amt
    end
  end
  [x, y]
end.map(&:abs).sum)
