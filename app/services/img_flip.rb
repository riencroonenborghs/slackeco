class ImgFlip
  IMGFLIP_URL = "https://api.imgflip.com"

  MEMES = [
    {id: 61579, regexp: /^(one does not simply)(.*)/, name: 'one does not simply _X_', top: false, bottom: true},
    {id: 61532, regexp: /^(i don(?:')?t always .*) (but when i do .*)/, name: 'i dont always _X_ but when I do _Y_', top: false, bottom: true},
    {id: 61520, regexp: /^(not sure if .*) (or .*)/, name: 'not sure if _X_ or _Y_', top: false, bottom: true},
    {id: 100947, regexp: /^(what if i told you)(.*)/, name: 'what if i told you _X_', top: false, bottom: true},
    {id: 61546,  regexp: /^(brace yourselves)(.*)/,  name: 'brace yourselves _X_', top: false, bottom: true},
    {id: 16464531, regexp: /^(.*)(but that(?:')?s none of my business)/, name: '_X_ but that\'s none of my business', top: true, bottom: false},
    {id: 61533, regexp: /^(.*)((all the)(.*))/, name: '_X_ all the _Y_', top: true, bottom: false},
    {id: 442575, regexp: /^(.*)(ain(?:')?t nobody got time for that)/, name: '_X_ ain\'t nobody got time for that', top: true, bottom: false},
    {id: 11074754, regexp: /^(.*)(we(?:')?re dealing with a badass over here)/, name: '_X_ we\'re dealing with a badass over here', top: true, bottom: false},
    {id: 766986, regexp: /^(.*?)((a)+nd it(?:')?s gone)\z/, name: '_X_ and it\'s gone', top: true, bottom: false},
    {id: 347390, regexp: /^(.*,) (.* everywhere)/, name: '_X_, _X_ everywhere',  top: false, bottom: false},
    {id: 405658, regexp: /^(.* once) (it was awful)/, name: '_X_ once it was awful',  top: true, bottom: false},
    {id: 8072285, regexp: /^(such .*) (many .*\. wow)/, name: 'such _X_ many _Y_. wow', top: true, bottom: false},
    {id: 61580, regexp: /^(the .*)((is|are) too damn .*)/, name: 'the _X_ is too damn _Y_', top: true, bottom: true},
    {id: 195389, regexp: /^(this is)(.*)/, name: 'this is _X!!!!!', top: false, bottom: true},
    {id: 1790995, regexp: /^(.* and nobody bats an eye)(.* and everybody loses their minds)/, name: '_X_ and nobody bats an eye _Y_ and everybody loses their minds', top: true, bottom: true},
    {id: 1367068, regexp: /^(i should .*)/, name: 'i should _X_', top: true, bottom: false},
    {id: 10628640, regexp: /^(do you want .*?)(because that(?:')?s how you get .*)/, name: 'do you want _X_? because that\'s how you get _X_', top: true, bottom: true},
    {id: 176908, regexp: /^(shut up and take my .*)/, name: 'shut up and take my _X_', top: true, bottom: false},
    {id: 61554, regexp: /^(false) (.*)/, name: 'false _X_', top: false, bottom: true}
  ]

  attr_accessor :meme

  def initialize(message)
    @meme = match_memes(message)
  end

  def valid?
    !@meme.nil?
  end

  def generate!
    response = Unirest.post(
      IMGFLIP_URL + '/caption_image',
      parameters: {
        username:     ENV['IMGFLIP_USERNAME'],
        password:     ENV['IMGFLIP_PASSWORD'],
        template_id:  @meme[:id], 
        text0:        @meme[:top], 
        text1:        @meme[:bottom]
      }
    )
     
    image_url = response.body['data']['url']
    puts "#{Time.zone.now} MEME: #{@meme[:id]} -> #{image_url}"
    {image_url: image_url}
  end

private

  def match_memes(message)
    return nil if message.nil?

    MEMES.each do |hash|
      if hash[:regexp] =~ message.downcase
        top = $1; top.strip! if hash[:top]
        bottom = $2; bottom.strip! if hash[:bottom]
        return {id: hash[:id], top: top, bottom: bottom}
      end
    end

    nil
  end
end