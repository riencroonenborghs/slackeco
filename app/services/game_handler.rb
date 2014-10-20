class GameHandler
  attr_accessor :username, :message

  USERNAME = 'SlackGame'

  def initialize(username, message)
    @username = username
    @message = message
  end

  def process!
    if parsed_message =~ /rock-paper-scissors/
      play_rock_paper_scissors!
    end
  end

private

  ROCK_EMOJI    = 'fist'
  PAPER_EMOJI   = 'hand'
  SCISSOR_EMOJI = 'v'
  MOVES         = [ROCK_EMOJI, PAPER_EMOJI, SCISSOR_EMOJI]
  WINS          = [[nil,1,0],[0,nil,1],[1,0,nil]]

  def parsed_message
    @parsed_message ||= @message.gsub(/^#{ENV['GAME_TRIGGER_WORD']} /,'')
  end

  def play_rock_paper_scissors!
    matcher = parsed_message.match(/rock-paper-scissors\: \:(#{ROCK_EMOJI}|#{PAPER_EMOJI}|#{SCISSOR_EMOJI})\:/)
    if matcher
      their_move  = matcher[1]
      my_move     = MOVES[rand(MOVES.size)]
      response    =   case WINS[MOVES.index(their_move)][MOVES.index(my_move)] 
                      when 0
                        ::Score.game_won!(@username)
                        {message: "I have :#{my_move}: You win! #{Score.score(@username)}"}
                      when 1
                        ::Score.game_lost!(@username)
                        {message: "I have :#{my_move}: I win! #{Score.score(@username)}"}
                      when nil
                        ::Score.game_draw!(@username)
                        {message: "I have :#{my_move}: Let's call it a draw! #{Score.score(@username)}"}
                      end

      SlackWriter.push!(USERNAME, response[:message])
    else
      {error: "invalid move (valid moves are :#{MOVES.join(':, :')}:"}
    end
    
    response
  end

end


#   t1  R   P   S
# m0
# R    x   t   m  
# P    m   x   t
# S    t   m   x