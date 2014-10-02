#!/usr/bin/env python
# -*- coding: utf-8 -*-

def _encode(loc):
    # Here we use the first decimal as a flag, if it's negative the first
    # decimal is 0 or 1. If it's positive we set it to 2 or 3. As well if the
    # magnitude of the value is over 90 we use 1 or 3.
    if loc < 0:
        val = 0
        if loc < -90:
            val = 1000000000
            loc += 90
    else:
        val = 2000000000
        if loc > 90:
            val = 3000000000
            loc -= 90
    # Here we store the value with the remaining digits.
    val += abs(loc) * 10000000
    # Truncate anything past the decimal, we can't store those ): then convert
    # to hex
    val = hex(int(val))[2:]
    # Covert to unicode
    first = unichr(int(val[:4], 16))
    second = unichr(int(val[4:], 16))
    return first, second

def encode(lat, lon):
    ''' encode takes a longitude and a latitude and using the algorithm
    described in the README creates a 4 character unicode string '''
    first, second = _encode(lat)
    third, fourth = _encode(lon)
    return first, second, third, fourth

def _decode(first, second):
    # Get the hex representation of the two characters
    first = "%x%x" % (ord(first), ord(second))
    # Convert the hex back into it's value
    val = int(first, 16)
    loc = 1
    # Check the flag and change value accordingly
    if val < 2000000000: 
        loc *= -1
    increase = str(val)[1] == 1 or str(val)[1] == 3
    if val > 1000000000:
        val = int(str(val)[1:])
    if increase:
        loc = (val / 10000000.0 + 90) * loc
    else:
        loc = val / 10000000.0 * loc
    return loc

def decode(code):
    ''' decode takes a code according to the talon specifications and returns
    the latitude and longitude it represents. '''
    first, second, third, fourth = code
    lat = _decode(first, second)
    lon = _decode(third, fourth)
    return lat, lon
