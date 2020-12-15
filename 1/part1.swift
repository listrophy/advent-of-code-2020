import Foundation

let input: String = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
let ints = input.split(separator: "\n").map{Int($0) ?? 0}.sorted()

var a = 0, z = ints.count - 1
var sum = ints[a] + ints[z]

while sum != 2020 {
  if sum < 2020 {
    a += 1
  } else {
    z -= 1
  }
  sum = ints[a] + ints[z]
}

print(ints[a] * ints[z])
