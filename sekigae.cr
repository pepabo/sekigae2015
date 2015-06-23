# Usage: crystal sekigae.cr -- names.txt

shuffled = File.open(ARGV.first).each_line.map(&.chomp).to_a.shuffle

pairs = shuffled.each_slice(2).map do |pair|
  pair.map(&.ljust pair.map(&.size).max)
end

puts pairs.map(&.[0]).join(' ')
puts pairs.rewind.map(&.[1]).join(' ')
