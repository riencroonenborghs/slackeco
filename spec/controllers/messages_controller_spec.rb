require 'rails_helper'

describe MessagesController, type: :controller do

  describe "memes" do
    let(:params) { {text: "meme all the memes", trigger_word: 'slackmeme:'} }
    let(:image_url) { 'image_url' }

    before(:each) do
      ENV['MEME_TRIGGER_WORD'] = 'slackmeme:'
      allow_any_instance_of(MessageHandler).to receive(:process!).and_return({image_url: image_url})
    end

    context 'POST #handle' do
      it "should be success" do
        post :handle, params
        expect(response).to be_success
      end

      it "should render json image_url" do
        post :handle, params
        expect(response.body).to eq '{"image_url":"image_url"}'
      end

      it "should render json trigger word error" do
        post :handle, params.merge(trigger_word: 'trigger_word')
        expect(response.body).to eq '{"error":"invalid trigger_word"}'
      end
    end
  end # describe "memes" do

  describe "games" do
  end # describe "games" do

end