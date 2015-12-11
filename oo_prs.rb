class Hand
  include Comparable

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == 'p' && another_hand.value == 'r') || (@value == 'r' && another_hand.value == 's') || (@value == 's' && another_hand.value == 'p')
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

  def show_hand_full_name
    case @value
    when "r"
      "rock"
    when "s"
      "scissors"
    when "p"
      "paper"
    end

  end

end


class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
  end

  def to_s
    "#{self.name} has a choice of #{self.hand.show_hand_full_name}."
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Pick one: (p, r, s)"
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
  attr_reader :player, :computer

  CHOICES = {'p' => 'paper', 'r' => 'rock', 's' => 'scissors'}

  def initialize
    @player = Human.new("Jason")
    @computer = Computer.new("C3PO")
  end


  def compare_hands
    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      puts "#{player.name} won!"
    else
      computer.hand.display_winning_message
      puts "#{computer.name} won!"
    end
  end

  def play_again?
    puts "Would you like to play again?"
    play_again = gets.chomp.downcase
    if play_again == "y"
      Game.new.play
    else
      puts "Bye."
    end
  end

  def play
    player.pick_hand
    computer.pick_hand
    puts player
    puts computer
    compare_hands
    play_again?
  end

end

game = Game.new.play
