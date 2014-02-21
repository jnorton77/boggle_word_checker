# TESTS

puts "within_bounds? tests:"
bounds = BoggleBoard.new
puts bounds.within_bounds?(0,0) == true
puts bounds.within_bounds?(3,3) == true
puts bounds.within_bounds?(-1,0) == false
puts bounds.within_bounds?(0,4) == false



board = BoggleBoard.new
board.shake!
puts board
# board.include?("apple") # => true or false, depending

board.board = [["C", "A", "T", "-"],
               ["-", "-", "-", "-"],
               ["-", "-", "-", "-"],
               ["-", "-", "-", "-"] ]
puts board
puts board.include?("cat")

board.board = [["C", "-", "-", "-"],
               ["A", "-", "-", "-"],
               ["T", "-", "-", "-"],
               ["-", "-", "-", "-"] ]
puts board
puts board.include?("cat")

board.board = [["C", "-", "-", "-"],
               ["A", "-", "-", "-"],
               ["P", "-", "-", "-"],
               ["-", "-", "-", "-"] ]
puts board
puts board.include?("cat")

board.board = [ ["S","M","E","F"],
                ["R","A","T","D"],
                ["L","O","N","I"],
                ["K","A","F","B"] ]
puts board

words = %w(nito ntfdibfako rates smefdtarlonibfak kotf dets)
words.each do |word|
  print word + ":  "
  puts board.include?(word)
end

puts
puts board.include?("RAT") == true
puts board.include?("RAOAFB") == true
puts board.include?("BFNTDF") == true
puts board.include?("BFNTDZ") == false
puts board.include?("TAR") == true
puts board.include?("TAT") == false
puts board.include?("SRAME") == true
puts board.include?("SRAMS") == false
puts board.include?("SRMTAO") == true
puts board.include?("SRMTAM") == false
puts board.include?("SRMTAZ") == false

