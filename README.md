# Talon
A method of storing latitude and longitude in 4 unicode8 characters to make
conveying location shorter.

# Notes
* Latitude and Longitude are assumed to be 64-bit floating-point numbers since
  their accuracy is dependent on the number of decimals stored.
* The accuracy of the location stored is accurate to 11mm according to
  [this](http://gis.stackexchange.com/questions/8650/how-to-measure-the-accuracy-of-latitude-and-longitude)
  Stack Exchange answer.
