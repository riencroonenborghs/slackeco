require 'rails_helper'

describe SlackWriter do

  before(:each) do
    ENV['INCOMING_HOOK'] = 'INCOMING_HOOK'
    ENV['CHANNEL'] = 'CHANNEL'
    ENV['OUTGOING_HOOK_ENABLED'] = '1'
  end

  let(:username) { 'SlackMeme' }

  context 'self#push!' do
    it "should return if message is nil" do
      expect(SlackWriter.push!(username, nil)).to eq nil
    end
    it "should post" do
      expect(Unirest).to receive(:post)
      SlackWriter.push!(username, 'message')
    end
    it "should post to channel" do
      expect(Unirest).to receive(:post).with(/(.+)/, parameters: /\"channel\": \"#CHANNEL\"/)
      SlackWriter.push!(username, 'message')
    end
    it "should post username" do
      expect(Unirest).to receive(:post).with(/(.+)/, parameters: /\"username\": \"SlackMeme\"/)
      SlackWriter.push!(username, 'message')
    end
    it "should post message" do
      expect(Unirest).to receive(:post).with(/(.+)/, parameters: /\"text\": \"message\"/)
      SlackWriter.push!(username, 'message')
    end
    it "should post to URL" do
      expect(Unirest).to receive(:post).with('INCOMING_HOOK', parameters: /(.+)/)
      SlackWriter.push!(username, 'message')
    end
  end

end