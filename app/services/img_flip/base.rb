module ImgFlip
  module Base
    IMGFLIP_URL = "https://api.imgflip.com"

    def post!(path, params = {})
      Unirest.post(
        IMGFLIP_URL + path,
        parameters: params
      )
    end

  end
end