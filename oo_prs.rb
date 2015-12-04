# noun: player, hands
# verb: player pick hand, computer pick hand,
#       compare hands, show winning message,

# refactor:
# 1. Show full word of hand instead of abbr.
#    e.g. Bob picks paper, computer picks rock.
# 2. Change Player class to PlayerHand class.

class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == "p" && another_hand.value == "r") || (@value == "r" && another_hand.value == "s") || (@value == "s" && another_hand.value == "p")
      1
    else
      -1
    end
  end

  def display_winning_message
    case @value
    when "r"
      puts "Rock smashes scissors."
    when "s"
      puts "Scissors cuts Paper."
    when "p"
      puts "Paper wraps rock."
    end
  end

end


class Player
  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def to_s
    "#{name} currently has a choice of #{self.hand.value}!"
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Pick one: (p/r/s)"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)

    self.hand = Hand.new(c)
  end
end

class Computer < Player
  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end
end


class Game
  CHOICES = {"p"=>"paper", "r"=>"rock", "s"=>"scissors"}
  attr_reader :player, :computer

  def initialize
    @player = Human.new("Bob")
    @computer = Computer.new("R2D2")
  end

  def compare_hands
    if player.hand == computer.hand
      puts "It's a tie."
    elsif player.hand > computer.hand
      puts "#{player.name} won!"
    else
      puts "#{computer.name} won!"
    end
  end

  def play
    player.pick_hand
    computer.pick_hand
    puts player
    puts computer
    compare_hands
  end
end

game = Game.new.play
