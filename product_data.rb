
module ProductCompare
  class ProductData
    attr_accessor :link
    attr_accessor :title
    attr_accessor :price
    attr_accessor :images     #link to images
    attr_accessor :att        #hash- key: att, value: value.
    attr_accessor :category

    def initialize link
      @link = link
    end

  end
end