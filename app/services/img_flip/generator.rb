module ImgFlip
  class Generator
    include ::ImgFlip::Base

    attr_accessor :meme, :line_1, :line_2

    def initialize(message)
      @meme = parse_message(message)
    end

    def valid?
      !@meme.nil?
    end

    def generate!
      params = {
        username:     ENV['IMGFLIP_USERNAME'],
        password:     ENV['IMGFLIP_PASSWORD'],
        template_id:  @meme.id
      }
      params = params.merge!(text0: @line_1) if @line_1.present?
      params = params.merge!(text1: @line_2) if @line_2.present?

      response = post!(
        '/caption_image', 
        params
      )
       
      image_url = response.body['data']['url']
      {image_url: image_url}
    end

  private

    def parse_message(message)
      # e.g. One Does Not Simply|line1|line2
      name, @line_1, @line_2 = (message || '').split("|")

      MEME_DATABASE.memes.select{|x| x.name.downcase =~ name.downcase}.first
    end

  end # class Generator

end # module ImgFlip