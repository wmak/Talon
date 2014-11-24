#!/usr/bin/env ruby

# Encode long co-ordinate pairs into a small utf-8 encoded string.
module Talon
  def self.encode(lat, long)
    # encode the latitude & longitude,
    # split each into 2 hex strings, 4 characters long
    # turn them into unicode characters, and join as string
    [lat, long]
      .map { |x| format('%08x', _encode(x)).scan(/.{4}/) }
      .map { |x| x.map { |y| [y.to_i(16)].pack 'U' } }
      .join
  end

  def self.decode(str)
    # turn the given string's value into an 8-char hex string
    # decode the integer representation of that
    str.scan(/.{2}/)
       .map { |x| format('%04x%04x', x[0].ord, x[1].ord) }
       .map { |x| _decode(x.to_i(16)) }
  end

  private

  def self._encode(loc)
    location = loc.abs  # so that the function remains non-destructive

    encoding = loc >= 0 ? 2_000_000_000 : 0

    if location > 90
      encoding += 1_000_000_000
      location -= 90
    end

    encoding + (location * 10_000_000).to_i
  end

  def self._decode(enc)
    encoding = enc  # so that the function remains non-destructive

    positive = encoding >= 2_000_000_000
    encoding -= 2_000_000_000 if positive

    over_90 = encoding >= 1_000_000_000
    encoding -= 1_000_000_000 if over_90

    location = over_90 ? 90 : 0
    location += encoding / 10_000_000.0

    location * (positive ? 1 : -1)
  end
end
