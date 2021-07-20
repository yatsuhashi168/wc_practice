#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  option = { l: false }
  opt = OptionParser.new
  opt.on('-l', 'show number of lines') { option[:l] = true }
  opt.parse!(ARGV)

  standard_input = false
  if ARGV.empty?
    files = []
    files << $stdin.read
    standard_input = true
  else
    files = ARGV
  end

  number_of_lines, number_of_words, sizes = count_lines_words_sizes(files, standard_input)

  if option[:l]
    l_option_output(number_of_lines, files, standard_input)
  else
    output(number_of_lines, number_of_words, sizes, files, standard_input)
  end
end

def count_lines_words_sizes(files, standard_input)
  case standard_input
  when true
    number_of_lines = files.map { |line| line.count("\n") }
    number_of_words = files.map { |word| word.split(' ').size }
    sizes = files.map(&:bytesize)
  else
    number_of_lines = files.map { |line| IO.read(line).count("\n") }
    number_of_words = files.map { |word| IO.read(word).split(' ').size }
    sizes = files.map { |size| IO.read(size).size }
  end
  [number_of_lines, number_of_words, sizes]
end

def l_option_output(number_of_lines, files, standard_input)
  files.size.times do |i|
    print number_of_lines[i].to_s.rjust(8)
    print " #{files[i]}" unless standard_input
    puts
  end
  return if files.size == 1

  print number_of_lines.sum.to_s.rjust(8)
  print ' total'
end

def output(number_of_lines, number_of_words, sizes, files, standard_input)
  files.size.times do |i|
    print number_of_lines[i].to_s.rjust(8)
    print number_of_words[i].to_s.rjust(8)
    print sizes[i].to_s.rjust(8)
    print " #{files[i]}" unless standard_input
    puts
  end

  return if files.size == 1

  print number_of_lines.sum.to_s.rjust(8)
  print number_of_words.sum.to_s.rjust(8)
  print sizes.sum.to_s.rjust(8)
  print ' total'
end

main
