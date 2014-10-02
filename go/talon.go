package talon

import (
	"fmt"
	"math"
	"strconv"
)

func Encode(lat, lon float64) string {
	var _encode = func(loc float64) string {
		var val float64
		var hval string
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
		val += math.Abs(loc) * 10000000
		hval = fmt.Sprintf("%X", int(val))
		first, _ := strconv.ParseInt("0x" + hval[:4], 0, 32)
		second, _ := strconv.ParseInt("0x" + hval[4:], 0, 32)
		return fmt.Sprintf("%c%c", first, second)
	}
	return _encode(lat) + _encode(lon)
}
