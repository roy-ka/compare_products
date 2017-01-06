module Comparator
  class ProductsMatch
    attr_accessor :id #[link1,link2]
    attr_accessor :products       #[product1,product2]
    attr_accessor :attributes     #score of attributes
    attr_accessor :categories     #bolean of categories
    attr_accessor :units_score    #bolean, set by comparator.compare_units
    attr_accessor :total_score    #totala score of matching. range: 0- tbd
    attr_accessor :matching_words_score #score of matching words. set by comparator.get_matching_words. calculate by 100*()amount of matching words)/(average words in title)
    attr_accessor :matching_words_data #hash key: word. value: MatchWord obj. filled by comparator.get_matching_words
    attr_accessor :seq #sequence od words - variation of n-grams -set at comparator.find_terms
    attr_accessor :seq_score

    def initialize(id,prods)
      @id = id
      @products = prods
    end

    def calculate_score
      score = matching_words_score + seq_score + 0.5*attributes #matchin_words : max 100, seq_score no_max(~ 10 max), attributes: max 100(*0.5)
      score += 100 if units_score
      score += 100 if categories
      @total_score = score/3.6 #normalization factor
    end

    def is_match?
      self.calculate_score unless @total_score
      case @total_score
        when 0...40
          "no"
        when 40...60
          "similar product"
        when 60..150
          "yes"
        else
          "not enough data"
      end
    end
  end
end