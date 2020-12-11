data = File.readlines('./input.txt').map(&:strip)

prev_count = 0

width = data.first.length

data = [?. * width] + data + [?. * width]
data.map! { |l| ?. + l + ?.}

width += 2

loop do
  new_data = data.map(&:dup)

  data.each_with_index do |row, i|
    row.chars.each_with_index do |cell, j|
      next if cell == ?.

      num = 0
      num += data[i-1].chars[(j-1)..(j+1)].count { _1 == ?# }
      num += 1 if data[i][j-1] == ?#
      num += 1 if data[i][j+1] == ?#
      num += data[i+1].chars[(j-1)..(j+1)].count { _1 == ?# }

      if cell == ?# && num > 3
        new_data[i][j] = ?L
      elsif cell == ?L && num == 0
        new_data[i][j] = ?#
      end
    end
  end

  count = new_data.sum {|l| l.chars.count { |c| c == ?# } }
  print ?.

  if prev_count == count
    puts count
    exit 0
  end

  prev_count = count
  data = new_data
end
