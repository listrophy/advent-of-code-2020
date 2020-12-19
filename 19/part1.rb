ruleset, input = File.read('./input.txt').split("\n\n")

rules = Hash[ruleset.strip.split("\n").map do |line|
  idx, rule = line.split(": ")
  if rule.include? '"'
    [idx.to_i, rule.strip.tr('"', '')]
  else
    [idx.to_i, rule.split("|").map { |subrule| subrule.split(" ").map(&:to_i) }]
  end
end]

def recurse(node, rules)
  if node.is_a?(Array)
    '(' + (node.map do |subnode|
      subnode.map { recurse(rules[_1], rules) }.join('')
    end.join('|')) + ')'
  else
    node
  end
end

one_rule = Regexp.new("^#{recurse(rules[0], rules)}$")

puts(input.split("\n").count do |line|
  one_rule.match?(line)
end)
