function _encode(loc) {
	val = 0
	if (loc < 0) {
		val = 0
		if (loc < -90) {
			val = 1000000000
			loc += 90
		}
	} else {
		val = 2000000000
		if (loc > 90) {
			val = 3000000000
			loc -= 90
		}
	}
	val += Math.abs(loc) * 10000000
	val = parseInt(val)
	val = val.toString(16)
	first = String.fromCharCode(parseInt(val.substring(0, 4), 16))
	second = String.fromCharCode(parseInt(val.substring(4), 16))
	return first + second
}

function encode(lat, lon) {
	return "\u2641" +  _encode(lat) + _encode(lon)
}

function _decode(loc) {
	first = loc.charCodeAt(0).toString(16) + loc.charCodeAt(1).toString(16)
	val = parseInt(first, 16)
	neg = 1
	if (val < 2000000000) {
		neg = -1
	}
	increase = val.toString().charAt(0) == 1 || val.toString().charAt(0) == 3
	if (val > 1000000000) {
		val = parseInt(val.toString().substring(1))
	}
	val = val / 10000000.0
	if (increase) {
		val += 90
	}
	return val * neg
}

function decode(code){
	if (code.charAt(0) != "\u2641") {
		return -1
	}
	lat = _decode(code.substring(1,3))
	lon = _decode(code.substring(3))
	return [lat, lon]
}
