require_relative 'erated'

#link0 = "hello world"
link0 = "http://www.ebay.com/itm/RAPOO-2-4GHz-AA-Black-Wireless-Optical-Gaming-Mouse-Mice-PC-Laptop-6-Buttons-/30124aad"
link1 = "http://www.ebay.com/itm/RAPOO-2-4GHz-AA-Black-Wireless-Optical-Gaming-Mouse-Mice-PC-Laptop-6-Buttons-/301823771240"
link2 = "http://www.ebay.com/itm/7-Buttons-2400DPI-Wireless-Optical-Mice-Adjustable-Gaming-Mouse-For-Laptop-PC-/201380850140"
link3 = "http://www.ebay.com/itm/2-4GHz-6D-1600DPI-USB-Wireless-Optical-Gaming-Mouse-Mice-For-Laptop-Desktop-PC-/271963502249"
#link4 = "http://www.ebay.com/itm/Build-On-Brick-Puzzle-Assembly-Coffee-Cup-DIY-Drink-Building-Blocks-350ML-Mug-/302167489389"

scraper = ProductCompare::Scraper.new()
# begin
#   data0 = scraper.get_data_from_link(link0)
# rescue =>ex
#   p "link #{link0} in not working since #{ex}"
# end
link_arr = [link0, link1, link2, link3]
manager = MatchingManager.new.match(link_arr)
# data1 = scraper.get_data_from_link(link1)
# data2 = scraper.get_data_from_link(link2)
# data3 = scraper.get_data_from_link(link3)
# #data4 = scraper.get_data_from_link(link4)
# Comparator.compare_products([data1,data3])
# Comparator.compare_products([data3,data2])
# Comparator.compare_products([data1,data2])
# Comparator.compare_products([data1,data1])

