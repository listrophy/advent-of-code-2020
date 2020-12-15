import Foundation

extension StringProtocol {
  subscript(offset: Int) -> Character {
    self[index(startIndex, offsetBy: offset)]
  }
}

extension Bool {
  static func ^(left: Bool, right: Bool) -> Bool {
    return !left == right
  }
}

let input: String = try! String(contentsOfFile: "./input.txt", encoding: .utf8)
let pwds = input.split(separator: "\n")
print(pwds.filter { line in
  let arr: [Substring] = line.split(whereSeparator: { [" ", ":", "-"].contains($0) }),
      min = Int(String(arr[0]))!,
      max = Int(String(arr[1]))!,
      char = Character(String(arr[2])),
      pwd = String(arr[3])
  return (pwd[min - 1] == char) ^ (pwd[max - 1] == char)
}.count)
