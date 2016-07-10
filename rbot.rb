require 'pry'
require 'slack-ruby-client'

fail 'Missing ENV[SLACK_API_TOKENS]!' unless ENV.key?('SLACK_API_TOKENS')

$stdout.sync = true
logger = Logger.new($stdout)
logger.level = Logger::DEBUG

ENV['SLACK_API_TOKENS'].split.each do |token|
  logger.info "Starting #{token[0..12]} ..."

  client = Slack::RealTime::Client.new(token: token)

  client.on :hello do
    logger.info "Successfully connected '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
  end

  client.on :message do |data|
    logger.info data

    if data.subtype == "channel_join"
      user = data.user
      im_channel = client.ims.values.detect {|im| im.user == user}.id
      if im_channel
        client.message(
          channel: im_channel,
          text: "Welcome to #{client.team.name} <@#{user}>!"
        )
      end
    end
  end

  client.start_async
end

loop do
  Thread.pass
end
