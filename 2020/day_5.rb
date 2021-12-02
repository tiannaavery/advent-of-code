# https://adventofcode.com/2020/day/5

$num_rows = 128
$num_cols = 8

def boarding_passes
  @boarding_passes ||= File.new("day_5_boarding_passes.txt").readlines
end

def navigate_aisles(boarding_pass, rows, cols)
  if boarding_pass.length == 0
    if rows.length != 1 || cols.length != 1 
      puts "uh oh"
    end

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
    puts "huh?!"
  end
end

def filled_seats
  @filled_seats ||= begin
    seats = []

    boarding_passes.each do |pass|
      seat_num = navigate_aisles(pass.strip, Array.new($num_rows) { |i| i}, Array.new($num_cols) { |i| i })
      seats[seat_num] = seat_num
    end

    seats
  end
end

def highest_seat
  filled_seats.compact.max
end

def find_empty_seat
  my_seat = 0

  filled_seats.each_index do |i|
    seat = filled_seats[i]
    if seat.nil? && filled_seats[i - 1] && filled_seats[i + 1]
      my_seat = i
      break
    end
  end

  my_seat
end

def main
  puts "the highest seat number... it must be #{highest_seat}" # 938
  puts "by process of elimination, i'm gonna assume my seat is #{find_empty_seat}" #696
end

main()
