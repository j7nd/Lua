#!/usr/local/bin/lua

--[[
Function to calculate all combinations of elements from the given list. 

Mandatory params:
res - the output table
list - input list

Service params (are only used to pass parameters in recursive function calls):
taken - list of taken elements
first - first element from the remaining list
--]]

function calculate(res, list, taken, first)
	
	-- any better way to initialize variables?	
	if not taken then 
		taken = {} 
	end

	-- if base case reached, put first element and all prevously taken into a
	-- table and insert it into result	
	if #list == 0 then
		local re = {}
		table.move(taken, 1, #taken, 1, re)
		table.insert(re, first)
		table.insert(res, re)
		return true
	end	
	
	-- NOT taking the element. If not base case, add the first remaining element 
	-- to taken for it to be added to second branch result
	if not calculate(
			res, 
			table.move(list, 2, #list, 1, {}), 
			table.move(taken, 1, #taken, 1, {})
			) 
	then
		table.insert(taken, list[1])
	end

	-- TAKING the first element, which is then added to taken elements and added
	-- to the result
	calculate(
			res, 
			table.move(list, 2, #list, 1, {}), 
			table.move(taken, 1, #taken, 1, {}), 
			list[1]
			)
end

-- function to output the result
function printres(r)
	for i=1, #r do
		io.write("[ ")
		for j=1, #r[i] do
			io.write(res[i][j], " ")
		end
		io.write("]\n")
	end
end

-- test scenarios

list = {}

for i = 1, 5 do
	io.write("Combinations of ",#list," element(s):\n")
	res = {}
	calculate(res, list)
	printres(res)
	table.insert(list, i)
end
