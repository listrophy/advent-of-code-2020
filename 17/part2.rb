alive = File.foreach('./input.txt').map.with_index do |line, i|
  line.chars.map.with_index do |char, j|
    [i,j,0,0] if char == ?#
  end
end.flatten(1).compact

6.times do
  seeds = Hash.new(0)
  alive.each do |(i,j,k,l)|
    (-1..1).each do |x|
      (-1..1).each do |y|
        (-1..1).each do |z|
          (-1..1).each do |a|
            next if [x, y, z, a] == [0, 0, 0, 0]
            seeds[[x+i, y+j, z+k, a+l]] += 1
          end
        end
      end
    end
  end

  alive = seeds.select do |(x,y,z,a),w|
    if alive.include?([x,y,z,a])
      w == 2 || w == 3
    else
      w == 3
    end
  end.keys
end

puts alive.count
