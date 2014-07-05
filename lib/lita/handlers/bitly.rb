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
      
      
      
      def self.default_config(handler_config)
        handler_config.username = nil
        handler_config.apikey = nil
      end
      
      def shorten_url(response)
        username = Lita.config.handler.bitly.username
        apikey = Lita.config.handler.bitly.apikey
        inputURL = response.matches[0][0]
        Lita.logger.debug("Bitly() - Input url -  #{inputURL}")
        
        if not /^http:\/\/.+/i  =~ inputURL
            Lita.logger.debug("Bitly() - Input URL Does not start with http://. Appending ..")
            inputURL.prepend('http://')
            Lita.logger.debug(inputURL)
        end
        
        
        authorize = UrlShortener::Authorize.new 'pcsappops', 'R_1bcac2ff7d3d47f19d667f1b1dcefcf6'
        Lita.logger.debug(authorize)
        client = UrlShortener::Client.new authorize
        Lita.logger.debug(client)
        shorten = client.shorten(inputURL)
        Lita.logger.debug("Shorten is #{shorten}")
        
        #Anything that start with HTTP AND AND AND HTTPS
        #Use  Exception Handling for Invalid URI and Authentication Exception
        
        
        #Lita.logger.debug(shorten.urls)
        #print UrlShortener::Response::Shorten.class
        response.reply(shorten.urls)
        
       
      end
    end
    

    Lita.register_handler(Bitly)
  end
end
