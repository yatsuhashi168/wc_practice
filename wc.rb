# frozen_string_literal: true

require 'optparse'

def main
  number_of_line = IO.read(ARGV[0]).count("\n")
  number_of_word = IO.read(ARGV[0]).split(' ').size
  size = IO.read(ARGV[0]).size
  print number_of_line.to_s.rjust(8)
  print number_of_word.to_s.rjust(8)
  print size.to_s.rjust(8)
  print ARGV[0]
end

main

# p File.open(ARGV[0]).read.count("\n")
