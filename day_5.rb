# https://adventofcode.com/2020/day/5

$num_rows = Array.new(128) { |i| i + 1 }
$num_columns = Array.new(8) { |i| i + 1 }

def boarding_passes
  File.new("day_5_boarding_passes.txt").readlines
end

def navigate_aisles(boarding_pass, rows, cols)
  if boarding_pass.length == 0
    if rows.length != 1 || cols.length != 1 
      puts "uh oh"
    end

    # puts "#{rows[0]}, #{cols[0]}"
    return rows[0] * 8 + cols[0]
  end

  case boarding_pass[0]
  when "F"
    navigate_aisles(boarding_pass[1..], rows.first(rows.length/2), cols)
  when "B"
    navigate_aisles(boarding_pass[1..], rows.last(rows.length/2), cols)
  when "L"
    navigate_aisles(boarding_pass[1..], rows, cols.first(cols.length/2))
  when "R"
    navigate_aisles(boarding_pass[1..], rows, cols.last(cols.length/2))
  else
    puts "where are you going?! the character here is #{boarding_pass[0]}"
  end
end

def highest_seat
  highest_seat = 0

  boarding_passes.each do |pass|
    seat_number = navigate_aisles(pass.strip, Array.new(128) { |i| i}, Array.new(8) { |i| i })
    highest_seat = seat_number if seat_number > highest_seat
  end

  highest_seat
end

def find_empty_seat
  filled_seats = []

  boarding_passes.each do |pass|
    seat_num = navigate_aisles(pass.strip, Array.new(128) { |i| i}, Array.new(8) { |i| i })
    filled_seats[seat_num] = seat_num
  end

  my_seat = []

  filled_seats.each_index do |i|
    seat = filled_seats[i]
    my_seat << i if seat.nil? && filled_seats[i - 1] && filled_seats[i + 1]
  end

  my_seat[0]
end

def main
  puts "the highest seat number... it must be #{highest_seat}" # 938
  puts "by process of elimination, i'm gonna assume my seat is #{find_empty_seat}"
end

main()