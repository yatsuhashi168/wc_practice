# frozen_string_literal: true

def main
  p ARGV
  IO.foreach(ARGV) { |x| print 'got', x }
end
