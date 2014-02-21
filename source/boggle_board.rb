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
require_relative 'boggle_board_tests'
