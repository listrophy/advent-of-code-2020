require 'rake'

answer = []
File.readlines('./input.txt').each do |line|
  source, dests = line.strip.split(' bags contain ')
  task source
  next if dests =~ /no other bags/
  dests.split(', ').map {|d| d.match(/\d+ (.*) bags?\.?/)[1] }.each do |dest|
    task dest => source do
      answer << source
    end
  end
end

Rake::Task['shiny gold'].invoke

puts answer.uniq.count
