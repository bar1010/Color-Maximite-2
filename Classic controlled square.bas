'Wii Classic Controller controlled square - eight directional
'CLASSIC(funct, channel) --> returns data from a Wii Classic controller
'LX, LY, RX, RY, L, R, B, T
dim integer x, y
dim contant w, h, t, u, d, l, r 
dim string c$, e$
cls : mode 1, 16
x = 399 : y = 299 : w = 12 : h = 12 : t = 1 
const buttonr = 1, buttonstart = 2, buttonhome = 4, buttonselect = 8
const buttonl = 16, buttondown = 32, buttonright = 64, buttonup = 128
const buttonleft = 256, buttonzr = 512, buttonx = 1024, buttona = 2048
const buttony = 4096, buttonb = 8192, buttonzl = 16384
box x, y, w, h, t, rgb(yellow)     
wii classic open 3 : cls : pause 500

do
  cls

  'LY/LX Left joystick
  if classic(LY, 3) > 128 and classic(LX, 3) < 128 then 'up/left
    y = y - 1 : x = x - 1
  elseif classic(LY, 3) > 128 and classic(LX, 3) > 128 then 'up/right
    y = y - 1 : x = x + 1
  elseif classic(LY, 3) < 128 and classic(LX, 3) < 128 then 'down/left
    y = y + 1 : x = x - 1
  elseif classic(LY, 3) < 128 and classic(LX, 3) > 128 then 'down/right
    y = y + 1 : x = x + 1
  elseif classic(LY, 3) > 128 then 'up
    y = y - 1
  elseif classic(LY, 3) < 128 then 'down
    y = y + 1
  elseif classic(LX, 3) < 128 then 'left
    x = x - 1
  elseif classic(LX, 3) > 128 then 'right
    x = x + 1
  endif

  'RY/RX Right joystick
  if classic(RY, 3) > 128 and classic(RX, 3) < 128 then 'up/left
    y = y - 1 : x = x - 1
  elseif classic(RY, 3) > 128 and classic(RX, 3) > 128 then 'up/right
    y = y - 1 : x = x + 1
  elseif classic(RY, 3) < 128 and classic(RX, 3) < 128 then 'down/left
    y = y + 1 : x = x - 1
  elseif classic(RY, 3) < 128 and classic(RX, 3) > 128 then 'down/right
    y = y + 1 : x = x + 1
  elseif classic(RY, 3) > 128 then 'up
    y = y - 1
  elseif classic(RY, 3) < 128 then 'down
    y = y + 1
  elseif classic(RX, 3) < 128 then 'left
    x = x - 1
  elseif classic(RX, 3) > 128 then 'right
    x = x + 1
  endif

  buttons = classic(B, 3)

  'buttonup/buttondown/buttonleft/buttonright cursor
  if (buttons and buttonup and buttonleft) then 'up/left
    y = y - 1 : x = x - 1
  elseif (buttons and buttonup and buttonright) then 'up/right
    y = y - 1 : x = x + 1
  elseif (buttons and buttondown and buttonleft) then 'down/left
    y = y + 1 : x = x - 1
  elseif (buttons and buttondown and buttonright) then 'down/right
    y = y + 1 : x = x + 1
  elseif (buttons and buttonup) then 'up
    y = y - 1
  elseif (buttons and buttondown) then 'down
    y = y + 1
  elseif (buttons and buttonleft) then 'left
    x = x - 1
  elseif (buttons and buttonright) then 'right
    x = x + 1
  endif

  'x/b/y/a buttons  x,b,y,a = up,down,left,right
  if (buttons and buttonx and buttony) then 'up/left
    y = y - 1 : x = x - 1
  elseif (buttons and buttonx and buttona) then 'up/right
    y = y - 1 : x = x + 1
  elseif (buttons and buttonb and buttony) then 'down/left
    y = y + 1 : x = x - 1
  elseif (buttons and buttonb and buttona) then 'down/right
    y = y + 1 : x = x + 1
  elseif (buttons and buttonx) then 'up
    y = y - 1
  elseif (buttons and buttonb) then 'down
    y = y + 1
  elseif (buttons and buttony) then 'left
    x = x - 1
  elseif (buttons and buttona) then 'right
    x = x + 1
  endif

  'L/R/ZL/ZR shooting buttons  l,r,zl,zr = up,down,left,right
  if (buttons and buttonl and buttonzl) then 'up/left
    y = y - 1 : x = x - 1
  elseif (buttons and buttonl and buttonzr) then 'up/right
    y = y - 1 : x = x + 1
  elseif (buttons and buttonr and buttonzl) then 'down/left
    y = y + 1 : x = x - 1
  elseif (buttons and buttonr and buttonzr) then 'down/right
    y = y + 1 : x = x + 1
  elseif (buttons and buttonl) then 'up
    y = y - 1
  elseif (buttons and buttonr) then 'down
    y = y + 1
  elseif (buttons and buttonzl) then 'left
    x = x - 1
  elseif (buttons and buttonzr) then 'right
    x = x + 1
  endif

  'start/home/select/ZR  start/home/select/ZR = up,down,left,right
  if (buttons and buttonstart and buttonselect) then 'up/left
    y = y - 1 : x = x - 1
  elseif (buttons and buttonstart and buttonzr) then 'up/right
    y = y - 1 : x = x + 1
  elseif (buttons and buttonhome and buttonselect) then 'down/left
    y = y + 1 : x = x - 1
  elseif (buttons and buttonhome and buttonzr) then 'down/right
    y = y + 1 : x = x + 1
  elseif (buttons and buttonstart) then 'up
    y = y - 1
  elseif (buttons and buttonhome) then 'down
    y = y + 1
  elseif (buttons and buttonselect) then 'left
    x = x - 1
  elseif (buttons and buttonzr) then 'right
    x = x + 1
  endif
  
  if x < 0 then x = 0
  if x > 799 - w then x = 799 - w
  if y < 0 then y = 0
  if y > 600 - h then y = 600 - h
  
  box x, y, w, h, t, rgb(yellow)

  'cls : e$ = ""
  'c$ = "Left Js  X axis / Y axis = " + str$(classic(LX, 3)) + " / " + str$(classic(LY, 3))
  'text 8, 12, c$, "LT"
  'c$ = "Right Js X axis / Y axis = " + str$(classic(RX, 3)) + " / " + str$(classic(RY, 3))
  'text 8, 24, c$, "LT"
  'c$ = "Left Button X axis / Y axis = " + str$(classic(L, 3)) + " / " + str$(classic(R, 3))
  'text 8, 36, c$, "LT"
  'buttons = classic(B, 3)

  'if (buttons and buttonr) then e$ = e$ + "R "
  'if (buttons and buttonstart) then e$ = e$ + "Start "
  'if (buttons and buttonhome) then e$ = e$ + "Home "
  'if (buttons and buttonselect) then e$ = e$ + "Select "
  'if (buttons and buttonl) then e$ = e$ + "L "
  'if (buttons and buttondown) then e$ = e$ + "Down "
  'if (buttons and buttonright) then e$ = e$ + "Right "
  'if (buttons and buttonup) then e$ = e$ + "Up "
  'if (buttons and buttonleft) then e$ = e$ + "Left "
  'if (buttons and buttonzr) then e$ = e$ + "ZR "
  'if (buttons and buttonx) then e$ = e$ + "X"
  'if (buttons and buttona) then e$ = e$ + "A"
  'if (buttons and buttony) then e$ = e$ + "Y"
  'if (buttons and buttonb) then e$ = e$ + "B"
  'if (buttons and buttonzl) then e$ = e$ + "ZL"    

  'text 8, 48, e$ : pause 50

  loop
wii classic close 3











