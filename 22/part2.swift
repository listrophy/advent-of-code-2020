import Foundation

let file = String(data: FileManager.default.contents(atPath: "./input.txt")!, encoding: .utf8)!
let deck = file.components(separatedBy: "\n\n").map { chunk in
  chunk.split(separator: "\n").dropFirst(1).map { Int($0)! }
}

var a = deck[0],
    b = deck[1]


@discardableResult func play(_ x: inout [Int], _ y: inout [Int]) -> Int {
  var winner = 0
  var memory = Set<[[Int]]>()

  while !x.isEmpty && !y.isEmpty {
    if memory.contains([x,y]) {
      return -1
    }

    memory.insert([Array(x), Array(y)])

    let xx = x.removeFirst(),
        yy = y.removeFirst()

    if xx <= x.count && yy <= y.count {
      var subX = Array(x.prefix(xx)),
          subY = Array(y.prefix(yy))
      winner = play(&subX, &subY)
    } else {
      winner = xx > yy ? -1 : 1
    }

    if winner == -1 {
      x.append(xx)
      x.append(yy)
    } else {
      y.append(yy)
      y.append(xx)
    }
  }
  return winner
}

play(&a, &b)

let winner = [a,b].first(where: { !$0.isEmpty})!
print(zip(winner.reversed(), 1...).reduce(0, {m, a in
  let (b, c) = a
  return m + b * c
}))
