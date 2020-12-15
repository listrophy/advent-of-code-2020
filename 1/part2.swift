import Foundation

let input: String = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
let ints = input.split(separator: "\n").map{Int($0) ?? 0}.sorted()

for a in ints {
  for b in ints[1..<ints.count] {
    for c in ints[2..<ints.count] {
      let sum = a + b + c
      if sum == 2020 {
        print(a * b * c)
        exit(0)
      }
      if sum > 2020 {
        break
      }
    }
  }
}
