import hue


var
    red = Hue(hue: 0)
    blue = Hue(hue: 240)


echo (red +/ blue).hue
echo (red +/ (blue + 40)).hue
echo (red +/ (blue - 40)).hue
echo (red +/ (blue - 100)).hue
echo (red +/ 179).hue
echo (red +/ 180).hue
echo (red +/ 181).hue