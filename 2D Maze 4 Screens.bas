'2D Maze 4 Screens
#include "colors.inc"
option base 0
dim integer width, height, done, i, x, y, xt, yt, screen_drawn
dim integer xa, ya, xs, ys 'x and y locations in the array and on the screen
dim integer oldxa, oldya, oldxs, oldys
dim integer score, maxscore, d, f, seed, sx, sy
dim string ch$ length 1 'Compass Heading
dim string m$(497, 249) length 1 'Maze array
dim string draw$ = "Y" length 1
dim string wc$ length 1 = chr$(219) 'Wall character
cls : mode 1, 16 : color Indigo
wii nunchuk open 3
? "Controls are the four cursor keys"
pause 1500 : cls
width = 201 : height = 99 '101x51, width and height must be ODD 

seed = int(rnd * 1234567890)
dim mg(width, height) 'would take this out
for y = 1 to height  
  for x = 1 to width   
    mg(x, y) = 0 
  next x  'could be m$(x, y) = "0"
    mg(1, y) = 2 : mg(width, y) = 2  'could be = "2"
next y
for x = 1 to width  
  mg(x, 1) = 2 : mg(x, height) = 2
next x
mg(3, 3) = 1  'could be = "1"
f = ((width - 3) / 2) * ((height - 3) / 2) - 1

TwentyOne:
for sy = 3 to height - 2 step 2
  for sx = 3 to width - 2 step 2
    gosub TwentySeven
  next sx
next sy
if f > 0 goto TwentyOne
mg(2, 3) = 1 : mg(width - 1, height - 2) = 1 : goto main

TwentySeven:
x = sx : y = sy
if mg(x, y) <> 1 then return
goto FourtyOne

Thirty:
on d goto ThirtyThree, ThirtyFive, ThirtySeven, ThirtyNine

ThirtyOne:
if i = 4 then return
d = ((d + 1) and 3) + 1 : i = i + 1 : goto Thirty

ThirtyThree:
if mg(x + 1, y) + mg(x + 2, y) goto ThirtyOne  'could convert the strings to integers so can add
mg(x + 1, y) = 1 : x = x + 2 : goto FourtyOne

ThirtyFive:
if mg(x - 1, y) + mg(x - 2, y) goto ThirtyOne
mg(x - 1, y) = 1 : x = x - 2 : goto FourtyOne

ThirtySeven:
if mg(x, y + 1) + mg(x, y + 2) goto ThirtyOne
mg(x, y + 1) = 1 : y = y + 2 : goto FourtyOne

ThirtyNine:
if mg(x, y - 1) + mg(x, y - 2) goto ThirtyOne
mg(x, y - 1) = 1 : y = y - 2

FourtyOne:
i = 0 : d = int(rnd(seed) * 4) + 1
if mg(x, y) = 0 then f = f - 1
mg(x, y) = 1 : goto Thirty

'At this point we could change the "0"s and "2"s to wc$ and the "1"s to " "
'With this change, we would only be allocating memory for ONE array instead of TWO 
'and we would NOT need the nested loops below.

main:
'For now convert the generated array into the other array 
for y = 0 to height - 3  
  for x = 0 to width - 3 
    if mg(x + 2, y + 2) = 0 then 
      m$(x, y) = wc$
    else
      if (x = 0 and y = 1) or (x = width - 3 and y = height - 4) then
        m$(x, y) = wc$ 'plug up the generator's entrance and exit
      else
        m$(x, y) = " " 
      endif
    endif
  next x
next y
cls

'-----------------------------------------------------------------------------------------
xa = 1 : ya = 1 : xs = 1 : ys = 1 
oldxa = xa : oldya = ya : oldxs = xs : oldys = ys 
score = 0 : maxscore = 0 
screen_drawn = 0 : m$(1, 1) = "x"
m$(width - 4, height - 4) = "d"

'fill maze empty squares with dots
for yt = 0 to height - 3
  for xt = 0 to width - 3
    if m$(xt, yt) <> wc$ and m$(xt, yt) <> "x" then
      m$(xt, yt) = "." 
      maxscore = maxscore + 1
    endif
  next xt
next yt

draw_2d_maze()

do
  if keydown(1) = 130 then 'Player presses cursor left key
    if m$(xa - 1, ya) <> wc$ then
      if m$(xa - 1, ya) = "." then
        score = score + 1
      endif
      oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
      m$(xa - 1, ya) = "x" : m$(xa, ya) = " "
      xs = xs - 1 : xa = xa - 1 
      if xs < 0 then
        xs = 99 'update xs
        screen_drawn = 0 'clear the old screen and print the new screen
      endif
    endif
  elseif keydown(1) = 131 then 'Player presses cursor right key
    if m$(xa + 1, ya) <> wc$ then
      if m$(xa + 1, ya) = "." then
        score = score + 1
      endif
      oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
      m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
      xs = xs + 1 : xa = xa + 1
      if xs > 99 then
        xs = 0
        screen_drawn = 0
      endif
    endif
  elseif keydown(1) = 128 then 'Player presses the cursor up key
    if m$(xa, ya - 1 ) <> wc$ then
      if m$(xa, ya - 1) = "." then
        score = score + 1
      endif
      oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
      m$(xa, ya - 1) = "x" : m$(xa, ya) = " "
      ys = ys - 1 : ya = ya - 1
      if ys < 0 then
        ys = 48
        screen_drawn = 0
      endif
    endif
  elseif keydown(1) = 129 then 'Player presses the cursor down key
    if m$(xa, ya + 1) <> wc$ then
      if m$(xa, ya + 1) = "." then
        score = score + 1
      endif
      oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
      m$(xa, ya + 1) = "x" : m$(xa, ya) = " "
      ys = ys + 1 : ya = ya + 1
      if ys > 48 then
        ys = 0
        screen_drawn = 0
      endif
    endif
  endif
  draw_2d_maze()
loop

sub draw_2d_maze
  if screen_drawn = 0 then 
    cls
    if xa < 100 and ya < 49 then 'NW screen 
      for yt = 0 to 48
        for xt = 0 to 99  
          if m$(xt, yt) <> "x" and m$(xt, yt) <> "u" and m$(xt, yt) <> "d" then
             print m$(xt, yt);
          else
             color Yellow : print m$(xt, yt); : color Indigo
          endif
        next xt
        if yt <> 48 then
          print
        endif
      next yt
      m$(1, 1) = "u"
    elseif xa > 99 and ya < 49 then 'NE screen
      for yt = 0 to 48
        for xt = 100 to width - 3 
          if m$(xt, yt) <> "x" and m$(xt, yt) <> "u" and m$(xt, yt) <> "d" then
            print m$(xt, yt);
          else
            color Yellow : print m$(xt, yt); : color Indigo
          endif
        next xt
        if yt <> 48 then
          print
        endif
      next yt 
    elseif xa < 100 and ya > 48 then 'SW screen
      for yt = 49 to height - 3
        for xt = 0 to 99
          if m$(xt, yt) <> "x" and m$(xt, yt) <> "u" and m$(xt, yt) <> "d" then
            print m$(xt, yt);
          else
            color Yellow : print m$(xt, yt); : color Indigo
          endif
        next xt
        if yt <> 97 then
          print
        endif
      next yt
    else 'if xa > 99 and ya > 48 then 'SE screen
      for yt = 49 to height - 3 
        for xt = 100 to width - 3 
          if m$(xt, yt) <> "x" and m$(xt, yt) <> "u" and m$(xt, yt) <> "d" then
            print m$(xt, yt);
          else
            color Yellow : print m$(xt, yt); : color Indigo
          endif
        next xt
        if yt <> 97 then
          print
        endif
      next yt
    endif
    color Yellow
    print @(9 * 8, 49 * 12) "Score =";score;
    color Indigo
    screen_drawn = 1
    pause 90
  else 'maze has already been drawn
    color Yellow
    print @(xs * 8, ys * 12)"x"; 'draw current location of player
    if abs(xs - oldxs) < 2 and abs(ys - oldys) < 2 then 'recently added to fix bug
      print @(oldxs * 8, oldys * 12)" ";  
    endif
    if xa < 100 and ya < 49 then
      print @(8, 12)"u"; 'the up ladder
    endif
    print @(16 * 8, 49 * 12) score;
    color Indigo
    pause 90
  endif
end sub

















































