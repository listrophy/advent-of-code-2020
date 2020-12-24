Node = Struct.new(:val, :next)

head = nil
tail = nil

cups = '685974213'.split('').map { Node.new(_1.to_i, nil) }
head = cups.first
tail = cups.first
cups[1..-1].each do |c|
  tail.next = c
  tail = c
end

(10..1_000_000).each do |i|
  c = Node.new(i, nil)
  tail.next = c
  tail = c
end

pointers = Array.new(1_000_001)
z = head
loop do
  pointers[z.val] = z
  break if z.next.nil?
  z = z.next
end

10_000_000.times do |i|
  curr = head
  head = curr.next

  a = head
  head = a.next

  b = head
  head = b.next

  c = head
  head = c.next

  pickup = [a, b, c]
  pickup_vals = pickup.map { _1.val }

  dest = curr.val
  loop do
    dest -= 1
    dest = 1_000_000 if dest == 0
    break unless pickup_vals.include?(dest)
  end

  finder = pointers[dest]

  after_finder = finder.next
  finder.next = a
  c.next = after_finder

  tail = c if after_finder.nil?

  curr.next = nil
  tail.next = curr
  tail = curr
end

one_node = pointers[1]
a = one_node.next
b = a.next
puts a.val, b.val, (a.val)*(b.val)
