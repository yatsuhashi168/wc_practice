#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  option = { l: false }
  opt = OptionParser.new
  opt.on('-l', 'show number of lines') { option[:l] = true }
  opt.parse!(ARGV)

  files_name = ARGV

  if files_name.empty?
    files = []
    files << $stdin.read
  else
    files = files_name.map do |file|
      File.read(file)
    end
  end

  number_of_lines, number_of_words, sizes = count_lines_words_sizes(files)

  if option[:l]
    l_option_output(number_of_lines, files, files_name)
  else
    output(number_of_lines, number_of_words, sizes, files, files_name)
  end
end

def count_lines_words_sizes(files)
  number_of_lines = files.map { |line| line.count("\n") }
  number_of_words = files.map { |word| word.split(' ').size }
  sizes = files.map(&:bytesize)
  [number_of_lines, number_of_words, sizes]
end

def l_option_output(number_of_lines, files, files_name)
  files.size.times do |i|
    print number_of_lines[i].to_s.rjust(8)
    print " #{files_name[i]}" unless files_name.empty?
    puts
  end
  return if files.size == 1

  print number_of_lines.sum.to_s.rjust(8)
  print ' total'
end

def output(number_of_lines, number_of_words, sizes, files, files_name)
  files.size.times do |i|
    print number_of_lines[i].to_s.rjust(8)
    print number_of_words[i].to_s.rjust(8)
    print sizes[i].to_s.rjust(8)
    print " #{files_name[i]}" unless files_name.empty?
    puts
  end

  return if files.size == 1

  print number_of_lines.sum.to_s.rjust(8)
  print number_of_words.sum.to_s.rjust(8)
  print sizes.sum.to_s.rjust(8)
  print ' total'
end

main
