puts(File.read('./input.txt').split("\n\n").count do |pp|
  fields = Hash[pp.split(/[\n ]/).map { |kv| kv.split(':') }]
  fields.default = ''

  (1920..2002).include?(fields['byr'].to_i) &&
    (2010..2020).include?(fields['iyr'].to_i) &&
    (2020..2030).include?(fields['eyr'].to_i) &&
    (
      fields['hgt'].end_with?('cm') && (150..193).include?(fields['hgt'].to_i) or
      fields['hgt'].end_with?('in') && (59..76).include?(fields['hgt'].to_i)
    ) &&
    fields['hcl'].match(/^#[0-9a-f]{6}$/) &&
    %w[amb blu brn gry grn hzl oth].include?(fields['ecl']) &&
    fields['pid'].match(/^\d{9}$/)
end)
