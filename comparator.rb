
module Comparator
  class  << self
    def compare_products (p1, p2)
      @p1 = p1
      @p2 = p2
      compare_images

    end

    def compare_images
      p @p1.images
      p @p2.images
      p !(@p1.images & @p2.images).empty?
    end

  end
end