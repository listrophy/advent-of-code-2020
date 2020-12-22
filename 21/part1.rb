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

puts(full_list.count {|ing| !alls.include?(ing) })
