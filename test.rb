require_relative 'erated'

link1 = "http://www.ebay.com/itm/RAPOO-2-4GHz-AA-Black-Wireless-Optical-Gaming-Mouse-Mice-PC-Laptop-6-Buttons-/301823771240?hash=item4646194268:g:a74AAOSwQJhUchyx"
link2 = "http://www.ebay.com/itm/7-Buttons-2400DPI-Wireless-Optical-Mice-Adjustable-Gaming-Mouse-For-Laptop-PC-/201380850140?hash=item2ee33be9dc:g:PU8AAOSw~gRVplNF"
link3 = "http://www.ebay.com/itm/2-4GHz-6D-1600DPI-USB-Wireless-Optical-Gaming-Mouse-Mice-For-Laptop-Desktop-PC-/271963502249?hash=item3f5249b6a9:g:8-kAAOSw3ydV1ZxW"

scraper = ProductCompare::Scraper.new()
data1 = scraper.get_data_from_link(link1)
data2 = scraper.get_data_from_link(link2)
data3 = scraper.get_data_from_link(link3)
Comparator.compare_products(data1,data2)
Comparator.compare_products(data1,data3)
