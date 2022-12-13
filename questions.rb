class Queston
  attr_reader :current_question, :answer

  def initialize
    @current_question = nil
    @answer = nil
  end

  def make_question
    num1 = 1 + rand(20)
    num2 = 1 + rand(20)
    set_answer(num1, num2)
    @current_question = "What is #{num1} plus #{num2}?"
  end

  def answer
    private
    
    def set_answer(num1, num2)
      @answer = num1 + num2
  end
end