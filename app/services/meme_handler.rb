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
    SlackWriter.push!(USERNAME, ENV['MEME_LIST_URL'])
    {list: ENV['MEME_LIST_URL']}
  end

  def handle_meme
    generator = ::ImgFlip::Generator.new(parsed_message)
    if generator.valid?
      hash = generator.generate!
      SlackWriter.push!(USERNAME, hash[:image_url])
      hash
    else
      {error: 'invalid meme'}
    end
  end

end