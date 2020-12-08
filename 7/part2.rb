
$answer = {}
File.readlines('./input.txt').each do |line|
  source, dests = line.strip.split(' bags contain ')
  next if dests =~ /no other bags/
  dests.split(', ').map {|d| d.match(/^(\d+) (.*) bags?\.?/) }.each do |m|
    m[1].to_i.times do
      $answer[source] ||= []
      $answer[source].append(m[2])
    end
  end
end

def recurse(node)
  return 0 unless $answer[node]
  $answer[node].count + $answer[node].sum {|n| recurse(n) }
end

puts recurse('shiny gold')
