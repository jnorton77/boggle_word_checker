# You should re-use and modify your old BoggleBoard class
# to support the new requirements

class BoggleBoard
  attr_accessor :board

  DICE = [ 'AAEEGN',
           'ELRTTY',
           'AOOTTW',
           'ABBJOO',
           'EHRTVW',
           'CIMOTU',
           'DISTTY',
           'EIOSST',
           'DELRVY',
           'ACHOPS',
           'HIMNQU',
           'EEINSU',
           'EEGHNW',
           'AFFKPS',
           'HLNNRZ',
           'DEILRX'  ].map(&:chars)

  def initialize
    @board = Array.new(4) {Array.new(4, '_')}
  end

  def shake!
    self.board = DICE.shuffle.map{ |die_arr| roll(die_arr) }.each_slice(4).to_a
  end

  def roll(die)
    result = die.sample
    # if result == "Q"
    #   "Qu"
    # else
    #   result.ljust(2)
    # end
  end

  def to_s
    board_str = ''
    board.each do |row|
      row.each do |char|
        board_str << pad_char(char)
      end
      board_str << "\n"
    end
    board_str + "\n"
  end

  def pad_char(char)
    char << 'u' if char == 'Q'
    char.ljust(3)
  end

  def include?(word)
    chars = word.upcase.chars
    board.each_index do |row|
      board.each_index do |col|
        return true if check(chars, board, row, col)
      end
    end
    false
  end

  def check(chars, board, row, col)
    board = board.transpose.transpose
    char = chars.first
    remain = chars[1..-1]
    return false unless within_bounds?(row, col)
    if char == board[row][col]
      board[row][col] = '-'
      return true if remain.empty?
      return check(remain, board, row    , col + 1) || # right
             check(remain, board, row    , col - 1) || # left
             check(remain, board, row + 1, col    ) || # up
             check(remain, board, row - 1, col    ) || # down
             check(remain, board, row - 1, col - 1) || # down right
             check(remain, board, row - 1, col + 1) || # down left
             check(remain, board, row + 1, col - 1) || # up right
             check(remain, board, row + 1, col + 1)    # up left
    end
    false
  end

  def within_bounds?(row, col)
    row.between?(0,3) && col.between?(0,3)
  end
end

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
