#! /usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'date'

opt = OptionParser.new
opt.on('-y VAL') do |v|
  if (1970..2100).cover?(v.to_i)
    v
  else
    abort "エラー: 正しく処理できない年です '#{v}'"
  end
end

opt.on('-m VAL') do |v|
  if (1..12).cover?(v.to_i)
    v
  else
    abort "エラー: 正しく処理できない月です '#{v}'"
  end
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
    puts "#{@month}月 #{@year}".center(20)
    puts '日 月 火 水 木 金 土'
    first_day = Date.new(@year, @month, 1)
    last_day  = Date.new(@year, @month, -1)

    print '   ' * first_day.wday

    (first_day..last_day).each do |date|
      if date == Date.today
        print "\e[7m#{date.day.to_s.rjust(2)}\e[0m"
      else
        print date.day.to_s.rjust(2)
      end
      print(date.saturday? ? "\n" : ' ')
    end
    puts
    puts
  end
end

cal = MyCal.new(y, m)
cal.show
