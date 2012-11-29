def double_it(nums)
  nums.map{|x| x*2}
end

def sum nums
  nums.inject(0){|sum, x| sum + x}
end

def above_10? num
  num.any?{|x| x > 10}
end

def all_above_10? nums
  return false if nums.empty?
  nums.all?{|x| x > 10}
end


def reduce_test(array)
  array.reduce(''){|sum, row| sum + row.reduce('') { |cellSum, cell| cellSum + cell } + '\r\n' }
end