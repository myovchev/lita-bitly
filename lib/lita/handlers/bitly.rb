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
      help: {"bitly|shorten URL" => "Shorten the URL using bitly"}
      )
       
      def shorten_url()
        response.reply(response)
      end
    end
    

    Lita.register_handler(Bitly)
  end
end
