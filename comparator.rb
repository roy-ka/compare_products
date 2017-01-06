
module Comparator
  class  << self

    def compare_products products #array of products
      @compare_products = {}
      @products = products
      @products.each_with_index do |prod1,ind|
        next unless prod1.kind_of? ProductCompare::ProductData #validate we extracted the data from the link
        ((ind + 1)...@products.size).each do |j|
          next unless @products[j].kind_of? ProductCompare::ProductData #validate we extracted the data from the link
          prods = [prod1,@products[j]]
          @compare_products[prods] = ProductsMatch.new(prods)
          compare_two_products @compare_products[prods]
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
      prod1,prod2 = matcher.id
      atts = prod1.att.keys & prod2.att.keys #the common atts between the products
      check = 0
      atts.each { |key|
        check += 1 if prod1.att[key] == prod2.att[key]
      }
      matcher.attributes = 100*check/atts.size
    end

    def compare_titles(matcher)
      prods = matcher.id
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
      indices = Array.new(2) { Array.new() }
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
    end

    def find_sequence(indexes) #calculate n-grams of words
      seq = []
      counter = 1
      indexes.each_with_index { |id,ind| #id = the id of the word that matched at the sentence, ind the loc in the the vector
        next if ind == 0
        previous_id = indexes[ind-1]
        if id == previous_id + 1
          counter += 1
          # seq.add(previous_id)
          # seq.add(id)
        else
          seq.push counter unless counter == 1
          counter = 1
        end
      }
      seq
    end

    def compare_categories(matcher)
      prod1,prod2 = matcher.id
      matcher.categories = prod1.category == prod2.category
    end

    def compare_units(titles,matcher) #compare between units in the title for words that not matching
      matcher.units_score = true
      units_arr = []
      titles.each do |title| #Array, each object in the Array is a hash, as describes at get_units
        units_arr.push get_units(title)
      end
      arr_size =units_arr.size
      units_arr[0].each do |unit,value| #wach unit in prod 1
        next unless units_arr[1].has_key? unit
        matcher.units_score = false unless value == units_arr[1][unit]
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

    def calculate_score matcher
      p "---------------------------------------------------------"
      p "atts",matcher.attributes
      p "cat", matcher.categories
      p "title", matcher.title
      p "units", matcher.units_score
      p "matching_words", matcher.matching_words_score
      p "seq", matcher.seq
      p "---------------------------------------------------------"

    end

  end
end