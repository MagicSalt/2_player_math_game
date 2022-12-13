require_relative 'game_constants'

class Game
  def initialize
    @master = MathGame::GAME_MASTER
    @player1 = nil
    @player2 = nil
    @current_player = nil
    @continue_game = true
    @turn = 0
  end

  def start_game
    @master.speak(MathGame::INTRO)
    set_players
    @current_player = @player1

    while @continue_game
      @master.speak("\n----------NEW QUESTION----------")
      get_question
      switch_players
    end
  end

  private

  def set_players
    @master.speak("Player 1 name: ")
    name1 = @master.prompt
    name1 = "Player 1" if name1 == ""
    @player1 = MathGame::PLAYER.new(name1)
    
    @master.speak("Player 2 name: ")
    name2 = @master.prompt
    name2 = "Player 2" if name2 == ""
    @player2 = MathGame::PLAYER.new(name2)

    @master.speak("Welcome #{player1.name} and #{player2.name}")
  end

  def get_question
    question = MathGame::QUESTION.make_question
    @master.speak("#{@current_player.name}: #{question}")
    get_answer
  end

  def get_answer
    answer = @master.prompt
    eval_answer(answer)
  end

  def eval_answer(answer)
    if (answer.to_i == MathGame::QUESTION.answer)
      increment_correct_answers(@current_player)
    else
      decrement_lives(@current_player)
    end
    show_stats
    player_dead?(@current_player)
  end

  def increment_correct_answers(player)
    @master.speak("Correct!")
    player.correct_answers += 1
  end

  def decrement_lives(player)
    @master.speak("Incorrect.")
    player.lives -= 1
  end

  def player_dead?(player)
    (player.lives <= 0) ? game_end : false
  end

  def show_stats
    @master.speak("#{player1.name}: #{@player1.lives}/3 vs. #{player2.name}: #{player2.lives}/3")
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def game_end
    winner = get_winner
    @master.speak("#{winner.name.upcase} wins!")
    @master.speak("with #{winner.correct_answers} correct answers!")
    @continue_game = false
    @master.speak("\n----------GAME OVER----------")
    @master.speak("Play again? y/n")
    play_again = @master.prompt

    if player_again == "y"
      @continue_game = true
      start_game
    else
      @master.speak("Goodbye.")
    end
  end
end
