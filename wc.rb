# frozen_string_literal: true

require 'optparse'

def main
  option = { l: false }
  opt = OptionParser.new
  opt.on('-l', 'show number of lines') { option[:l] = true }
  opt.parse!(ARGV)

  number_of_lines = ARGV.map { |line| IO.read(line).count("\n") }
  number_of_words = ARGV.map { |word| IO.read(word).split(' ').size }
  sizes = ARGV.map { |size| IO.read(size).size }

  if option[:l]
    ARGV.size.times do |i|
      print number_of_lines[i].to_s.rjust(8)
      print " #{ARGV[i]}"
      puts
    end
    if ARGV.size != 1
      print number_of_lines.sum.to_s.rjust(8)
      print ' total'
    end
  else
    ARGV.size.times do |i|
      print number_of_lines[i].to_s.rjust(8)
      print number_of_words[i].to_s.rjust(8)
      print sizes[i].to_s.rjust(8)
      print " #{ARGV[i]}"
      puts
    end
    if ARGV.size != 1
      print number_of_lines.sum.to_s.rjust(8)
      print number_of_words.sum.to_s.rjust(8)
      print sizes.sum.to_s.rjust(8)
      print ' total'
    end
  end
end

main
