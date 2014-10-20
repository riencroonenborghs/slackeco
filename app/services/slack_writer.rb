class SlackWriter
  def self.push!(username, message)
    return unless ENV['OUTGOING_HOOK_ENABLED'] == '1'
    return unless message
    payload = 'payload={"channel": "#' + ENV['CHANNEL'] + '", "username": "' + username + '", "text": "' + message + '"}'
    Unirest.post(ENV['INCOMING_HOOK'], parameters: payload)
  end
end