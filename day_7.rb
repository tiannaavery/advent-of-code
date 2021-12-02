# https://adventofcode.com/2020/day/6

def bag_rules
  File.new("day_7_bags.txt").read.split(".\n")
end

def acceptable_outer_bag_colors(rules, colors, possibilities)
  new_rules ||= []
  new_possibilities ||= []

  colors.each do |color|
    puts color
    new_rules << rules.delete_if { |rule| rule.include?("#{color} bags contain") }
    new_rules = new_rules.flatten.uniq
    new_possibilities << new_rules.select { |rule| rule.include?(color) }.map { |rule| rule.split("bags contain")[0].strip }
    new_possibilities = new_possibilities.flatten.uniq
  end

  puts "#{new_possibilities.flatten.uniq}"

  if new_possibilities.flatten.empty? || new_possibilities.flatten.uniq == possibilities.flatten.uniq
    return possibilities
  else
    acceptable_outer_bag_colors(new_rules.flatten, new_possibilities.flatten.uniq, (possibilities << new_possibilities).flatten.uniq)
  end
end

def shiny_gold_bag_options
  possibilities = acceptable_outer_bag_colors(bag_rules, ["shiny gold"], []).uniq.count
end

def main
  puts "#{shiny_gold_bag_options} bags could contain my shiny gold bag"
end

main()