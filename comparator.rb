
module Comparator
  class  << self
    def compare_products (p1, p2)
      @p1 = p1
      @p2 = p2
      compare_atts
      #compare_titles
    end

    def compare_atts
      atts = @p1.att.keys & @p2.att.keys
      check = 0
      atts.each { |key|
        check += 1 if @p1.att[key] == @p2.att[key]
      }
      @atts_Score = 100*check/atts.size
    end

    def compare_titles
      titel1 = @p1.title.downcase.gsub(/[^0-9A-Za-z. ]/,' ').split
      titel2 = @p2.title.downcase.gsub(/[^0-9A-Za-z. ]/,' ').split
      match,index1,index2 = get_matching_words [titel1,titel2]
      p match, index1, index2
      get_terms index1, index2

    end

    def get_matching_words titles

      matches = t1 & t2
      index1 = []
      index2 = []
      matches.each do |word|
        index1.push t1.find_index(word)
        index2.push t2.find_index(word)
      end
      [matches,index1,index2]
    end

  end
end