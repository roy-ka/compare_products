require_relative 'compare_products'

Shoes.app :title => "compare producs" do
	para "insert first link"
	@link1 = edit_box   :width => 600, :height => 30
	para "insert second link"
	@link2 = edit_box  :width => 600, :height => 30
	
	compare = button "compare" do
	links =[@link1.text,@link2.text]
	result = MatchingManager.new.match(link_arr)
  para links
  para "test"
	#para result[links].get_score.to_s
	end
end