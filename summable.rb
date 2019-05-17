require 'benchmark'

@numbers = [9, 1, -2, 6, 10, -5, -3, -1, -4, 8, 4, 5, 7, 0, 3, 2]
@numbers = []
5_000_000.times { @numbers << rand(1..100) }

def find_summing_numbers_with_hash(target)
  answer_hash = {}
  @numbers.each do |num|
    if answer_hash[num].nil?
      answer_hash[target-num] = num
    else
      return [num,answer_hash[num]]
    end
  end
  return [nil,nil]
end

p "Hash"
p find_summing_numbers_with_hash(13)
p find_summing_numbers_with_hash(16)
p find_summing_numbers_with_hash(50)

def find_summing_numbers_sort_and_index(target)
  numbers = @numbers.sort
  front = 0
  back = numbers.length-1

  while front < back
    lil = numbers[front]
    big = numbers[back]
    if lil + big == target
      return [lil,big]
    elsif lil + big > target
      back -= 1
    elsif lil + big < target
      front += 1
    end
  end
  return [nil,nil]
end

p "Sort"
p find_summing_numbers_sort_and_index(13)
p find_summing_numbers_sort_and_index(16)
p find_summing_numbers_sort_and_index(50)

def find_summing_numbers_with_double_loop(target)
  numbers = [9, 1, -2, 6, 10, -5, -3, -1, -4, 8, 4, 5, 7, 0, 3, 2]

  @numbers.each_with_index do |num1,i|
    @numbers[i+1..-1].each_with_index do |num2,j|
      return [num1,num2] if num1 + num2 == target
    end
  end
  return [nil,nil]
end

p "Double loop"
p find_summing_numbers_with_double_loop(13)
p find_summing_numbers_with_double_loop(16)
p find_summing_numbers_with_double_loop(50)

def find_summing_numbers_with_random_sample(target)
  tried = []
  while tried.length < @numbers.length
    num1 = @numbers.sample
    num2 = @numbers.sample
    return [num1,num2] if num1 + num2 == target
    tried << num1
    tried << num2
  end
  return [nil,nil]
end

p "Random sampling"
p find_summing_numbers_with_random_sample(13)
p find_summing_numbers_with_random_sample(16)
p find_summing_numbers_with_random_sample(50)

def find_summing_numbers_with_enum(target)
  @numbers.combination(2).find do |x,y|
    target = x + y
  end
end

p "Enum"
p find_summing_numbers_with_enum(13)
p find_summing_numbers_with_enum(16)
p find_summing_numbers_with_enum(50)

Benchmark.bm(12) do |b|
  b.report("hash") {
    find_summing_numbers_with_hash(13)
    find_summing_numbers_with_hash(16)
    find_summing_numbers_with_hash(50)
  }

  b.report("sort") {
    find_summing_numbers_sort_and_index(13)
    find_summing_numbers_sort_and_index(16)
    find_summing_numbers_sort_and_index(50)
  }

  b.report("double loop") {
    find_summing_numbers_with_double_loop(13)
    find_summing_numbers_with_double_loop(16)
    find_summing_numbers_with_double_loop(50)
  }

  b.report("random sample") {
    find_summing_numbers_with_random_sample(13)
    find_summing_numbers_with_random_sample(16)
    find_summing_numbers_with_random_sample(50)
  }

  b.report("enum") {
    find_summing_numbers_with_enum(13)
    find_summing_numbers_with_enum(16)
    find_summing_numbers_with_enum(50)
  }
end
