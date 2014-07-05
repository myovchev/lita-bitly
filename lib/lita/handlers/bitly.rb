require "url_shortener"

module Lita
  module Handlers
    class Bitly < Handler


      #route(/^(?:https?)(.+)/i,
      #:shorten, 
      #command: true
      #)

      route(/(?:bitly|shorten)\s(.+)/i,
      :shorten_url,
      command: true,
      help: {"bitly | shorten URL" => "Shorten the URL using bitly"}
      )


      def self.default_config(handler_config)
        handler_config.username = nil
        handler_config.apikey = nil
      end

      def shorten_url(response)
        username = Lita.config.handlers.bitly.username
        Lita.logger.debug("Got Bitly Username: #{username}")
        apikey = Lita.config.handlers.bitly.apikey
        inputURL = response.matches[0][0]
        Lita.logger.debug("Bitly() - Input url -  #{inputURL}")

        if not /^https?:\/\/.+/i  =~ inputURL
            Lita.logger.debug("Bitly() - Input URL Does not start with http://. Appending ..")
            inputURL.prepend("http://")
            Lita.logger.debug(inputURL)
        end

        Lita.logger.debug("Authorizing")
        authorize = UrlShortener::Authorize.new username, apikey
        client = UrlShortener::Client.new authorize
        shorten = client.shorten(inputURL)
        response.reply(shorten.urls)


      end
    end


    Lita.register_handler(Bitly)
  end
end
