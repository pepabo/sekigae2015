#!/usr/bin/env ruby
# Usage: cat names.txt | ruby sekigae.rb

readlines.map(&:chomp).shuffle.each_slice(2).map do |p|
  len = p.map(&:size).max; p.map {|n| n.ljust(len) }
end.transpose.each do |l|
  puts l.join(' ')
end
