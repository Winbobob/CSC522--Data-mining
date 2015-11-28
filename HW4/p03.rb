require 'nmatrix'
require 'pry'

###################################
# Calculate All Frequent Itemsets
###################################
m = NMatrix::IO::Matlab::load_mat 'transaction.mat'
final_hash = Hash.new
mini_supp = m.column(0).size * 0.04

#1-itemset
(1..m.column(0).size).each do |row_num|
	m.row(row_num-1).each_with_index do |item, index|
		i = (index+1).to_s
		if final_hash.has_key? i
			final_hash[i] += item
		else
			final_hash[i] = item
		end
	end
end
final_hash.delete_if {|key, value| value < mini_supp}
	
#2-itemset
one_itemset_keys = final_hash.keys #array
temp_array = final_hash.keys
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
			if final_hash.has_key? i
				final_hash[i] += item
			else
				final_hash[i] = item
			end
		end
	end
end
final_hash.delete_if {|key, value| value < mini_supp}
two_itemsets = final_hash.reject{|key| !key.include?','} #hash
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
		if final_hash.has_key? elem
			final_hash[elem] += item
		else
			final_hash[elem] = item
		end
	end
end
final_hash.delete_if {|key, value| value < mini_supp}

#puts final_hash.sort_by{|k, v| k}.to_h
puts final_hash

#final_hash = {"1"=>84, "2"=>85, "3"=>72, "4"=>78, "5"=>91, "6"=>103, "8"=>93, "10"=>90, "11"=>41, "12"=>68, "13"=>79, "14"=>56, "15"=>95, "16"=>73, "17"=>81, "18"=>51, "19"=>84, "20"=>76, "21"=>40, "22"=>44, "23"=>108, "24"=>82, "25"=>66, "27"=>47, "28"=>90, "29"=>102, "30"=>61, "31"=>49, "32"=>91, "33"=>76, "34"=>78, "35"=>42, "36"=>75, "37"=>84, "38"=>65, "40"=>55, "41"=>66, "42"=>72, "43"=>82, "44"=>62, "45"=>77, "46"=>94, "47"=>85, "48"=>74, "49"=>77, "50"=>59, "1,3"=>40, "1,47"=>47, "2,20"=>40, "4,19"=>41, "5,10"=>49, "6,23"=>58, "13,32"=>44, "13,37"=>41, "17,33"=>40, "19,36"=>46, "28,29"=>53, "32,37"=>42, "13,32,37"=>40}

###################################
# Generate Associate Rules
###################################
rules = Hash.new
iterator = 1
final_hash.each do |key, count|
	temp_array = key.split(',')
	if temp_array.size == 2
		temp_array.each_with_index do |elem, index|
			if 1.0 * count / final_hash[elem] >= 0.1
				rules[iterator] = elem + '->' + temp_array[1-index]
				iterator += 1
			end
		end
	end

	if temp_array.size == 3
		temp_array.each_with_index do |elem, index|
			temp_array2 = key.split(',')
			temp_array2.delete(elem)
			elem2 = temp_array2[0] + ',' + temp_array2[1]
			if 1.0 * count / final_hash[elem] >= 0.1
				rules[iterator] = elem + '->' + elem2
				iterator += 1
			end

			if 1.0 * count / final_hash[elem2] >= 0.1
				rules[iterator] = elem2 + '->' + elem
				iterator += 1
			end
		end
	end
end

puts rules
