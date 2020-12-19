ruleset, input = File.read('./input.txt').split("\n\n")

rules = Hash[ruleset.strip.split("\n").map do |line|
  idx, rule = line.split(": ")
  if rule.include? '"'
    [idx.to_i, rule.strip.tr('"', '')]
  else
    [idx.to_i, rule.split("|").map { |subrule| subrule.split(" ").map(&:to_i) }]
  end
end]

def recurse(idx, rules, rcount = nil)
  node = rules[idx]
  if idx == 8
    '(' + recurse(42, rules) + ')+'
  elsif idx == 11
    if rcount.nil?
      recurse(11, rules, rcount = 3)
    elsif rcount == 0
      recurse(42, rules) + recurse(31, rules)
    else
      '(' + recurse(42, rules) + recurse(11, rules, rcount - 1) + recurse(31, rules) +
        '|' + recurse(42, rules) + recurse(31, rules) + ')'
    end
  elsif node.is_a?(Array)
    '(' + (node.map do |subnode|
      subnode.map { recurse(_1, rules) }.join('')
    end.join('|')) + ')'
  else
    node
  end
end

one_rule = Regexp.new("^#{recurse(0, rules)}$")

puts(input.split("\n").count do |line|
  one_rule.match?(line)
end)
