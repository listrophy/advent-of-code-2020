import Foundation

class Node {
    let val: Int
    var next: Node?

    init(val: Int, next: Node?) {
        self.val = val
        self.next = next
    }
}

var cups = [Node]()
for c in "685974213" {
    cups.append(Node(val: Int("\(c)")!, next: nil))
}

var head: Node = cups[0]
var tail: Node = cups[0]

for c in cups.dropFirst() {
    tail.next = c
    tail = c
}

for i in (10...1000000) {
    let c = Node(val: i, next: nil)
    tail.next = c
    tail = c
}

var pointers: [Node] = Array(repeating: head, count: 1000001)

var z = head
while true {
    pointers[z.val] = z
    if let n = z.next {
        z = n
    } else {
        break
    }
}

for _ in (1...10000000) {
    let curr = head
    head = curr.next!

    let a = head
    head = a.next!

    let b = head
    head = b.next!

    let c = head
    head = c.next!

    let pickup = [a, b, c]
    let pickup_vals = pickup.map { n in n.val }

    var dest = curr.val
    while true {
        dest -= 1
        if dest == 0 {
            dest = 1000000
        }
        if !pickup_vals.contains(dest) {
            break
        }
    }

    let finder = pointers[dest]

    let after_finder = finder.next
    finder.next = a
    c.next = after_finder

    if after_finder == nil {
        tail = c
    }

    curr.next = nil
    tail.next = curr
    tail = curr
}

let one_node = pointers[1]
let a = one_node.next!
let b = a.next!

print(a.val)
print(b.val)
print(a.val * b.val)
