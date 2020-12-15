small, large = File.foreach('./input.txt').map(&:to_i).partition {|x| x < 1010 }.map(&:sort)

small.each do |s|
  large.each do |l|
    break if s + l > 2020
    if s + l == 2020
      puts s * l
      return
    end
  end
end
