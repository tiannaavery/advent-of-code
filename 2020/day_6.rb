# https://adventofcode.com/2020/day/6

def groups
  File.new("day_6_group_responses.txt").read.split("\n\n")
end

def count_any_yeses
  groups.map { |group| group.gsub(/\s/, "").chars.uniq.count }.sum
end

def count_all_yeses
  groups.map do |group|
    yes_count = 0
    num_people = group.split(/\s/).count
    yes_responses = group.gsub(/\s/, "").chars.uniq.map { |c| group.count(c) }

    yes_responses.each { |yes| yes_count += 1 if yes == num_people }
    
    yes_count
  end.sum
end

def main
  puts "#{count_any_yeses} instances where anyone in the a responded yes to a question" # 6351
  puts "#{count_all_yeses} instances where everyone in a group responded yes to a question" # 3143
end

main()
