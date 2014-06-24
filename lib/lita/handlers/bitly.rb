require "url_shortener"

module Lita
  module Handlers
    class Bitly < Handler
    end

    Lita.register_handler(Bitly)
  end
end
