require 'uri'
require 'open-uri'
require 'nokogiri'

module ProductCompare
  class Scraper

    def get_data_from_link (link)
      data = ProductData.new(link)
      begin
      @noko = get_html(link)
      rescue OpenURI::HTTPError => ex
        raise ex
      end
      return unless @noko
      data.title = get_title
      data.price = get_price
      data.images = get_images
      data.att = get_attributes
      data
    end

    def get_html (link)

      #uri = URI.encode(link)
      return unless link =~ URI::ABS_URI
      uri = URI(link)
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

    def get_attributes
      atts ={}
      warping_div = @noko.css("div[@class='itemAttr']")
      warping_div.css("table").css("tr").each do |tr|
        name = []
        value = []
        tr.css("td").each do |td|
          if td.attribute("class")
               name.push td.text.gsub!(/[^0-9A-Za-z]/, '')
          else
             value.push td.text.gsub!(/[^0-9A-Za-z]/, '')
          end
        end
        next unless name.size == value.size
        name.each_index do |i|
          atts[name[i]] = value[i]
        end
      end
      atts.delete("Condition") if atts.has_key?("Condition")
      atts
    end

  end

end
