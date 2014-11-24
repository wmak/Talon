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

func Decode(code string) (lat, lon float64) {
	var _decode = func(character []rune) float64 {
		var loc float64
		first := strconv.QuoteRuneToASCII(character[0])
		second := strconv.QuoteRuneToASCII(character[1])
		val, _ := strconv.ParseInt("0x" + first[3:7] + second[3:7], 0, 32)
		sval := strconv.FormatInt(val, 10)
		loc = 1
		if (val < 2000000000){
			loc = -1
		}
		if (val > 1000000000){
			val, _ = strconv.ParseInt(sval[2:], 0, 0)
		}
		fval := math.Mod(float64(val), 1000000000)
		if (sval[1] == 1 || sval[1] == 3) {
			fval += 90
		}
		return fval/10000000 * loc
	}
	return _decode([]rune(code)[:2]), _decode([]rune(code)[2:])
}
