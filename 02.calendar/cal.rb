# frozen_string_literal: true

require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-y VAL') do |v|
  v if (1..12).cover?(v.to_i)
end

opt.on('-m VAL') do |v|
  v if (1..31).cover?(v.to_i)
end

params = {}
opt.parse!(ARGV, into: params)

today = Date.today

y = if params[:y].nil?
      today.year
    else
      params[:y].to_i
    end

m = if params[:m].nil?
      today.month
    else
      params[:m].to_i
    end

class MyCal
  def initialize(year, month)
    @year  = year
    @month = month
  end

  def show
    puts "　　　#{@month}月 #{@year}"
    puts '日 月 火 水 木 金 土'
    (1..31).each do |n|
      d = Date.new(@year, @month, n)
      youbi = d.wday
      youbi.times { print '   ' } if n == 1

      if d == Date.today
        print "\e[30m\e[47m\e[5m#{d.day.to_s.rjust(2)}\e[0m"
      else
        print d.day.to_s.rjust(2)
      end

      if youbi == 6
        puts "\n"
      else
        print ' '
      end
    rescue StandardError
      break
    end
    puts "\n\n"
  end
end

cal = MyCal.new(y, m)
cal.show
