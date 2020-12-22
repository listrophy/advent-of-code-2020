require 'byebug'

allergens = Hash.new { [] }
full_list = []
orig = {}

File.foreach('./input.txt') do |line|
  ing_list, aller_list = line.tr(')', '').split(' (contains ')
  ings = ing_list.split(' ')
  aller_list.split(', ').map(&:strip).each do |aller|
    allergens[aller] = allergens[aller] + [ings]
  end
  full_list += ings
end

allergens.transform_values! do |lists|
  lists.reduce(&:&)
end

alls = allergens.values.flatten.uniq

flipped = Hash.new() { [] }
answer = {}

allergens.each do |allergen, ing_list|
  ing_list.each do |ing|
    flipped[ing] = flipped[ing] + [allergen]
  end
end

until flipped.empty?
  solo, rest = flipped.partition {|(k,v)| v.count == 1}
  solo.each do |(ing, all_list)|
    answer[all_list.first] = ing
  end
  found = solo.map(&:last).flatten
  flipped = Hash[rest].transform_values {|v| v - found }
end

puts answer.sort.map(&:last).join(",")
