require 'active_model'
require 'active_support/core_ext/object'

# lol
class Passport
  include ActiveModel::Model
  include ActiveModel::Attributes

  with_options presence: true do
    validates :byr, inclusion: { in: 1920..2002 }
    validates :iyr, inclusion: { in: 2010..2020 }
    validates :eyr, inclusion: { in: 2020..2030 }
    validates :hcl, format: { with: /\A#[0-9a-f]{6}\z/ }
    validates :ecl, inclusion: { in: %w[amb blu brn gry grn hzl oth] }
    validates :pid, format: { with: /\A\d{9}\z/ }
  end

  validates_each :hgt do |r, attr, val|
    case (val[-2..-1] rescue '')
    when 'cm' then r.errors.add(attr, 'invalid height') unless (150..193).include?(val.to_i)
    when 'in' then r.errors.add(attr, 'invalid height') unless (59..76).include?(val.to_i)
    else r.errors.add(attr, 'invalid height')
    end
  end

  attribute :byr, :integer
  attribute :iyr, :integer
  attribute :eyr, :integer
  attribute :hgt, :string
  attribute :hcl, :string
  attribute :ecl, :string
  attribute :pid, :string
end

puts(File.read('./input.txt').split("\n\n").count do |pp|
  fields = Hash[pp.split(/[\n ]/).map { |kv| kv.split(':') }.select {|(k, _)| %w[byr iyr eyr hgt hcl ecl pid].include?(k) }]

  Passport.new(fields).valid?
end)
