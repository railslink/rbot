module RBot
  module Commands
    class Welcome < RBot::Commands::Base
      help do
        title "welcome"
        desc "DMs the welcome text to you"
        long_desc "If you've forgotten the welcome text that you received when you joined you can get it again."
      end

      command 'welcome'
      match(/has joined the channel/)

      def self.call(client, data, match)
        if data.subtype == 'channel_join'
          return unless client.channels[data.channel].try(:name) == ENV.fetch('WELCOME_CHANNEL', 'general')
        end

        user = client.users[data.user]
        return if user.is_bot

        dm_channel = begin
                       client.web_client.im_open(user: data.user).channel.id
                     rescue
                       nil
                     end

        if dm_channel
          logger.info "Welcoming #{user.real_name} (#{user.name})"
          client.web_client.chat_postMessage(
            as_user: true,
            channel: dm_channel,
            text: self.welcome_text(client, user),
            mrkdwn: true,
            unfurl_links: false,
            unfurl_media: false
          )
        end
      end

      def self.welcome_text(client, user)
        %Q(
          *Welcome to #{client.team.name} #{user.real_name || user.name} :wave:*

          My name is RBot and I've got a few things to share with you.

          *We don't have many rules, but we do have a few:*

          1. Be nice to each other.
          2. Don't use `@everyone`, `@channel`, `@group` or `@here`.
          3. Don't ask if you can ask a question; just ask.
          4. Don't ask the same question in multiple channels.
          5. Wrap code in backticks. <https://slack.zendesk.com/hc/en-us/article_attachments/204977928/backticks.png|Example here>.
          6. See #1.

          Be sure to browse all the public channels to see any topics and conversations that might be interesting to you.

          This team's public channels are archived at https://rubyonrails-link.slackarchive.io/
          Please keep this in mind when posting.

          If you're new to Ruby and/or Rails checkout <https://github.com/railslink/resources/wiki|our wiki> for resources to get started.

          We're glad to have you here!

          _– RBot and the Admins_
        ).strip.gsub(/^ +/, '')

      end

    end
  end
end
