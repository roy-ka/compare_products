require 'uri'
require 'open-uri'
require 'nokogiri'

module ProductCompare
  class Scraper

    def get_data_from_link (link)
      data = ProductData.new(link)
      @noko = get_html(link)
      data.title = get_title
      data.price = get_price
      data.images = get_images

      data
    end

    def get_html (link)
      uri = URI.encode(link)
      html = open(uri).read
      @noko = Nokogiri::HTML(html) do |config|
        config.strict.noblanks
      end
    end

    def get_title
      noko_title = @noko.css("h1[@id='itemTitle']")
      noko_title.text.gsub("Details about  \u00A0","")
    end

    def get_price
      noko_price = @noko.css("span[@id='prcIsum']")
      noko_price = @noko.css("span[@id='mm-saleDscPrc']") if noko_price.text == "" # some pages have different tag for the price: http://www.ebay.com/itm/7-Buttons-2400DPI-Wireless-Optical-Mice-Adjustable-Gaming-Mouse-For-Laptop-PC-/201380850140?hash=item2ee33be9dc:g:PU8AAOSw~gRVplNF
      noko_price.text
    end

    def get_images
      noko_table = @noko.css("table[@class='img']")
      images = []
      noko_table.css("img").each do |image|
        images. push image.attribute("src").text
      end
      images
    end


  end
end