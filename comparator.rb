
module Comparator
  class  << self

    def compare_products(products) #receive hash of products, return hash containing all the matching data. key: [link1,link2], value: ProductMatch obj.
      @compare_products = {}
      @products = products
      keys =@products.keys
      keys.each_with_index do |link1,ind|
        next unless @products[link1].kind_of? ProductCompare::ProductData #validate we extracted the data from the link
        ((ind + 1)...keys.size).each do |j|
          link2 = keys[j]
          next unless @products[link2].kind_of? ProductCompare::ProductData #validate we extracted the data from the link
          id = [link1,link2]
          prods = [@products[link1],@products[link2]]
          @compare_products[id] = ProductsMatch.new(id,prods)
          compare_two_products @compare_products[id]
        end
      end
      @compare_products
    end

    def compare_two_products(product_match)
      compare_atts product_match
      compare_categories product_match
      compare_titles product_match
      calculate_score product_match
    end

    def compare_atts(matcher)
      prod1,prod2 = matcher.products
      atts = prod1.att.keys & prod2.att.keys #the common atts between the products
      check = 0
      atts.each { |key|
        check += 1 if prod1.att[key] == prod2.att[key]
      }
      matcher.attributes = 100*check/atts.size
    end

    def compare_titles(matcher) #compare titles composed on several tests: matching words, sequences of words and units
      prods = matcher.products
      titles = []
      prods.each do |prod|
        (titles).push prod.title.downcase.gsub(/[^0-9A-Za-z.]/,' ').split
      end
      indices = get_matching_words  titles,matcher
      no_match_titles = [] #Array of titles, each with the missing words
      titles.each do |title|
        no_match_titles.push title - matcher.matching_words_data.keys
      end
      compare_units titles,matcher # we want to find different units
      find_terms indices,matcher
    end

    def get_matching_words(titles,matcher)
      t1,t2 = titles
      matches = t1 & t2
      match_arr = {}
      indices = Array.new(2) { Array.new }
      matches.each do |word|
        match_word = MatchWord.new(word)
        ind1 = t1.find_index(word)
        match_word.index1 = ind1
        ind2 =t2.find_index(word)
        match_word.index2 = ind2
        indices[0].push ind1
        indices[1].push ind2
        match_arr[word] = match_word
      end
      avg_words = (t1.size + t2.size)/2
      matcher.matching_words_score = 100* match_arr.keys.size/avg_words
      matcher.matching_words_data = match_arr
      indices
    end

    def find_terms(indices,matcher) #Array, each object is the indices of the matching words
      seq = []
      indices.each do |index|
        seq.push find_sequence index
      end
      matcher.seq = seq
      seq_score = 0
      seq.each do |seq_prod|
        seq_prod.each do |seq_length|
          seq_score += seq_length*seq_length
        end
      end
      matcher.seq_score = seq_score/10

    end

    def find_sequence(indexes) #calculate n-grams of words
      seq = []
      counter = 1
      indexes.each_with_index { |id,ind| #id = the id of the word that matched at the sentence, ind the loc in the the vector
        next if ind == 0
        previous_id = indexes[ind-1]
        if id == previous_id + 1
          counter += 1
        else
          seq.push counter unless counter == 1
          counter = 1
        end
      }
      seq
    end

    def compare_categories(matcher)
      prod1,prod2 = matcher.products
      matcher.categories = prod1.category == prod2.category
    end

    def compare_units(titles,matcher) #compare between units in the title for words that not matching
                                      #if we couldn't find units to compare than set value of 0
                                      #if there is a mismatch between one of the units set -1
                                      #if there are only matches set 1.
                                      #in case of both match and mismatch- set -1
      matcher.units_score = 0
      units_arr = []
      titles.each do |title| #Array, each object in the Array is a hash, as describes at get_units
        units_arr.push get_units(title)
      end
      units_arr[0].each do |unit,value| #wach unit in prod 1
        next unless units_arr[1].has_key? unit
        if (value == units_arr[1][unit]) && (matcher.units_score != -1)
          matcher.units_score = 1
        elsif value !=units_arr[1][unit]
          matcher.units_score = -1
        end

      end

   end


    def get_units(title)  #extract units from the title. units is a number and letters attached together: 2.4Ghz, 3D, 1800mA...
      #returns a hash. key: the  unit. value: the value of the unit: 2.4 Ghz -> units["ghz"]=2.4
      units ={}
      title.each do |check_unit|
        num = check_unit.gsub(/[^0-9.]/,"")
        unit = check_unit.gsub(/[^a-zA-Z]/,"")
        next if num == "" || unit == ""
        units[unit] = num
      end
      units
    end

    def calculate_score(matcher)
      matcher.calculate_score
    end

  end
end