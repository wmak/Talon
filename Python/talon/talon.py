#!/usr/bin/env python
# -*- coding: utf-8 -*-

def _encode(loc):
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
    val += abs(loc) * 10000000
    val = hex(int(val))[2:]
    first = unichr(int(val[:4], 16))
    second = unichr(int(val[4:], 16))
    return first, second

def encode(lat, lon):
    ''' encode takes a longitude and a latitude and using the algorithm
    described in the README(Todo) creates a 4 character unicode string '''
    first, second = _encode(lat)
    third, fourth = _encode(lon)
    return first, second, third, fourth

def _decode(first, second, scale):
    first = "%x%x" % (ord(first), ord(second))
    val = int(first, 16)
    loc = 1
    if val < 2000000000: 
        loc *= -1
    increase = str(val)[1] == 1 or str(val)[1] == 3
    if val > 1000000000:
        val = int(str(val)[1:])
    if increase:
        loc = (val / scale + 90) * loc
    else:
        loc = val / scale * loc
    return loc

def decode(code):
    first, second, third, fourth = code
    lat = _decode(first, second, 10000000.0)
    lon = _decode(third, fourth, 10000000.0)
    return lat, lon
