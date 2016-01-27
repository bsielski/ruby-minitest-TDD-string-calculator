require_relative '../test_helper'


class StringCalculatorTests < MiniTest::Test
  def setup
    @calc = StringCalculator.new
  end

  def test_add_emptyString_returnsZero
    result = @calc.add("")
    assert_equal 0, result
  end
  def test_add_oneNumber_returnsThatNumber
    result = @calc.add("1")
    assert_equal 1, result
  end
  def test_add_twoNumbers_returnsSumOfThoseNumbers
    result = @calc.add("1,2")
    assert_equal 3, result
  end
  def test_add_twoNumbersBiggerThanOneDigit_returnsSumOfThoseNumbers
    result = @calc.add("10,20")
    assert_equal 30, result
  end
  def test_add_unknownAmoutOfNumbersWithUnknownAmountOfDigitsEach_returnsSumOfThoseNumbers
    def make_random_number_of_random_numbers
      rng = Random.new
      third_of_numbers = rng.rand(1..300)
      numbers = []
      third_of_numbers.times do # I want a mix of long and short numbers
        numbers << rng.rand(1_000_000_000)
        numbers << rng.rand(1_000)
        numbers << rng.rand(20)
      end
      return numbers
    end
    numbers = make_random_number_of_random_numbers
    expected_sum = numbers.inject { |sum, n| sum + n }
    string_to_pass = numbers.join(',')
    testing_result = @calc.add(string_to_pass)
    assert_equal expected_sum, testing_result
  end
  def test_add_threeNumbersSeparatedByComaAndNewLine_returnsSumOfThoseNumbers
    result = @calc.add("1\n2,3")
    assert_equal 6, result
  end
  def test_add_customSeparatorAndEmptyString_returnsZero
    result = @calc.add("//,\n")
    assert_equal 0, result
  end
  def test_add_customSeparatorAndEmptyString_returnsZero_2
    result = @calc.add("//:\n")
    assert_equal 0, result
  end
  def test_add_customSeparatorAndOneNumber_returnsThatNumber
    result = @calc.add("//:\n0")
    assert_equal 0, result
  end
  def test_add_customSeparatorAndOneNumber_returnsThatNumber_2
    result = @calc.add("//:\n1")
    assert_equal 1, result
  end
  def test_add_customSeparatorAndTwoNumbers_returnsSumOfThatNumber
    result = @calc.add("//:\n1:2")
    assert_equal 3, result
  end
  def test_add_customSeparatorAndTwoNumbers_returnsSumOfThatNumber_2
    result = @calc.add("//:\n0:1")
    assert_equal 1, result
  end
  def test_add_customSeparatorAndManyNumbers_returnsSumOfThatNumber
    result = @calc.add("//:\n1:2:3:100")
    assert_equal 106, result
  end
  def test_add_negativeNumber_raisesArgumentError
    assert_raises(ArgumentError) { @calc.add("-1") }
  end
  def test_add_negativeNumberNotFirst_raisesArgumentError
    assert_raises(ArgumentError) { @calc.add("0,1,2,-1") }
  end
  def test_add_negativeNumberNotFirstAndBothSeparators_raisesArgumentError
    assert_raises(ArgumentError) { @calc.add("0\n1\n2,-1") }
  end
  def test_add_negativeNumbersThatGiveException_ExceptionMessageBeginsWithTex
    error = assert_raises(ArgumentError) { @calc.add("///\n0/1/2/-1") }
    assert_equal "negatives not allowed: ", error.message[0..22]
  end
  def test_add_negativeNumbersThatGiveException_ExceptionMessageBeginsWithTexAndThenNegativeNumbers
    error = assert_raises(ArgumentError) { @calc.add("///\n0/1/2/-1") }
    assert_equal "negatives not allowed: -1", error.message
  end
  def test_add_manyNegativeNumbersThatGiveException_ExceptionMessageBeginsWithTexAndThenNegativeNumbers
    error = assert_raises(ArgumentError) { @calc.add("///\n0/1/2/-1/-3") }
    assert_equal "negatives not allowed: -1, -3", error.message
  end

  # def test_add_negativeNumbers_raisesArgumentError
  #   assert_raises(ArgumentError) { @calc.add("///\n0/1/2/-1") }
  # end

  # def test_itAlwaysFails
  #   assert_equal 1, 2
  # end
end
