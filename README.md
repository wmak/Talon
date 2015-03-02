# Talon
A method of storing latitude and longitude in 4 unicode8 characters to make
conveying location shorter.

Given two values A, B in the format xxx.yyyyyy
Let the integer parts in binary of each be int<sub>A</sub> and int<sub>B</sub>.
Let the decimal parts in binary of each be dec<sub>A</sub> and dec<sub>B</sub>.
and for each decimal part,
Let the first 10 bits be dec<sub>X1</sub> and the second 10 bits be dec<sub>X2</sub>

Let H be the UTF-8 headers.
Let F be filler bits to avoid bad code points.
## Character 1
 0 1 2 3 4 5 6 7
+-+-+-+-+-+-+-+-+
|    H    | F | |
+-+-+-+-+-+-+-+ +
| H |   int<sub>A</sub>    |
+-+-+   +-+-+-+-+
| H |   |       |
+-+-+-+-+       +
| H |   dec<sub>A1</sub>       |
+-+-+-+-+-+-+-+-+

# Notes
* Latitude and Longitude are assumed to be 64-bit floating-point numbers since
  their accuracy is dependent on the number of decimals stored.
* The accuracy of the location stored is accurate to 11mm according to
  [this](http://gis.stackexchange.com/questions/8650/how-to-measure-the-accuracy-of-latitude-and-longitude)
  Stack Exchange answer.
