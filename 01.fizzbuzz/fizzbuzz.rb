# frozen_string_literal: true

20.times do |n|
  n += 1
  if (n % 3).zero? && (n % 5).zero?
    puts 'FizzBuzz'
  elsif (n % 3).zero?
    puts 'Fizz'
  elsif (n % 5).zero?
    puts 'Buzz'
  else
    puts n
  end
end
