data = File.readlines('./input.txt').map(&:strip)

prev_count = 0

width = data.first.length

data = [?. * width] + data + [?. * width]
data.map! { |l| ?. + l + ?.}

width += 2

is_seat = ->(c) { c == ?# || c == ?L }

loop do
  new_data = data.map(&:dup)

  data.each_with_index do |row, i|
    row.chars.each_with_index do |cell, j|
      next if cell == ?.


      num = 0
      # L
      num += 1 if row[0...j].reverse.chars.find(&is_seat) == ?#
      # R
      num += 1 if row[(j+1)..-1].chars.find(&is_seat) == ?#
      # U
      num += 1 if data.map { _1[j] }[0...i].reverse.find(&is_seat) == ?#
      # D
      num += 1 if data.map { _1[j] }[(i+1)..-1].find(&is_seat) == ?#

      # UL
      ii, jj = i - 1, j - 1
      while ii > 0 && jj > 0
        if is_seat === data[ii][jj]
          num += 1 if data[ii][jj] == ?#
          break
        end
        ii -= 1
        jj -= 1
      end

      # UR
      ii, jj = i - 1, j + 1
      while ii > 0 && jj < width
        if is_seat === data[ii][jj]
          num += 1 if data[ii][jj] == ?#
          break
        end
        ii -= 1
        jj += 1
      end

      # DL
      ii, jj = i + 1, j - 1
      while ii < data.length && jj > 0
        if is_seat === data[ii][jj]
          num += 1 if data[ii][jj] == ?#
          break
        end
        ii += 1
        jj -= 1
      end

      # DR
      ii, jj = i + 1, j + 1
      while ii < data.length && jj < width
        puts({ii: ii, jj: jj, height: data.length, width: width}.inspect) if data[ii].nil?
        if is_seat === data[ii][jj]
          num += 1 if data[ii][jj] == ?#
          break
        end
        ii += 1
        jj += 1
      end

      if cell == ?# && num > 4
        new_data[i][j] = ?L
      elsif cell == ?L && num == 0
        new_data[i][j] = ?#
      end
    end
  end

  count = new_data.sum {|l| l.chars.count { |c| c == ?# } }
  print ?.

  if prev_count == count
    puts
    puts count
    exit 0
  end

  prev_count = count
  data = new_data
end
