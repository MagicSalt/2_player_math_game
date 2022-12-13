require_relative 'player'
require_relative 'question'
require_relative 'gamemaster'

class MathGame
  INTRO = "Welcome to MATHGAME"

  GAME_MASTER = GameMaster.new
  PLAYER = Player
  QUESTION = Question.new
end