require 'nmatrix'
require 'pry'

m = NMatrix::IO::Matlab::load_mat 'transaction.mat'
temp_hash = Hash.new
mini_supp = m.column(0).size * 0.04

#1-itemset
(1..m.column(0).size).each do |row_num|
	m.row(row_num-1).each_with_index do |item, index|
		i = (index+1).to_s
		if temp_hash.has_key? i
			temp_hash[i] += item
		else
			temp_hash[i] = item
		end
	end
end
temp_hash.delete_if {|key, value| value < mini_supp}
	
#2-itemset
one_itemset_keys = temp_hash.keys #array
temp_array = temp_hash.keys
one_itemset_keys.each do |key1|
	temp_array.delete(key1)
	temp_array.each do |key2|
		i = key1 + ',' + key2
		(1..m.column(0).size).each do |row_num|
			row_items = m.row(row_num-1)
			if row_items[key1.to_i-1] == 1 and row_items[key2.to_i-1] == 1
				item = 1
			else
				item = 0
			end 
			if temp_hash.has_key? i
				temp_hash[i] += item
			else
				temp_hash[i] = item
			end
		end
	end
end
temp_hash.delete_if {|key, value| value < mini_supp}
two_itemsets = temp_hash.reject{|key| !key.include?','} #hash
#["1,3", "1,47", "5,10", "13,32", "13,37", "17,33", "19,4", "19,36", "23,6", "28,29", "32,37"]
two_itemset_keys = two_itemsets.keys #array


#3-itemset
three_itemset_keys = Array.new
(0..two_itemset_keys.length-2).each do |index1|
	(index1+1..two_itemset_keys.length-1).each do |index2|
		if two_itemset_keys[index1].gsub(/,[0-9]+$/, '') == two_itemset_keys[index2].gsub(/,[0-9]+$/, '')
			three_itemset_keys << two_itemset_keys[index1] + ',' + two_itemset_keys[index2].gsub(/^[0-9]+,/, '')
		end
	end
end
#["1,3,47", "13,32,37", "19,4,36"]
#puts three_itemset_keys

three_itemset_keys.each do |elem|
	key1 = elem.gsub(/,[0-9]+,[0-9]+/, '')
	key2 = elem.gsub(/^[0-9]+,/, '').gsub(/,[0-9]+$/, '')
	key3 = elem.gsub(/^[0-9]+,[0-9]+,/, '')
	(1..m.column(0).size).each do |row_num|
		row_items = m.row(row_num-1)
		if row_items[key1.to_i-1] == 1 and row_items[key2.to_i-1] == 1 and row_items[key3.to_i-1] == 1 
			item = 1
		else
			item = 0
		end 
		if temp_hash.has_key? elem
			temp_hash[elem] += item
		else
			temp_hash[elem] = item
		end
	end
end
temp_hash.delete_if {|key, value| value < mini_supp}


#puts temp_hash.sort_by{|k, v| k}.to_h
puts temp_hash