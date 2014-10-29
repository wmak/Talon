def unichr(code_point)
  [code_point].pack("U")
end

def _encode(loc)
  val = 0
  if loc < 0
    val = 0
    if loc < -90
      val = 1000000000
      loc += 90
    end
  else
    val = 2000000000
    if loc > 90
      val = 3000000000
      loc -= 90
    end
  end

  val += (loc.abs * 10000000).to_i
  val = val.to_s(16)
  first = unichr(val[0,4].to_i(16))
  second = unichr(val[4..-1].to_i(16))

  return first + second
end

def encode(lat, lon)
  return "\u2641" +  _encode(lat) + _encode(lon)
end

def _decode(loc)
  loc0 = loc[0].ord
  loc1 = loc[1].ord

  first = loc0.to_s(16) + loc1.to_s(16)
  val = first.to_i(16)
  neg = 1

  if val < 2000000000
    neg = -1
  end

  if val.to_s[0] == "1" or val.to_s[0] == "3"
    increase = true
  end
  
  if val > 1000000000
    val = val.to_s[1..-1].to_i
  end

  val = val / 10000000.0

  if increase
    val += 90
  end

  return val
end

def decode(code)
  lat = _decode(code[1,2])
  lon = _decode(code[3,4])

  return [lat, lon]
end

# puts encode(41.25, -120.9762)
# puts decode("♁迋퐠丑懐")