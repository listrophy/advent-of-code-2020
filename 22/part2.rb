require 'set'

a, b = File.read('./input.txt').split("\n\n").map do |chunk|
  chunk.split("\n").drop(1).map(&:to_i)
end

def play(x, y)
  winner = nil
  memory = Set.new

  until x.empty? || y.empty?
    return :x if memory.include?([x,y])

    memory << [x.dup, y.dup]
    xx, yy = x.shift, y.shift

    winner =
      if xx <= x.length && yy <= y.length
        play(x.take(xx), y.take(yy))
      else
        xx > yy ? :x : :y
      end

    winner == :x ? x << xx << yy : y << yy << xx
  end

  winner
end

play(a, b)

puts([a, b].detect(&:any?).reverse.zip(1...).reduce(0) {|m,(c,i)| m + c*i})
