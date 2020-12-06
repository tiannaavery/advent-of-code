# https://adventofcode.com/2020/day/4

def passports
  File.new("day_4_passports.txt").read.split("\n\n").map { |passport| passport.split(/\s/).map { |p| p.split(/:/) }.to_h }
end

def validate_passports
  valid_passports = 0

  expected_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].freeze

  passports.each do |passport|
    valid_passports += 1 if expected_fields.all? { |expected| passport.keys.include? expected }
  end

  valid_passports
end

def stricter_validate_passports
  valid_passports = 0

  # regular expressions and i became better acquaintances today :)
  validated_fields = { 
    "byr" => /^(19[2-9][0-9]|200[0-2])$/, # 1920 - 2002
    "iyr" => /^(201[0-9]|2020)$/, # 2010 - 2020
    "eyr" => /^(202[0-9]|2030)$/, # 2020 - 2030
    "hgt" => /^(1[5-8][0-9]cm|19[0-3]cm|59in|6[0-9]in|7[0-6]in)$/, # 150-193cm or 59-76in
    "hcl" => /^#\h{6}$/, # #abc123
    "ecl" => /^(amb|blu|brn|gry|grn|hzl|oth)$/, # amb blu brn gry grn hzl oth
    "pid" => /^\d{9}$/ # 000000000
  }

  passports.each do |passport|
    valid_passports += 1 if validated_fields.all? { |field, validation| passport.keys.include?(field) && passport[field].match?(validation) }
  end

  valid_passports
end

def main
  puts "maybe there are #{validate_passports} valid passports" #192
  puts "but when things get stricter, there are #{stricter_validate_passports} valid passports" #101
end

main()
