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