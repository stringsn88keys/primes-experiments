require 'prime'
require 'benchmark'

puts Prime.first(2**16).last

bit_min = Prime.each(2**16).inject(0) do |sum, prime|
  sum + ((prime.to_s(2).length+2)/8*8+8)
end

puts bit_min
puts bit_min / 8


def count_primes_under_bit_size(bit_size)
  prime_size = 2**bit_size
  Prime.each.inject(0) do |count, prime|
    break count if prime >= prime_size
    count.succ
  end
end

def benchmark_primes_under_bit_size(bit_size)
  time = Benchmark.measure do
    @primes = count_primes_under_bit_size(bit_size)
  end
  puts "count primes #{bit_size} bits or fewer: #{@primes}"
  puts time
end

time = Benchmark.measure do
  @primes = Prime.first(203280221)
end
puts "get primes 32 bits or fewer: #{@primes.length}"
puts time

[8, 16, 32].each do |bit_size|
  benchmark_primes_under_bit_size(bit_size)
end



# 3.1.2p20
# count primes 8 bits or fewer: 54
#   0.000017   0.000000   0.000017 (  0.000014)
# count primes 16 bits or fewer: 6542
#   0.001019   0.000000   0.001019 (  0.001019)
# count primes 32 bits or fewer: 203280221
# 588.147609  47.146145 635.293754 (654.113208)

# 3.2.2
# count primes 8 bits or fewer: 54
#   0.000017   0.000002   0.000019 (  0.000016)
# count primes 16 bits or fewer: 6542
#   0.001008   0.000001   0.001009 (  0.001011)
# count primes 32 bits or fewer: 203280221
# 561.317393  88.809890 650.127283 (679.776204)
#
# with get primes first
# get primes 32 bits or fewer: 203280221
# 551.674857  86.462937 638.137794 (669.456197)
# count primes 8 bits or fewer: 54
#   0.000022   0.000015   0.000037 (  0.000036)
# count primes 16 bits or fewer: 6542
#   0.001040   0.000000   0.001040 (  0.001043)
# count primes 32 bits or fewer: 203280221
#  32.077632   0.393656  32.471288 ( 32.688255)
