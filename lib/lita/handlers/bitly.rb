require "url_shortener"

module Lita
  module Handlers
    class Bitly < Handler
    
    
      #route(/^(?:http|https)(.+)/i,
      #:shorten, 
      #command: true
      #)
      route(/(?:bitly|shorten)\s(.+)/i,
      :shorten_url,
      command: true,
      help: {"bitly | shorten URL" => "Shorten the URL using bitly"}
      )
       
      def shorten_url(response)
        inputURL = response.matches[0][0]
        Lita.logger.debug("Input url -  #{inputURL}")
        authorize = UrlShortener::Authorize.new 'pcsappops', 'R_1bcac2ff7d3d47f19d667f1b1dcefcf6'
        Lita.logger.debug(authorize)
        client = UrlShortener::Client.new authorize
        Lita.logger.debug(client)
        shorten = client.shorten(inputURL)
        Lita.logger.debug("Shorten is #{shorten}")
        #Lita.logger.debug(shorten.urls)
        #print UrlShortener::Response::Shorten.class
        response.reply(shorten.urls)
        
       
      end
    end
    

    Lita.register_handler(Bitly)
  end
end
