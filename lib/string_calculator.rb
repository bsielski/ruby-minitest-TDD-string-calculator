class StringCalculator
  def add(numbers)
    custom_separator = nil
    if numbers[0] == "/" && numbers[1] == "/" && numbers[3] == "\n"
      custom_separator = numbers[2]
      # puts custom_separator
    end
    if custom_separator
      # puts "numbers before slice #{numbers}"
      numbers.slice!(0..3)
      # puts "numbers after slice #{numbers}"
      splitted = numbers.split(custom_separator)
      # puts "splitted #{splitted}"
    else
      splitted = numbers.split(',')
      splitted.map! do |element|
        element.include?("\n") ? element.split("\n") : element
      end
      splitted.flatten!
    end
    splitted << "0" if splitted.size == 0
    integers = splitted.map &:to_i
    negatives = []
    integers.each do |int|
      if int < 0
        negatives << int
      end
    end
    if negatives.any?
      raise ArgumentError , "negatives not allowed: #{negatives.join(', ')}"
    end
    return integers.inject { |sum, element| sum + element }
  end
end
