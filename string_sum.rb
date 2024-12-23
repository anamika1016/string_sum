require 'minitest/autorun'
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
puts StringSum.add("//;\n1;2;3") # =>6
# puts StringSum.add("1,-2,-3") # => "negative values not allowed: -2, -3"
# puts StringSum.add("//,\n1,-2,-3") # => "negative values not allowed: -2, -3"

class StringSumTest < Minitest::Test
  # Test for adding with an empty string.
  def test_addition_with_empty_string
    assert_equal 0, StringSum.add("")
  end

  # Test for adding with a single digit number.
  def test_addition_with_one_number
    assert_equal 2, StringSum.add("2")
  end

  # Test for adding with two digit numbers.
  def test_addition_with_two_numbers
    assert_equal 6, StringSum.add("2,4")
  end

  # Test for adding with a mix of comma and newline separated numbers.
  def test_addition_with_mixed_separators
    assert_equal 23, StringSum.add("5,7\n3,8")
  end

  # Test for adding with multiple numbers.
  def test_addition_with_multiple_numbers
    assert_equal 30, StringSum.add("4,5,6,7,8")
  end
end