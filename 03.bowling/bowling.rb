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

total_point = frames.each_with_index.sum do |frame, i|
  frame_point = frame.sum

  if frame[0] == 10
    if i == 8
      frame_point += frames[i + 1][0..1].sum
    elsif i < 8
      frame_point += frames[i + 1][0]
      frame_point += if frames[i + 1][0] == 10
                       frames[i + 2][0]
                     else
                       frames[i + 1][1]
                     end
    end
  elsif frame.sum == 10
    frame_point += frames[i + 1][0] unless i == 9
  end

  frame_point
end

puts total_point
