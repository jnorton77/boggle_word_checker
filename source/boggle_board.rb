class BoggleBoard
  attr_accessor :board

  DICE = [ 'AAEEGN', 'ELRTTY', 'AOOTTW', 'ABBJOO',
           'EHRTVW', 'CIMOTU', 'DISTTY', 'EIOSST',
           'DELRVY', 'ACHOPS', 'HIMNQU', 'EEINSU',
           'EEGHNW', 'AFFKPS', 'HLNNRZ', 'DEILRX' ].map(&:chars)

  def initialize
    @board = Array.new(4) {Array.new(4, '_')}
  end

  def shake!
    self.board = DICE.shuffle.map{ |die| roll(die) }.each_slice(4).to_a
  end

  def roll(die)
    result = die.sample
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
    word = word.upcase.gsub(/qu/, 'q')
    chars = word.chars
    board.each_index do |row|
      board.each_index do |col|
        return true if check?(chars, board, row, col)
      end
    end
    false
  end

  def check?(chars, board, row, col)
    return false unless within_bounds?(row, col)
    return false unless chars.first == board[row][col]
    board = board.transpose.transpose # hacky deep cloning
    remain = chars[1..-1]
    if remain.empty?
      true
    else
      board[row][col] = '-'
      check_in_all_directions?(remain, board, row, col)
    end
  end

  def check_in_all_directions?(remain, board, row, col)
      check?(remain, board, row    , col + 1) || # right
      check?(remain, board, row    , col - 1) || # left
      check?(remain, board, row + 1, col    ) || # up
      check?(remain, board, row - 1, col    ) || # down
      check?(remain, board, row - 1, col - 1) || # down right
      check?(remain, board, row - 1, col + 1) || # down left
      check?(remain, board, row + 1, col - 1) || # up right
      check?(remain, board, row + 1, col + 1)    # up left
  end

  def within_bounds?(row, col)
    row.between?(0,3) && col.between?(0,3)
  end
end

# TESTS
require_relative 'boggle_board_tests'
