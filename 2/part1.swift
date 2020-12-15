import Foundation

let input: String = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
let pwds = input.split(separator: "\n")
print(pwds.filter { line in
  let arr: [Substring] = line.split(whereSeparator: { [" ", ":", "-"].contains($0) }),
      min = Int(String(arr[0]))!,
      max = Int(String(arr[1]))!,
      char = Character(String(arr[2])),
      pwd = arr[3],
      count = pwd.reduce(0, { m, c in m + (c == char ? 1 : 0) })
  return min <= count && count <= max
}.count)
