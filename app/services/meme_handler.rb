class MemeHandler
  attr_accessor :message

  USERNAME = 'SlackMeme'

  def initialize(message)
    @message = message
  end

  def process!
    if parsed_message =~ /list/
      handle_list
    else
      handle_meme
    end
  end

private

  def parsed_message
    @parsed_message ||= @message.gsub(/^#{ENV['MEME_TRIGGER_WORD']} /,'')
  end

  def handle_list
    names = ImgFlip::MEMES.map{|x| x[:name]}
    SlackWriter.push!(USERNAME, names.join('\n'))
    {memes: names}
  end

  def handle_meme
    generator = ::ImgFlip.new(parsed_message)
    if generator.valid?
      hash = generator.generate!
      SlackWriter.push!(USERNAME, hash[:image_url])
      hash
    else
      {error: 'invalid meme'}
    end
  end

end