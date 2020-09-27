'Nunchuk controlled square - eight directional
'NUNCHUK(funct, channel) --> returns data from a Nunchuk controller
'JX, JY, AX, AY, AZ, Z, C, T, JXL, JXC, JXR, JYT, JYC, JYB, AX0, AX1, AY0, AY1, AZ0, AZ1
dim integer x, y, boxcolor
dim contant w, h, t, u, d, l, r 
dim string n$
cls
mode 1, 8
x = 399 : y = 299 : w = 12 : h = 12 : t = 1 
box x, y, w, h, t, rgb(yellow)     
wii nunchuk open 3
cls
pause 500 : boxcolor = 0

do
  'cls
  'n$ = "Joystick X axis / Y axis = " + str$(nunchuk(JX, 3)) + " / " + str$(nunchuk(JY, 3))
  'text 8, 12, n$, "LT"
  'n$ = "Acceleration X / Y / Z = " + str$(nunchuk(AX, 3)) + " / " + str$(nunchuk(AY, 3)) + str$(nunchuk(AZ, 3))
  'text 8, 24, n$, "LT"
  'n$ = "Buttons top / bottom = " + str$(nunchuk(Z, 3)) + " / " + str$(nunchuk(C, 3))
  'text 8, 36, n$, "LT"
  'pause 50

  cls
  if nunchuk(JY, 3) > 128 and nunchuk(JX, 3) < 128 then 'up/left
    y = y - 1 : x = x - 1
  elseif nunchuk(JY, 3) > 128 and nunchuk(JX, 3) > 128 then 'up/right
    y = y - 1 : x = x + 1
  elseif nunchuk(JY, 3) < 128 and nunchuk(JX, 3) < 128 then 'down/left
    y = y + 1 : x = x - 1
  elseif nunchuk(JY, 3) < 128 and nunchuk(JX, 3) > 128 then 'down/right
    y = y + 1 : x = x + 1
  elseif nunchuk(JY, 3) > 128 then 'up
    y = y - 1
  elseif nunchuk(JY, 3) < 128 then 'down
    y = y + 1
  elseif nunchuk(JX, 3) < 128 then 'left
    x = x - 1
  elseif nunchuk(JX, 3) > 128 then 'right
    x = x + 1
  elseif nunchuk(Z, 3) = 1 then 
    if boxcolor = 0 or boxcolor = 2 then  
      boxcolor = 1
      box x, y, w, h, t, rgb(green)
    else 
      boxcolor = 0
      box x, y, w, h, t, rgb(yellow)  
    endif
  elseif nunchuk(C, 3) = 1 then
    if boxcolor = 0 or boxcolor = 1 then
      boxcolor = 2
      box x, y, w, h, t, rgb(red) 
    else 
      boxcolor = 0
      box x, y, w, h, t, rgb(yellow)
    endif
  endif
  
  if x < 0 then x = 0
  if x > 799 - w then x = 799 - w
  if y < 0 then y = 0
  if y > 600 - h then y = 600 - h
  
  if boxcolor = 0 then
    box x, y, w, h, t, rgb(yellow)
  elseif boxcolor = 1 then
    box x, y, w, h, t, rgb(green)
  elseif boxcolor = 2 then
    box x, y, w, h, t, rgb(red)  
  endif
  pause 5
loop
wii nunchuk close 3











