
'2D Maze with monsters
#include "colors.inc"
option base 0
dim integer width, height, done, i, drawn_maze, seed, sx, sy, d, f
dim integer x, y, xt, yt, score, maxscore, num
dim integer px, py, oldpx, oldpy
dim integer mx(3), my(3), oldmx(3), oldmy(3), dir
dim string ch$ length 1 'Compass Heading
dim string mh$(3) length 1 'Monster Headings
dim string m$(497, 249) length 1
dim string draw$ = "Y" length 1, method$(3)
dim string wc$ length 1 = chr$(219) 'Wall character
cls : mode 1, 16 : color Indigo
? "Controls are the four cursor keys"
pause 4200 : cls
width = 101 : height = 49 '101x51, width and height must be odd for the new algorithm

10 seed = int(rnd * 1234567890)
11 dim mg(width, height) 
12 for y = 1 to height  
13 for x = 1 to width   
14 mg(x, y) = 0 : next   
15 mg(1, y) = 2 : mg(width, y) = 2 
16 next
17 for x = 1 to width  
18 mg(x, 1) = 2 : mg(x, height) = 2
19 next : mg(3, 3) = 1  
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
33 if mg(x + 1, y) + mg(x + 2, y) goto 31  
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
px = 1 : py = 1 : oldpx = x : oldpy = y
mx(1) = width - 4 : my(1) = height - 4
mx(2) = width - 4 : my(2) = 1
mx(3) = 1 : my(3) = height - 4 
for i = 1 to 3
  oldmx(i) = mx(i) : oldmy(i) = my(i) : mh$(i) = "N" : method$(i) = "R"
next i
score = 0 : maxscore = 0
drawn_maze = 0 : m$(1, 1) = "x"
m$(width - 4, height - 4) = "M" 
m$(width - 4, 1) = "M"
m$(1, height - 4) = "M"

'fill maze empty squares with dots
for yt = 0 to height - 3
  for xt = 0 to width - 3
    if m$(xt, yt) <> wc$ and m$(xt, yt) <> "x" and m$(xt, yt) <> "M" and m$(xt, yt) <> "d" then
      m$(xt, yt) = "." 
      maxscore = maxscore + 1
    endif
  next xt
next yt

draw_2d_maze()

do
  if (mx(1) = px and my(1) = py) or (mx(2) = px and my(2) = py) or (mx(3) = px and my(3) = py) then
    cls : print "Game over.  A monster caught you." : pause 5000 : end
  endif
  if keydown(1) = 128 then 'player cursor Up
    p_up()    
  elseif keydown(1) = 129 then 'player cursor Down 
    p_down()
  elseif keydown(1) = 130 then 'player cursor Left 
    p_left()    
  elseif keydown(1) = 131 then 'player cursor right
    p_right()         
  endif
  for i = 1 to 3
    m_move(i)
  next i
loop

sub m_move(num)
  if int(rnd * 1000) < 55 then 'Most of the time the monster is NOT moving
    if int(rnd * 999) < 8 then 'Switch monster movement method once in a while
      if method$(num) = "R" then
        method$(num) = "L"
      else 
        method$(num) = "R"
      endif
    endif
    if m$(mx(num), my(num) - 1) = wc$ then
      dirn = 0
    else 
      dirn = 1
    endif
    if m$(mx(num), my(num) + 1) = wc$ then 
      dirs = 0
    else
      dirs = 1
    endif
    if m$(mx(num) - 1, my(num)) = wc$ then
      dirw = 0
    else
      dirw = 1
    endif
    if m$(mx(num) + 1, my(num)) = wc$ then
      dire = 0
    else
      dire = 1
    endif
    if method$(num) = "R" then
      select case mh$(num)
        case "N"
          if dire = 1 then 
            dir = 4 'east    
          elseif dirn = 1 then
            dir = 1 'north
          elseif dirw = 1 then
            dir = 3 'west
          else
            dir = 2 'south
          endif
        case "S"
          if dirw = 1 then      
            dir = 3 'west
          elseif dirs = 1 then
            dir = 2 'south
          elseif dire = 1 then
            dir = 4 'east
          else
            dir = 1 'north
          endif
        case "W"
          if dirn = 1 then
            dir = 1 'north
          elseif dirw = 1 then
            dir = 3 'west
          elseif dirs = 1 then
            dir = 2 'south
          else
            dir = 4 'east
          endif
        case "E"
          if dirs = 1 then
            dir = 2 'south
          elseif dire = 1 then
            dir = 4 'east
          elseif dirn = 1 then
            dir = 1 'north
          else
            dir = 3 'west
          endif
      end select
    else 'method$(num) = "L"
      select case mh$(num)
        case "N"
          if dirw = 1 then 
            dir = 3 'west    
          elseif dirn = 1 then
            dir = 1 'north
          elseif dire = 1 then
            dir = 4 'east
          else
            dir = 2 'south
          endif
        case "S"
          if dire = 1 then      
            dir = 4 'east
          elseif dirs = 1 then
            dir = 2 'south
          elseif dirw = 1 then
            dir = 3 'west
          else
            dir = 1 'north
          endif
        case "W"
          if dirs = 1 then
            dir = 2 'south
          elseif dirw = 1 then
            dir = 3 'west
          elseif dirn = 1 then
            dir = 1 'north
          else
            dir = 4 'east
          endif
        case "E"
          if dirn = 1 then
            dir = 1 'north
          elseif dire = 1 then
            dir = 4 'east
          elseif dirs = 1 then
            dir = 2 'south
          else
            dir = 3 'west
          endif
      end select
    endif 
    select case dir
      case 1
        mh$(num) = "N" : m_up(num)
      case 2
        mh$(num) = "S" : m_down(num)
      case 3
        mh$(num) = "W" : m_left(num)
      case 4
        mh$(num) = "E" : m_right(num)
    end select
  endif
end sub

sub p_left
  if m$(px - 1, py) <> wc$ then
    if m$(px - 1, py) = "." then
      score = score + 1
    endif
    oldpx = px : oldpy = py : m$(px - 1, py) = "x"
    m$(px, py) = " " : px = px - 1 : draw_2d_maze()
  endif
end sub

sub p_right
  if m$(px + 1, py) <> wc$ then
    if m$(px + 1, py) = "." then
      score = score + 1
    endif
    oldpx = px : oldpy = py : m$(px + 1, py) = "x"
    m$(px, py) = " " : px = px + 1 : draw_2d_maze()
  endif
end sub

sub p_up
  if m$(px, py - 1 ) <> wc$ then
    if m$(px, py - 1) = "." then
      score = score + 1
    endif
    oldpx = px : oldpy = py : m$(px, py - 1) = "x"
    m$(px, py) = " " : py = py - 1 : draw_2d_maze()
  endif
end sub

sub p_down
  if m$(px, py + 1) <> wc$ then
    if m$(px, py + 1) = "." then
      score = score + 1
    endif
    oldpx = px : oldpy = py : m$(px, py + 1) = "x"
    m$(px, py) = " " : py = py + 1 : draw_2d_maze()
  endif
end sub

sub m_left(num)
  if m$(mx(num) - 1, my(num)) <> wc$ then
    oldmx(num) = mx(num)
    oldmy(num) = my(num)
    m$(mx(num) - 1, my(num)) = "M"
    mh$(num) = "W"
    m$(mx(num), my(num)) = " "
    mx(num) = mx(num) - 1
    draw_2d_maze()   
  endif
end sub

sub m_right(num)
  if m$(mx(num) + 1, my(num)) <> wc$ then
    oldmx(num) = mx(num)
    oldmy(num) = my(num)
    m$(mx(num) + 1, my(num)) = "M"
    mh$(num) = "E"
    m$(mx(num), my(num)) = " "
    mx(num) = mx(num) + 1
    draw_2d_maze()
  endif
end sub

sub m_up(num)
  if m$(mx(num), my(num) - 1 ) <> wc$ then
    oldmx(num) = mx(num)
    oldmy(num) = my(num)
    m$(mx(num), my(num) - 1) = "M"
    mh$(num) = "N"
    m$(mx(num), my(num)) = " "
    my(num) = my(num) - 1
    draw_2d_maze()
  endif
end sub

sub m_down(num)
  if m$(mx(num), my(num) + 1) <> wc$ then
    oldmx(num) = mx(num)
    oldmy(num) = my(num)
    m$(mx(num), my(num) + 1) = "M"
    mh$(num) = "S"
    m$(mx(num), my(num)) = " "
    my(num) = my(num) + 1
    draw_2d_maze()
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
    print space$(9);"Score =";score;
    color Indigo
    drawn_maze = 1
    pause 55
  else 'maze has already been drawn
    color Yellow
    print @(px * 8, py * 12)"x" 'draw current location of player
    print @(oldpx * 8, oldpy * 12)" "
    for i = 1 to 3
      print @(mx(i) * 8, my(i) * 12)"M" 
      print @(oldmx(i) * 8, oldmy(i) * 12)" "
    next i
    print @(8, 12)"u" 'the up ladder
    print @((width - 4) * 8, (height - 4) * 12)"d" 'the down ladder
    print @(16 * 8, (height - 2) * 12) score
    color Indigo
    pause 55
  endif
end sub
















































