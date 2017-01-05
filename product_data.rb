
module ProductCompare
  class ProductData
    attr_accessor :link
    attr_accessor :title
    attr_accessor :price
    attr_accessor :images

    def initialize link
      @link = link
    end
  end
end