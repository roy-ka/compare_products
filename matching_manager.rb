class MatchingManager

  def match(link_arry)
    scraper = ProductCompare::Scraper.new()
    products_data = {}
    link_arry.each do |link|
      begin
        check_link link
        products_data[link] = scraper.get_data_from_link link
        #if products_data[link]
      rescue => ex
        return "link '#{link}': #{ex}"
      end
    end
    match_data = Comparator.compare_products(products_data) #return a hash. keys: [link1,link2]. values: ProductMatch obj.
  end

  def check_link(link)
    raise "link must be an ebay item!" unless link.include? "www.ebay.com/itm"
  end

end