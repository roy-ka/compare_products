class MatchingManager

  def match(link_arry)
    scraper = ProductCompare::Scraper.new()
    products_data = {}
    link_arry.each do |link|
      begin
        products_data[link] = scraper.get_data_from_link link
      rescue => ex
        p ex
      end
    end
    match_data = Comparator.compare_products(products_data)
    p match_data.keys
  end

end