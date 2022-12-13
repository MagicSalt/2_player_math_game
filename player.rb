class Player < Math_game
  attr_accessor(:lives, :correct_answers)
  attr_reader :name

  def initialize(name)
    @name = name
    @lives = 3
    @correct_answers = 0
  end

  def win
    @correct_answers += 1
  end

  def lose
    @lives -= 1
  end
end