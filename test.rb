require_relative 'erated'

link0 = "hello world"
link0 = "http://www.ebay.com/itm/RAPOO-2-4GHz-AA-Black-Wireless-Optical-Gaming-Mouse-Mice-PC-Laptop-6-Buttons-/30124aad"
link1 = "http://www.ebay.com/itm/RAPOO-2-4GHz-AA-Black-Wireless-Optical-Gaming-Mouse-Mice-PC-Laptop-6-Buttons-/301823771240"
link2 = "http://www.ebay.com/itm/7-Buttons-2400DPI-Wireless-Optical-Mice-Adjustable-Gaming-Mouse-For-Laptop-PC-/201380850140"
link3 = "http://www.ebay.com/itm/2-4GHz-6D-1600DPI-USB-Wireless-Optical-Gaming-Mouse-Mice-For-Laptop-Desktop-PC-/271963502249"

scraper = ProductCompare::Scraper.new()
begin
  data0 = scraper.get_data_from_link(link0)
rescue =>ex
  p ex
end
data1 = scraper.get_data_from_link(link1)
data2 = scraper.get_data_from_link(link2)
data3 = scraper.get_data_from_link(link3)
p "finished"
Comparator.compare_products(data1,data2)
Comparator.compare_products(data1,data3)
