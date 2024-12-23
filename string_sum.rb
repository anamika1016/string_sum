class StringSum
  def self.add(data)
    return 0 if data.empty?
    delimiter = /,|\n/
    if data.start_with?("//")
        delimiter, data = data[2..].split("\n", 2)
        delimiter = Regexp.escape(delimiter)
    end
    numbers = data.split(/#{delimiter}|,|\n/)
    negatives = numbers.select { |n| n.to_i < 0 }
    raise "negative values not allowed: #{negatives.join(', ')}" if negatives.any?
    numbers.sum(&:to_i)
  end
end

puts StringSum.add("") # => 0
puts StringSum.add("5") #=> 5
puts StringSum.add("1,5") #=> 6
puts StringSum.add("1,5,3") #=> 9
puts StringSum.add("1\n2,3") # => 6
puts StringSum.add("10,20,30") # => 60
puts StringSum.add("//;\n1;2;3")