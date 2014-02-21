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
    if result == "Q"
      "Qu"
    else
      result.ljust(2)
    end
  end

  def to_s
    board.inject('') {|str,row| str << "#{row.join(' ')}\n" } + "\n"
  end
end
