#!/usr/bin/env ruby

# Encode long co-ordinate pairs into a small utf-8 encoded string.
module Talon
  def self.encode(lat, long)
    [lat, long]
    .map { |x| format('%08x', _encode(x)).scan(/.{4}/) }
    .map { |x| x.map { |y| [y.to_i(16)].pack 'U' } }
    .join
  end

  def self.decode(str)
    str.scan(/.{2}/)
    .map { |x| format('%04x%04x', x[0].ord, x[1].ord).to_i(16) }
    .map { |x| _decode(x) }
  end

  private

  def self._encode(loc)
    location = loc.abs

    encoding = loc >= 0 ? 2_000_000_000 : 0

    if location > 90
      encoding += 1_000_000_000
      location -= 90
    end

    encoding + (location * 10_000_000).to_i
  end

  def self._decode(enc)
    encoding = enc # so that the function remains non-destructive

    positive = encoding >= 2_000_000_000
    encoding -= 2_000_000_000 if positive

    over_90 = encoding >= 1_000_000_000
    encoding -= 1_000_000_000 if over_90

    location = over_90 ? 90 : 0
    location += encoding / 10_000_000.0

    location * (positive ? 1 : -1)
  end
end
