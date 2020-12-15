File.foreach('./input.txt').map(&:to_i).sort.permutation(3).each do |(a,b,c)|
  if a + b + c == 2020
    puts(a*b*c)
    return
  end
end
