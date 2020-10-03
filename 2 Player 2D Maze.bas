
'2 Player 2D Maze
#include "colors.inc"
option base 0
dim integer width, height, done, i, drawn_maze, seed, sx, sy, d, f
dim integer x, y, xt, yt, scorep1, scorep2, maxscore
dim integer x1, y1, x2, y2, oldx1, oldy1, oldx2, oldy2
dim string ch$ length 1 'Compass Heading
dim string m$(497, 249) length 1
dim string draw$ = "Y" length 1
dim string wc$ length 1 = chr$(219) 'Wall character
cls : mode 1, 16 : color Indigo
wii nunchuk open 3
? "Controls are the four cursor keys and the Nunchuk controller"
pause 5500 : cls
width = 101 : height = 49 '101x51, width and height must be odd for the new algorithm

10 seed = int(rnd * 1234567890)
11 dim mg(width, height) 'would take this out
12 for y = 1 to height  
13 for x = 1 to width   
14 mg(x, y) = 0 : next   'could be m$(x, y) = "0"
15 mg(1, y) = 2 : mg(width, y) = 2  'could be = "2"
16 next
17 for x = 1 to width  
18 mg(x, 1) = 2 : mg(x, height) = 2
19 next : mg(3, 3) = 1  'could be = "1"
20 f = ((width - 3) / 2) * ((height - 3) / 2) - 1
21 for sy = 3 to height - 2 step 2
22 for sx = 3 to width - 2 step 2
23 gosub 27 : next : next
24 if f > 0 goto 21
25 mg(2, 3) = 1 : mg(width - 1, height - 2) = 1
26 goto main:
27 x = sx : y = sy
28 if mg(x, y) <> 1 then return
29 goto 41
30 on d goto 33, 35, 37, 39
31 if i = 4 then return
32 d = ((d + 1) and 3) + 1 : i = i + 1 : goto 30
33 if mg(x + 1, y) + mg(x + 2, y) goto 31  'could convert the strings to integers so can add
34 mg(x + 1, y) = 1 : x = x + 2 : goto 41
35 if mg(x - 1, y) + mg(x - 2, y) goto 31
36 mg(x - 1, y) = 1 : x = x - 2 : goto 41
37 if mg(x, y + 1) + mg(x, y + 2) goto 31
38 mg(x, y + 1) = 1 : y = y + 2 : goto 41
39 if mg(x, y - 1) + mg(x, y - 2) goto 31
40 mg(x, y - 1) = 1 : y = y - 2
41 i = 0 : d = int(rnd(seed) * 4) + 1
42 if mg(x, y) = 0 then f = f - 1
43 mg(x, y) = 1: goto 30
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
'Draw the view starting looking South from the first available empty square at the
'Northwestern most edge of the maze.  The exit will be the Southeastern most empty square.
x1 = 1 : y1 = 1 : oldx1 = x1 : oldy1 = y1
x2 = width - 4 : y2 = height - 4 
oldx2 = x2 : oldy2 = y2
scorep1 = 0 : scorep2 = 0 : maxscore = 0
drawn_maze = 0 : m$(1, 1) = "1"
m$(width - 4, height - 4) = "2" 'd

'fill maze empty squares with dots
for yt = 0 to height - 3
  for xt = 0 to width - 3
    if m$(xt, yt) <> wc$ and m$(xt, yt) <> "1" and m$(xt, yt) <> "2" and m$(xt, yt) <> "d" then
      m$(xt, yt) = "." 
      maxscore = maxscore + 1
    endif
  next xt
next yt

draw_2d_maze()

do
  if keydown(1) = 130 and nunchuk(JX, 3) < 128 then 
    k_left() : n_left()
  elseif keydown(1) = 130 and nunchuk(JX, 3) > 128 then
    k_left() : n_right()
  elseif keydown(1) = 130 and nunchuk(JY, 3) > 128 then
    k_left() : n_up()
  elseif keydown(1) = 130 and nunchuk(JY, 3) < 128 then
    k_left() : n_down()
  elseif keydown(1) = 131 and nunchuk(JX, 3) < 128 then
    k_right() : n_left()
  elseif keydown(1) = 131 and nunchuk(JX, 3) > 128 then
    k_right() : n_right()
  elseif keydown(1) = 131 and nunchuk(JY, 3) > 128 then
    k_right() : n_up()
  elseif keydown(1) = 131 and nunchuk(JY, 3) < 128 then
    k_right() : n_down()
  elseif keydown(1) = 128 and nunchuk(JX, 3) < 128 then
    k_up() : n_left()
  elseif keydown(1) = 128 and nunchuk(JX, 3) > 128 then
    k_up() : n_right()
  elseif keydown(1) = 128 and nunchuk(JY, 3) > 128 then
    k_up() : n_up()
  elseif keydown(1) = 128 and nunchuk(JY, 3) < 128 then
    k_up() : n_down()
  elseif keydown(1) = 129 and nunchuk(JX, 3) < 128 then
    k_down() : n_left()
  elseif keydown(1) = 129 and nunchuk(JX, 3) > 128 then
    k_down() : n_right()
  elseif keydown(1) = 129 and nunchuk(JY, 3) > 128 then
    k_down() : n_up()
  elseif keydown(1) = 129 and nunchuk(JY, 3) < 128 then
    k_down() : n_down()
  elseif keydown(1) = 130 then 
    k_left()    
  elseif nunchuk(JX, 3) < 128 then
    n_left() 
  elseif keydown(1) = 131 then
    k_right()    
  elseif nunchuk(JX, 3) > 128 then
    n_right() 
  elseif keydown(1) = 128 then
    k_up()    
  elseif nunchuk(JY, 3) > 128 then
    n_up()
  elseif keydown(1) = 129 then 
    k_down()
  elseif nunchuk(JY, 3) < 128 then 
    n_down()    
  endif
loop

sub k_left
  if m$(x1 - 1, y1) <> wc$ then
    if m$(x1 - 1, y1) = "." then
      scorep1 = scorep1 + 1
    endif
    oldx1 = x1 : oldy1 = y1 : m$(x1 - 1, y1) = "1" : m$(x1, y1) = " "
    x1 = x1 - 1 : draw_2d_maze()
  endif
end sub

sub k_right
  if m$(x1 + 1, y1) <> wc$ then
    if m$(x1 + 1, y1) = "." then
      scorep1 = scorep1 + 1
    endif
    oldx1 = x1 : oldy1 = y1 : m$(x1 + 1, y1) = "1" : m$(x1, y1) = " "
    x1 = x1 + 1 : draw_2d_maze()
  endif
end sub

sub k_up
  if m$(x1, y1 - 1 ) <> wc$ then
    if m$(x1, y1 - 1) = "." then
      scorep1 = scorep1 + 1
    endif
    oldx1 = x1 : oldy1 = y1 : m$(x1, y1 - 1) = "1" : m$(x1, y1) = " "
    y1 = y1 - 1 : draw_2d_maze()
  endif
end sub

sub k_down
  if m$(x1, y1 + 1) <> wc$ then
    if m$(x1, y1 + 1) = "." then
      scorep1 = scorep1 + 1
    endif
    oldx1 = x1 : oldy1 = y1 : m$(x1, y1 + 1) = "1" : m$(x1, y1) = " "
    y1 = y1 + 1 : draw_2d_maze()
  endif
end sub

sub n_left
  if m$(x2 - 1, y2) <> wc$ then
    if m$(x2 - 1, y2) = "." then
      scorep2 = scorep2 + 1
    endif
    oldx2 = x2 : oldy2 = y2 : m$(x2 - 1, y2) = "2" : m$(x2, y2) = " "
    x2 = x2 - 1 : draw_2d_maze()   
  endif
end sub

sub n_right
  if m$(x2 + 1, y2) <> wc$ then
    if m$(x2 + 1, y2) = "." then
      scorep2 = scorep2 + 1
    endif
    oldx2 = x2 : oldy2 = y2 : m$(x2 + 1, y2) = "2" : m$(x2, y2) = " "
    x2 = x2 + 1 : draw_2d_maze()
  endif
end sub

sub n_up
  if m$(x2, y2 - 1 ) <> wc$ then
    if m$(x2, y2 - 1) = "." then
      scorep2 = scorep2 + 1
    endif
    oldx2 = x2 : oldy2 = y2 : m$(x2, y2 - 1) = "2" : m$(x2, y2) = " "
    y2 = y2 - 1 : draw_2d_maze()
  endif
end sub

sub n_down
  if m$(x2, y2 + 1) <> wc$ then
    if m$(x2, y2 + 1) = "." then
      scorep2 = scorep2 + 1
    endif
    oldx2 = x2 : oldy2 = y2 : m$(x2, y2 + 1) = "2" : m$(x2, y2) = " "
    y2 = y2 + 1 : draw_2d_maze()
  endif
end sub

sub draw_2d_maze
  if drawn_maze = 0 then
    for yt = 0 to height - 3
      for xt = 0 to width - 3
        print m$(xt, yt);
      next xt
      print
    next yt
    color Yellow
    print space$(9);"Score P1 =";scorep1;space$(56);"Score P2 =";scorep2
    color Indigo
    drawn_maze = 1
    pause 90
  else 'maze has already been drawn
    color Yellow
    print @(x1 * 8, y1 * 12)"1" 'draw current location of player 1
    print @(oldx1 * 8, oldy1 * 12)" "
    print @(x2 * 8, y2 * 12)"2" 'draw current location of player 2
    print @(oldx2 * 8, oldy2 * 12)" "
    print @(8, 12)"u" 'the up ladder
    print @((width - 4) * 8, (height - 4) * 12)"d" 'the down ladder
    print @(19 * 8, (height - 2) * 12) scorep1
    print @(87 * 8, (height - 2) * 12) scorep2
    color Indigo
    pause 90
  endif
end sub

wii nunchuk close 3















































