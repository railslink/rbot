## RBot

A friendly bot to help make [Ruby on Rails Link][rubyonrailslink] a better place.

## Contributing

To run the bot locally you will need the SLACK_API_TOKEN (ask phallstrom).
Add that and the following ENV vars to `.env.local`. For example:

    SLACK_API_TOKEN=xxxxxxxx
    DEVELOPMENT_USER=phallstrom

Setting DEVELOPMENT_USER will restrict the bot to responding only to commands
initiated by the user specified.

Run the bot via:

    bundle exec ruby rbot.rb

[rubyonrailslink]: https://rubyonrails.link
