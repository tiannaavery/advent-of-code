# https://adventofcode.com/2020/day/2

def find_frequency_valid_passwords
  valid_passwords = 0

  password_info = File.new("day_2_passwords.txt")

  password_info.readlines.each do |password_info|
    password_info = password_info.split(" ")
    treasured_char = password_info[1].delete(":")
    minimum = password_info[0].split("-")[0].to_i
    maximum = password_info[0].split("-")[1].to_i
    password = password_info[2]

    valid_passwords += 1 if password.count(treasured_char) <= maximum && password.count(treasured_char) >= minimum
  end

  valid_passwords
end

def find_positionally_valid_passwords
  valid_passwords = 0

  password_info = File.new("day_2_passwords.txt")

  password_info.readlines.each do |password_info|
    password_info = password_info.split(" ")
    treasured_char = password_info[1].delete(":")
    first_position = password_info[0].split("-")[0].to_i - 1
    second_position = password_info[0].split("-")[1].to_i - 1
    password = password_info[2]

    valid_passwords += 1 if (password[first_position] == treasured_char) ^ (password[second_position] == treasured_char)
  end

  valid_passwords
end

puts "there are *probably* #{find_frequency_valid_passwords} valid passwords, you beautiful being!"
puts "just kidding, now #{find_positionally_valid_passwords} of them are valid"