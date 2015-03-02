# Talon
A method of storing latitude and longitude in 4 unicode8 characters to make
conveying location shorter.

Given two values A, B in the format xxx.yyyyyy

Let the integer parts in binary of each be int_A and int_B, both 8 bits.
And for each integer the first bit is a sign bit denoted by S.
Let the decimal parts in binary of each be dec_A and dec_B.
and for each decimal part,
Let the first 10 bits be dec_X1 and the second 10 bits be dec_X2.

Let H be the UTF-8 headers.

Let F be filler bits used to avoid bad code points.
## Character 1
````
 0 1 2 3 4 5 6 7
+-+-+-+-+-+-+-+-+
|    H    | F |S|
+-+-+-+-+-+-+-+-+
| H |   int_A   |
+-+-+   +-+-+-+-+
| H |   |       |
+-+-+-+-+       +
| H |   dec_A1  |
+-+-+-+-+-+-+-+-+
````
## Character 2
````
 0 1 2 3 4 5 6 7
+-+-+-+-+-+-+-+-+
|    H    | F |S|
+-+-+-+-+-+-+-+-+
| H |   int_B   |
+-+-+   +-+-+-+-+
| H |   |       |
+-+-+-+-+       +
| H |   dec_B1  |
+-+-+-+-+-+-+-+-+
````
## Character 1
````
 0 1 2 3 4 5 6 7
+-+-+-+-+-+-+-+-+
|    H    |F|   |
+-+-+-+-+-+-+   +
| H |   dec_A2  |
+-+-+   +-+-+-+-+
| H |   |       |
+-+-+-+-+       +
| H |   dec_B2  |
+-+-+-+-+-+-+-+-+
````
# Notes
* Latitude and Longitude are assumed to be 64-bit floating-point numbers since
  their accuracy is dependent on the number of decimals stored.
* The accuracy of the location stored is accurate to 11mm according to
  [this](http://gis.stackexchange.com/questions/8650/how-to-measure-the-accuracy-of-latitude-and-longitude)
  Stack Exchange answer.
