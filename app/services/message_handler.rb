class MessageHandler
  attr_accessor :trigger_word, :message

  def initialize(trigger_word, user_name, message)
    @trigger_word = trigger_word
    @user_name = user_name
    @message = message
  end

  def process!
    case @trigger_word
    when ENV['MEME_TRIGGER_WORD']
      MemeHandler.new(@message).process!
    when ENV['GAME_TRIGGER_WORD']
      GameHandler.new(@user_name, @message).process!
    end
  end
  
end