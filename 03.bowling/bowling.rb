#!/usr/bin/env ruby
# frozen_string_literal: true

score  = ARGV[0]
scores = score.split(',')
shots  = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = (1..10).map do |i|
  if i < 10
    shots.shift(2)
  else
    shots.each_with_index do |shot, j|
      shots.delete_at(j + 1) if shot == 10
    end
    shots
  end
end

total_point = 0
frames.each_with_index do |frame, i|
  # 全てのフレーム
  total_point += frame.sum

  # ストライク
  if frame[0] == 10
    if i == 8
      total_point += frames[i + 1][0..1].sum
    elsif i < 8
      total_point += frames[i + 1][0]
      total_point += if frames[i + 1][0] == 10
                       frames[i + 2][0]
                     else
                       frames[i + 1][1]
                     end
    end
  # スペア
  elsif frame.sum == 10
    total_point += frames[i + 1][0]
  end
end

puts total_point
