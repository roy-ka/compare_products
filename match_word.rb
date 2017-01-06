module Comparator
  class MatchWord
    attr_accessor :word
    attr_accessor :index1
    attr_accessor :index2

    def initialize(word)
      @word = word
    end
  end
end