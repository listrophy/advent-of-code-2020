fields, mine, nearby = File.read('./input.txt').split("\n\n")

ranges = fields.scan(/\b(\d+)\-(\d+)\b/).map {|(a,b)| (a.to_i)..(b.to_i)}

tickets = nearby.split("\n").drop(1).map do |line|
  line.split(",").map(&:to_i)
end

valid = tickets.select do |tkt|
  tkt.all? do |entry|
    ranges.any? {|range| range.include? entry }
  end
end

columns = valid.transpose

field_hash = Hash[fields.split("\n").drop(1).map do |line|
  name, aa, ab, ba, bb = line.match(/^(.+): (\d+)\-(\d+) or (\d+)\-(\d+)$/).to_a.drop(1)
  [name, [(aa.to_i)..(ab.to_i), (ba.to_i)..(bb.to_i)]]
end]

search = columns.map.with_index do |column, idx|
  [idx, field_hash.select do |key, rs|
    column.all? do |field|
      rs.any? do |range|
        range.include?(field)
      end
    end
  end.keys]
end.sort_by {|(_, ks)| ks.length}

result = {}
until search.empty?
  results, search = search.partition {|(_, ks)| ks.length == 1}
  results.each do |(idx, (name))|
    result[idx] = name
    search.map! do |(i, names)|
      [i, names.reject {|n| n == name}]
    end
  end
end

my_ticket = mine.split("\n").last.split(",").map(&:to_i)

keys = result.select {|_, v| v.start_with? 'departure' }.keys

puts my_ticket.values_at(*keys).reduce(&:*)
