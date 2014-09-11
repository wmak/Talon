function encode(loc) {
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
	console.log(val.substring(4))
	return first + second
}
