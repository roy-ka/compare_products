module Comparator
  class ProductsMatch
    attr_accessor :id #[prod1,prod2]
    attr_accessor :attributes     #score of attributes
    attr_accessor :categories     #bolean of categories
    attr_accessor :title          #score of title
    attr_accessor :units_score    #bolean, set by comparator.compare_units
    attr_accessor :total_score    #totala score of matching. range: 0- tbd
    attr_accessor :matching_words_score #score of matching words. set by comparator.get_matching_words. calculate by 100*()amount of matching words)/(average words in title)
    attr_accessor :matching_words_data #hash key: word. value: MatchWord obj. filled by comparator.get_matching_words
    attr_accessor :seq #sequence od words - variation of n-grams

    def initialize(id)
      @id = id
    end
  end
end