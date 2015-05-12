require "url_shortener"

module Lita
  module Handlers
    class Bitly < Handler
      config :api_key
      config :username

      route(/(?:bitly|shorten)\s(.+)/i,
        :shorten_url,
        command: true,
        help: {"bitly | shorten URL" => "Shorten the URL using bitly"}
      )

      def shorten_url(response)
        username = Lita.config.handlers.bitly.username
        Lita.logger.debug("Got Bitly Username: #{username}")
        apikey = Lita.config.handlers.bitly.apikey
        inputURL = response.matches[0][0]
        Lita.logger.debug("Bitly() - Input url -  #{inputURL}")

        if not (/^https?:\/\/.+/i)  =~ inputURL
            Lita.logger.debug("Bitly() - Input URL Does not start with http://. Appending ..")
            inputURL.prepend("http://")
            Lita.logger.debug(inputURL)
        end

        Lita.logger.debug("Authorizing")
        authorize = UrlShortener::Authorize.new username, apikey
        client = UrlShortener::Client.new authorize
        shorten = client.shorten(inputURL)
        response.reply(shorten.urls)

      rescue => e
        Lita.logger.error("Bitly raised #{e.class}: #{e.message}")
        response.reply "Chuck Norris has turned off the bitly service, #{e.class} is raising '#{e.message}'"
      end
    end

    Lita.register_handler(Bitly)
  end
end
