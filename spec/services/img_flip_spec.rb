require 'rails_helper'

describe ImgFlip do

  let(:message) { "meme all the memes" }

  context '#new' do
    it "should raise execption" do
      expect { ImgFlip.new }.to raise_exception
    end
    it "should raise not execption" do
      expect { ImgFlip.new(message) }.to_not raise_exception
    end
    it "should match memes" do
      allow_any_instance_of(ImgFlip).to receive(:match_memes)
      ImgFlip.new(message)
    end
  end

  context '#valid?' do
    it "should return true" do
      expect(ImgFlip.new(message).valid?).to eq true
    end
    it "should return false" do
      expect(ImgFlip.new('message').valid?).to eq false
    end
  end

  context '#generate!' do
    before(:each) do
      response = Struct.new(:body).new({'data' => {'url' => 'some-url'}})
      allow(Unirest).to receive(:post).and_return(response)
    end

    it "should return" do
      expect(ImgFlip.new(message).generate!).to_not eq nil
    end

    it "should return hash" do
      expect(ImgFlip.new(message).generate!.class).to eq Hash
    end

    it "should return url" do
      hash = {image_url: 'some-url'}
      expect(ImgFlip.new(message).generate!).to eq hash
    end
  end

  context '#match_memes' do
    it "should return when message is nil" do
      expect_any_instance_of(ImgFlip).to receive(:match_memes).and_return(nil)
      ImgFlip.new(nil)
    end
    it "should return when no memes was found" do
      expect(ImgFlip.new(nil).send(:match_memes, 'message')).to eq nil
    end 
    it "should return" do
      expect(ImgFlip.new(nil).send(:match_memes, message)).to_not eq nil
    end
    it "should return hash" do
      hash = ImgFlip.new(nil).send(:match_memes, message)
      expect(hash.class).to eq Hash
      expect(hash[:id]).to eq 61533
      expect(hash[:top]).to eq 'meme'
      expect(hash[:bottom]).to eq 'all the memes'
    end
  end

end