
'3D Maze v3 with updated map view
#include "colors.inc"
option base 0
dim integer width, height, done, i, x, y, xt, yt, screen_drawn, drawn_maze, view
dim integer xa, ya, xs, ys 'x and y locations in the array and on the screen
dim integer oldxa, oldya, oldxs, oldys
dim integer score, maxscore, d, f, seed, sx, sy
dim integer xtlow, xthigh, ytlow, ythigh
dim integer ybottom, screen, screenx, screeny, maxscreenx, maxscreeny
dim string ch$ length 1 'Compass Heading
dim string m$(497, 249) length 1 'Maze array
dim string draw$ = "Y" length 1
dim string wc$ length 1 = chr$(219) 'Wall character
cls : mode 1, 16 : color Indigo
? "Controls are Space Bar, M, and the four cursor keys."
pause 3000 : cls

'***************************
width = 201 : height = 99   '101x51, 201x99, 301x149, width and height must be ODD
'***************************

seed = int(rnd * 1234567890)
dim mg(width, height) 
for y = 1 to height  
  for x = 1 to width   
    mg(x, y) = 0
  next x   
  mg(1, y) = 2 : mg(width, y) = 2  
next y
for x = 1 to width  
  mg(x, 1) = 2 : mg(x, height) = 2
next x
mg(3, 3) = 1  
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
if mg(x + 1, y) + mg(x + 2, y) goto ThirtyOne
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
mg(x, y) = 1: goto Thirty

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
xa = 1 : ya = 1 : xs = 1 : ys = 1 : view = 2 '2 for 2D 
oldxa = xa : oldya = ya : oldxs = xs : oldys = ys
score = 0 : maxscore = 0
screen_drawn = 0 : m$(1, 1) = "x" : ch$ = "S"
drawn_maze = 0 : m$(width - 4, height - 4) = "d"

'fill maze empty squares with dots
for yt = 0 to height - 3
  for xt = 0 to width - 3
    if m$(xt, yt) <> wc$ and m$(xt, yt) <> "x" and m$(xt, yt) <> "d" then
      m$(xt, yt) = "." 
      maxscore = maxscore + 1
    endif
  next xt
next yt

calculate()
draw_2d_maze()

do
  if keydown(1) = 32 then ' User presses space bar
    view = 3
    m$(1, 1) = "u"  
    m$(width - 4, height - 4) = "d"
    draw_3d_maze() 
  elseif keydown(1) = 130 then 'User presses cursor left key
    if view = 3 then
      select case ch$
        case "N"
          ch$ = "W" 
        case "W"
          ch$ = "S" 
        case "S"
          ch$ = "E" 
        case "E"
          ch$ = "N" 
      end select
      draw_3d_maze()
    else 'view = 2
      if m$(xa - 1, ya) <> wc$ then
        if m$(xa - 1, ya) = "." then
          score = score + 1
        endif
        oldxs = xs : oldys = ys : oldxa = xa : oldya = ya 
        m$(xa - 1, ya) = "x" : m$(xa, ya) = " "
        xs = xs - 1 : xa = xa - 1
        if xs < 0 then
          xs = 99 : screen_drawn = 0 : drawn_maze = 0
        endif
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 131 then 'User presses cursor right key
    if view = 3 then
      select case ch$
        case "N"
          ch$ = "E" 
        case "E"
          ch$ = "S" 
        case "S"
          ch$ = "W" 
        case "W"
          ch$ = "N" 
      end select
      draw_3d_maze()
    else 'view = 2
      if m$(xa + 1, ya) <> wc$ then
        if m$(xa + 1, ya) = "." then
          score = score + 1
        endif
        oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
        m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
        xs = xs + 1 : xa = xa + 1 
        if xs = 100 then 'was 99
          xs = 0 : screen_drawn = 0 : drawn_maze = 0
        endif
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 128 then 'User presses the cursor forward key
    if view = 3 then
      select case ch$
        case "W"
          if m$(xa - 1, ya) <> wc$ then 'There is NO wall blocking the path
          if m$(xa - 1, ya) = "." then score = score + 1
            m$(xa - 1, ya) = "x" 'Update the location of the user
            m$(xa, ya) = " " 'Reset the former loccation of the user to empty cell 'deal with ladder
            xs = xs - 1 : xa = xa - 1 
          endif
        case "E"
          if m$(xa + 1, ya) <> wc$ then 
            if m$(xa + 1, ya) = "." then score = score + 1
            m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
            xs = xs + 1 : xa = xa + 1
          endif
        case "N"
          if m$(xa, ya - 1) <> wc$ then 
            if m$(xa, ya - 1) = "." then score = score + 1
            m$(xa, ya - 1) = "x" : m$(xa, ya) = " " 
            ys = ys - 1 : ya = ya - 1
          endif
        case "S"
          if m$(xa, ya + 1) <> wc$ then
            if m$(xa, ya + 1) = "." then score = score + 1
            m$(xa, ya + 1) = "x" : m$(xa, ya) = " "
            ys = ys + 1 : ya = ya + 1
          endif
      end select
      if m$(1, 1) = " " then m$(1, 1) = "u"
      if m$(width - 4, height - 4) = " " then m$(width - 4, height - 4) = "d"
      draw_3d_maze() 
    else 'view = 2
      if m$(xa, ya - 1 ) <> wc$ then
        if m$(xa, ya - 1) = "." then
          score = score + 1
        endif
        oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
        m$(xa, ya - 1) = "x" : m$(xa, ya) = " "
        ys = ys - 1 : ya = ya - 1
        if ys < 0 then
          ys = 48 : screen_drawn = 0 : drawn_maze = 0
        endif
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 129 then 'User presses the cursor backward key
    if view = 3 then
      select case ch$
        case "W"
          if m$(xa + 1, ya) <> wc$ then
            if m$(xa + 1, ya) = "." then score = score + 1
            m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
            xs = xs + 1 : xa = xa + 1
          endif
        case "E"
          if m$(xa - 1, ya) <> wc$ then 
            if m$(xa + 1, ya) = "." then score = score + 1
            m$(xa - 1, ya) = "x" : m$(xa, ya) = " "
            xs = xs - 1 : xa = xa - 1
          endif
        case "N"
          if m$(xa, ya + 1) <> wc$ then 
            if m$(xa + 1, ya) = "." then score = score + 1
            m$(xa, ya + 1) = "x" : m$(xa, ya) = " "
            ys = ys + 1 : ya = ya + 1
          endif
        case "S"
          if m$(xa, ya - 1) <> wc$ then  
            if m$(xa + 1, ya) = "." then score = score + 1
            m$(xa, ya - 1) = "x" : m$(xa, ya) = " "
            ys = ys - 1 : ya = ya - 1
          endif
      end select 
      if m$(1, 1) = " " then m$(1, 1) = "u"
      if m$(width - 4, height - 4) = " " then m$(width - 4, height - 4) = "d"
      draw_3d_maze() 
    else ' view = 2
      if m$(xa, ya + 1) <> wc$ then
        if m$(xa, ya + 1) = "." then
          score = score + 1
        endif
        oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
        m$(xa, ya + 1) = "x" : m$(xa, ya) = " "
        ys = ys + 1 : ya = ya + 1 
        if ys > 48 then
          ys = 0 : screen_drawn = 0 : drawn_maze = 0
        endif
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 109 then 'user presses M key to see the map / top view of the maze
    if view = 3 then
      view = 2 : screen_drawn = 0 : drawn_maze = 0 : draw_2d_maze()
    endif
  endif
loop

sub calculate 
  maxscreenx = fix((width - 1) / 100) + 1 
  maxscreeny = fix((height - 2) / 49) + 1
end sub

sub draw_2d_maze
  if screen_drawn = 0 and drawn_maze = 0 then 'just need one variable here
    cls
    screenx = fix(xa / 100) + 1
    screeny = fix(ya / 49) + 1
    ytlow = (screeny - 1 ) * 49
    ythigh = ytlow + 48
    xtlow = (screenx - 1 ) * 100
    xthigh = xtlow + 99
    ytbottom = screeny * 48

    m$(1, 1) = "u"  
    m$(width - 4, height - 4) = "d"

    for yt = ytlow to ythigh
      for xt = xtlow to xthigh
        if m$(xt, yt) <> "x" and m$(xt, yt) <> "u" and m$(xt, yt) <> "d" then
          print m$(xt, yt); 'prints ONE character
        else
          color Yellow : print m$(xt, yt); : color Indigo
        endif
      next xt
      if yt <> ybottom or yt = 0 then 'yt = 0 workaround to fix a bug
        print 'go to the next line
      endif
    next yt

    color Yellow
    print @(9 * 8, 49 * 12) "Score =";score;
    color Indigo
    screen_drawn = 1
    drawn_maze = 1
    pause 64
  else 'maze has already been drawn
    color Yellow
    print @(xs * 8, ys * 12)"x"; 'draw current location of player
    if abs(xs - oldxs) < 2 and abs(ys - oldys) < 2 then 'added to fix a bug
      print@(oldxs * 8, oldys * 12)" ";
    endif
    if xa < 100 and ya < 49 then
      print @(8, 12)"u"; 'the up ladder
    end if
    print @(16 * 8, 49 * 12) score;
    color Indigo
    pause 64
  endif
end sub


'  if drawn_maze = 0 then
'    for yt = 0 to height - 3
'      for xt = 0 to width - 3
'        if m$(xt, yt) = "x" then 'x represents the user's location within the maze
'          color Yellow
'          select case ch$
'            case "N"
'              print chr$(146); 'show the arrow pointing North character
'            case "S"
'              print chr$(147);
'            case "E"
'              print chr$(148);
'            case "W"
'              print chr$(149);
'          end select
'         color Indigo
'        else 'not the user's location
'         if m$(xt, yt) = wc$ then
'            color Indigo : print m$(xt, yt);
'          else
'            color Yellow : print m$(xt, yt);
'          endif
'        endif
'      next xt
'      print
'    next yt
'    drawn_maze = 1
'    do : loop while inkey$ = "" 'wait for user to press a key
'  else 'maze has already been drawn = drawn_maze = 1
'    color Yellow
'    print @(x * 8, y * 12)"x" 'draw current location of user
'    print @(oldx * 8, oldy * 12)" "
'    print @(8, 12)"u" 'the up ladder
'    print @((width - 4) * 8, (height - 4) * 12)"d" 'the down ladder
'    do : loop while inkey$ = "" 'wait for user to press a key
'  endif
'end sub


sub draw_3d_maze
  cls
  drawn_maze = 0
  '0 distant, cube in which the user is standing
  select case ch$
    case "N"
      xt = xa : yt = ya - 1
    case "S" 
      xt = xa : yt = ya + 1
    case "W"
      xt = xa - 1 : yt = ya
    case "E"
      xt = xa + 1 : yt = ya
  end select
  if m$(xt, yt) = "." then circle 399, 525, 32
  if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
    line 350,  40, 350, 560
    line 450,  40, 450, 560
    line 350,  60, 450,  60
    line 350, 140, 450, 140
    line 350, 220, 450, 220
    line 350, 300, 450, 300
    line 350, 380, 450, 380
    line 350, 460, 450, 460
    line 350, 540, 450, 540
    if m$(xt, yt) = "u" then
      line 265,  40, 535,  40
      line 325, 100, 475, 100
      line 265,  40, 325, 100
      line 535,  40, 475, 100
    else 'down ladder
      line 265, 560, 535, 560 
      line 325, 500, 475, 500 
      line 265, 560, 325, 500 
      line 535, 560, 475, 500 
    endif
  endif
  if xt < 0 then xt = 0
  if yt < 0 then yt = 0
  if m$(xt, yt) = wc$ then
    line   0,   0, 799,   0 '0T
    line   0, 599, 799, 599 '0B 
    draw$ = "N"
  else
    draw$ = "Y"
  endif  
  line   0,   0,   0, 599 '0L
  line 798,   0, 798, 599 '0R 

  '1 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 1        
      case "S"
        xt = xa + 1 : yt = ya + 1
      case "W"  
        xt = xa - 1 : yt = ya + 1
      case "E"
        xt = xa + 1 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line   0,   0, 200, 150 '1DUL
      line   0, 599, 200, 450 '1DBL 
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 1
      case "S"
        xt = xa - 1 : yt = ya + 1
      case "W"
        xt = xa - 1 : yt = ya - 1
      case "E"
        xt = xa + 1 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 799,   0, 600, 150 '1DUR
      line 799, 599, 600, 450 '1DBR 
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 2 
      case "S"
        xt = xa : yt = ya + 2
      case "W"
        xt = xa - 2 : yt = ya
      case "E"
        xt = xa + 2 : yt = ya
    end select
    if m$(xt, yt) = "." then circle 399, 413, 16
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 375, 170, 375, 430
      line 425, 170, 425, 430
      line 375, 180, 425, 180
      line 375, 220, 425, 220
      line 375, 260, 425, 260
      line 375, 300, 425, 300
      line 375, 340, 425, 340
      line 375, 380, 425, 380
      line 375, 420, 425, 420
      if m$(xt, yt) = "u" then
        line 340, 170, 460, 170 
        line 380, 200, 420, 200 
        line 340, 170, 380, 200 
        line 460, 170, 420, 200 
      else 'down ladder
        line 340, 430, 460, 430 
        line 380, 400, 425, 400 
        line 340, 430, 380, 400 
        line 460, 430, 425, 400 
      endif
    endif   
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then
      line 200, 150, 600, 150 '1T
      line 200, 450, 600, 450 '1B 
      draw$ = "N"
    endif

    line 200, 150, 200, 450 '1L
    line 600, 150, 600, 450 '1R 

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 1
      case "S"
        xt = xa + 1 : yt = ya + 1
      case "W"
        xt = xa - 1 : yt = ya + 1 
      case "E"
        xt = xa + 1 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then 
      line 200, 150,   0, 150 '1TL 
      line 200, 450,   0, 450 '1BL
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 1
      case "S"
        xt = xa - 1 : yt = ya + 1
      case "W"
        xt = xa - 1 : yt = ya - 1
      case "E"
        xt = xa + 1 : yt = ya + 1
    end select  
    if m$(xt, yt) <> wc$ then 
      line 600, 150, 799, 150 '1TR
      line 600, 450, 799, 450 '1BR
    endif
  endif

  '2 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 2
      case "S"
        xt = xa + 1 : yt = ya + 2
      case "W"
        xt = xa - 2 : yt = ya + 1
      case "E"
        xt = xa + 2 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 200, 150, 300, 225 '2DUL
      line 200, 450, 300, 375 '2DBL
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 2
      case "S"
        xt = xa - 1 : yt = ya + 2
      case "W"
        xt = xa - 2 : yt = ya - 1
      case "E"
        xt = xa + 2 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 600, 150, 500, 225 '2DUR
      line 600, 450, 500, 375 '2DBR 
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 3
      case "S"
        xt = xa : yt = ya + 3
      case "W"
        xt = xa - 3 : yt = ya
      case "E"
        xt = xa + 3 : yt = ya
    end select
    if m$(xt, yt) = "." then circle 399, 356, 8
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 387, 240, 387, 360
      line 413, 240, 413, 360
      line 387, 243, 413, 243
      line 387, 262, 413, 262
      line 387, 281, 413, 281
      line 387, 300, 413, 300
      line 387, 319, 413, 319
      line 387, 338, 413, 338
      line 387, 357, 413, 357
      if m$(xt, yt) = "u" then
        line 390, 253, 410, 253  
        line 367, 238, 433, 238 
        line 390, 253, 367, 238 
        line 410, 253, 433, 238 
      else 'down ladder
        line 390, 347, 410, 347 
        line 370, 360, 430, 360 
        line 390, 347, 370, 360 
        line 410, 347, 430, 360 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then
      line 300, 225, 500, 225 '2T
      line 300, 375, 500, 375 '2B
      draw$ = "N"
    endif

    line 300, 225, 300, 375 '2L
    line 500, 225, 500, 375 '2R

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 2
      case "S"
        xt = xa + 1 : yt = ya + 2
      case "W"
        xt = xa - 2 : yt = ya + 1
      case "E"
        xt = xa + 2 : yt = ya - 1  
    end select
    if m$(xt, yt) <> wc$ then
      line 300, 225, 200, 225 '2TL
      line 300, 375, 200, 375 '2BL
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 2
      case "S"
        xt = xa - 1 : yt = ya + 2
      case "W"
        xt = xa - 2 : yt = ya - 1
      case "E"
        xt = xa + 2 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 500, 225, 600, 225 '2TR
      line 500, 375, 600, 375 '2BR
    endif
  endif

  '3 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 3
      case "S"
        xt = xa + 1 : yt = ya + 3
      case "W"
        xt = xa - 3 : yt = ya + 1
      case "E"
        xt = xa + 3 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 300, 225, 350, 262 '3DUL
      line 300, 375, 350, 338 '3DBL 
    endif  

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 3
      case "S"
        xt = xa - 1 : yt = ya + 3
      case "W"
        xt = xa - 3 : yt = ya - 1
      case "E"
        xt = xa + 3 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 500, 225, 450, 262 '3DUR
      line 500, 375, 450, 338 '3DBR 
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 4
      case "S"
        xt = xa : yt = ya + 4
      case "W"
        xt = xa - 4 : yt = ya
      case "E"
        xt = xa + 4 : yt = ya
    end select        
    if m$(xt, yt) = "." then circle 399, 328, 4
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 393, 270, 393, 330
      line 407, 270, 407, 330
      line 393, 272, 407, 272
      line 393, 281, 407, 281
      line 393, 290, 407, 290
      line 393, 299, 407, 299
      line 393, 308, 407, 308
      line 393, 318, 407, 318
      line 393, 328, 407, 328
      if m$(xt, yt) = "u" then
        line 395, 277, 405, 277   
        line 384, 270, 416, 270 
        line 395, 277, 384, 270 
        line 405, 277, 416, 270 
      else 'down ladder
        line 395, 323, 405, 323 
        line 384, 330, 416, 330 
        line 395, 323, 384, 330 
        line 405, 323, 416, 330 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      line 350, 262, 450, 262 '3T wall
      line 350, 338, 450, 338 '3B wall
    draw$ = "N" 
    endif

    line 350, 262, 350, 338 '3L
    line 450, 262, 450, 338 '3R 

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 3
      case "S"
        xt = xa + 1 : yt = ya + 3
      case "W"
        xt = xa - 3 : yt = ya + 1
      case "E"
        xt = xa + 3 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then
      line 350, 262, 300, 262 '3TL 
      line 350, 338, 300, 338 '3BL
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 3
      case "S"
        xt = xa - 1 : yt = ya + 3
      case "W"
        xt = xa - 3 : yt = ya - 1
      case "E"
        xt = xa + 3 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 450, 262, 500, 262 '3TR
      line 450, 338, 500, 338 '3BR
    endif
  endif

  '4 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 4
      case "S"
        xt = xa + 1 : yt = ya + 4
      case "W"
        xt = xa - 4 : yt = ya + 1
      case "E"
        xt = xa + 4 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 350, 262, 375, 281 '4DUL
      line 350, 338, 375, 319 '4DBL     
    endif  

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 4
      case "S"
        xt = xa - 1 : yt = ya + 4
      case "W"
        xt = xa - 4 : yt = ya - 1
      case "E"
        xt = xa + 4 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 450, 262, 425, 281 '4DUR
      line 450, 338, 425, 319 '4DBR      
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 5
      case "S"
        xt = xa : yt = ya + 5
      case "W"
        xt = xa - 5 : yt = ya
      case "E"
        xt = xa + 5 : yt = ya
    end select        
    if m$(xt, yt) = "." then circle 399, 314, 2
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 396, 285, 396, 315
      line 404, 285, 404, 315
      line 396, 286, 404, 286
      line 396, 291, 404, 291
      line 396, 296, 404, 296
      line 396, 301, 404, 301
      line 396, 306, 404, 306
      line 396, 310, 404, 310
      line 396, 314, 404, 314
      if m$(xt, yt) = "u" then
        line 392, 284, 408, 284    
        line 397, 288, 403, 288 
        line 392, 284, 397, 288 
        line 408, 284, 403, 288 
      else 'down ladder
        line 392, 316, 408, 316 
        line 397, 312, 403, 312 
        line 392, 316, 397, 312 
        line 408, 316, 403, 312 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      line 375, 281, 425, 281 '4T 
      line 375, 319, 425, 319 '4B 
    draw$ = "N" 
    endif

    line 375, 281, 375, 319 '4L
    line 425, 281, 425, 319 '4R

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 4
      case "S"
        xt = xa + 1 : yt = ya + 4
      case "W"
        xt = xa - 4 : yt = ya + 1
      case "E"
        xt = xa + 4 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then
      line 375, 281, 350, 281 '4TL
      line 375, 319, 350, 319 '4BL      
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 4
      case "S"
        xt = xa - 1 : yt = ya + 4
      case "W"
        xt = xa - 4 : yt = ya - 1
      case "E"
        xt = xa + 4 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 425, 281, 450, 281 '4TR
      line 425, 319, 450, 319 '4BR      
    endif
  endif

  '5 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 5
      case "S"
        xt = xa + 1 : yt = ya + 5
      case "W"
        xt = xa - 5 : yt = ya + 1
      case "E"
        xt = xa + 5 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 375, 281, 387, 290 '5DUL
      line 375, 319, 387, 310 '5DBL
    endif  

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 5
      case "S"
        xt = xa - 1 : yt = ya + 5
      case "W"
        xt = xa - 5 : yt = ya - 1
      case "E"
        xt = xa + 5 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 425, 281, 413, 290 '5DUR
      line 425, 319, 413, 310 '5DBR
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 6
      case "S"
        xt = xa : yt = ya + 6
      case "W"
        xt = xa - 6 : yt = ya
      case "E"
        xt = xa + 6 : yt = ya
    end select        
    if m$(xt, yt) = "." then circle 399, 308, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 398, 292, 398, 308
      line 402, 292, 402, 308
      line 398, 292, 402, 292
      line 398, 295, 402, 295
      line 398, 297, 402, 297
      line 398, 300, 402, 300
      line 398, 302, 402, 302
      line 398, 305, 402, 305
      line 398, 308, 402, 308
      if m$(xt, yt) = "u" then
        line 398, 292, 402, 292     
        line 396, 290, 404, 290 
        line 398, 292, 396, 290 
        line 402, 292, 404, 290 
      else 'down ladder
        line 396, 308, 404, 308 
        line 398, 310, 402, 310 
        line 396, 308, 398, 310 
        line 404, 308, 402, 310 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      line 387, 290, 413, 290 '5T 
      line 387, 310, 413, 310 '5B 
    draw$ = "N" 
    endif

    line 387, 290, 387, 310 '5L 
    line 413, 290, 413, 310 '5R

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 5
      case "S"
        xt = xa + 1 : yt = ya + 5
      case "W"
        xt = xa - 5 : yt = ya + 1
      case "E"
        xt = xa + 5 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then
      line 387, 290, 375, 290 '5TL
      line 387, 310, 375, 310 '5BL      
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 5
      case "S"
        xt = xa - 1 : yt = ya + 5
      case "W"
        xt = xa - 5 : yt = ya - 1
      case "E"
        xt = xa + 5 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 413, 290, 425, 290 '5TR
      line 413, 310, 425, 310 '5BR      
    endif
  endif

  '6 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 6
      case "S"
        xt = xa + 1 : yt = ya + 6
      case "W"
        xt = xa - 6 : yt = ya + 1
      case "E"
        xt = xa + 6 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 387, 290, 393, 295 '6DUL
      line 387, 310, 393, 305 '6DBL 
    endif  

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 6
      case "S"
        xt = xa - 1 : yt = ya + 6
      case "W"
        xt = xa - 6 : yt = ya - 1
      case "E"
        xt = xa + 6 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 413, 290, 407, 295 '6DUR
      line 413, 310, 407, 305 '6DBR
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 7
      case "S"
        xt = xa : yt = ya + 7
      case "W"
        xt = xa - 7 : yt = ya
      case "E"
        xt = xa + 7 : yt = ya
    end select        
    if m$(xt, yt) = "." then circle 399, 304, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 399, 296, 399, 304
      line 401, 296, 401, 304
      line 399, 296, 401, 296
      line 399, 297, 401, 297
      line 399, 299, 401, 299
      line 399, 300, 401, 300
      line 399, 302, 401, 302
      line 399, 303, 401, 303
      line 399, 304, 401, 304
      if m$(xt, yt) = "u" then
        line 398, 296, 402, 296     
        line 399, 297, 401, 297 
        line 398, 296, 399, 297 
        line 402, 296, 401, 297 
      else 'down ladder
        line 398, 304, 402, 304 
        line 399, 305, 401, 305 
        line 398, 304, 399, 305 
        line 402, 304, 401, 305 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      line 393, 295, 407, 295 '6T
      line 393, 305, 407, 305 '6B       
    draw$ = "N" 
    endif

    line 393, 295, 393, 305 '6L
    line 407, 295, 407, 305 '6R 

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 6
      case "S"
        xt = xa + 1 : yt = ya + 6
      case "W"
        xt = xa - 6 : yt = ya + 1
      case "E"
        xt = xa + 6 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then
      line 393, 295, 387, 295 '6TL
      line 393, 305, 387, 305 '6BL      
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 6
      case "S"
        xt = xa - 1 : yt = ya + 6
      case "W"
        xt = xa - 6 : yt = ya - 1
      case "E"
        xt = xa + 6 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 407, 295, 413, 295 '6TR
      line 407, 305, 413, 305 '6BR      
    endif
  endif
      
  '7 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 7
      case "S"
        xt = xa + 1 : yt = ya + 7
      case "W"
        xt = xa - 7 : yt = ya + 1
      case "E"
        xt = xa + 7 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 393, 295, 396, 297 '7DUL
      line 393, 305, 396, 303 '7DBL
    endif  

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 7
      case "S"
        xt = xa - 1 : yt = ya + 7
      case "W"
        xt = xa - 7 : yt = ya - 1
      case "E"
        xt = xa + 7 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 407, 295, 404, 297 '7DUR
      line 407, 305, 404, 303 '7DBR
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 8
      case "S"
        xt = xa : yt = ya + 8
      case "W"
        xt = xa - 8 : yt = ya
      case "E"
        xt = xa + 8 : yt = ya
    end select        
    if m$(xt, yt) = "." then circle 399, 302, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 399, 298, 399, 302
      line 400, 298, 400, 302
      line 399, 298, 400, 298
      line 399, 299, 400, 299
      line 399, 299, 400, 299
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      line 399, 301, 400, 301
      line 399, 302, 400, 302
      if m$(xt, yt) = "u" then
        line 399, 297, 401, 297     
        line 400, 299, 400, 300 
        line 399, 296, 400, 299 
        line 401, 296, 400, 300 
      else 'down ladder
        line 399, 304, 401, 304 
        line 400, 305, 400, 305 
        line 399, 304, 400, 305 
        line 401, 304, 400, 305 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      line 396, 297, 404, 297 '7T
      line 396, 303, 404, 303 '7B 
    draw$ = "N" 
    endif

    line 396, 297, 396, 303 '7L
    line 404, 297, 404, 303 '7R 

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 7
      case "S"
        xt = xa + 1 : yt = ya + 7
      case "W"
        xt = xa - 7 : yt = ya + 1
      case "E"
        xt = xa + 7 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then
      line 396, 297, 393, 297 '7TL
      line 396, 303, 393, 303 '7BL      
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 7
      case "S"
        xt = xa - 1 : yt = ya + 7
      case "W"
        xt = xa - 7 : yt = ya - 1
      case "E"
        xt = xa + 7 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 404, 297, 407, 297 '7TR
      line 404, 303, 407, 303 '7BR
    endif
  endif
    
  '8 distant
  if draw$ = "Y" then
    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 8
      case "S"
        xt = xa + 1 : yt = ya + 8
      case "W"
        xt = xa - 8 : yt = ya + 1
      case "E"
        xt = xa + 8 : yt = ya - 1
    end select
    if m$(xt, yt) = wc$ then
      line 396, 297, 398, 299 '8DUL
      line 396, 303, 398, 301 '8DBL
    endif  

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 8
      case "S"
        xt = xa - 1 : yt = ya + 8
      case "W"
        xt = xa - 8 : yt = ya - 1
      case "E"
        xt = xa + 8 : yt = ya + 1
    end select
    if m$(xt, yt) = wc$ then
      line 404, 297, 402, 299 '8DUR 
      line 404, 303, 402, 301 '8DBR 
    endif

    select case ch$
      case "N"
        xt = xa : yt = ya - 9
      case "S"
        xt = xa : yt = ya + 9
      case "W"
        xt = xa - 9 : yt = ya
      case "E"
        xt = xa + 9 : yt = ya
    end select        
    if m$(xt, yt) = "." then circle 399, 301, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      line 399, 299, 399, 300
      line 400, 299, 400, 300
      line 399, 299, 400, 299
      line 399, 299, 400, 299
      line 399, 299, 400, 299
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      if m$(xt, yt) = "u" then
        line 399, 299, 400, 299     
        line 400, 300, 400, 300 
        line 399, 299, 400, 300 
        line 400, 299, 400, 300 
      else 'down ladder
        line 399, 302, 400, 302 
        line 400, 303, 400, 303 
        line 399, 302, 400, 303 
        line 400, 302, 400, 303 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      line 398, 299, 402, 299 '8T
      line 398, 301, 402, 301 '8B 
    draw$ = "N" 
    endif

    line 398, 299, 398, 301 '8L
    line 402, 299, 402, 301 '8R

    select case ch$
      case "N"
        xt = xa - 1 : yt = ya - 8
      case "S"
        xt = xa + 1 : yt = ya + 8
      case "W"
        xt = xa - 8 : yt = ya + 1
      case "E"
        xt = xa + 8 : yt = ya - 1
    end select
    if m$(xt, yt) <> wc$ then
      line 398, 299, 396, 299 '8TL
      line 398, 301, 396, 301 '8BL 
    endif

    select case ch$
      case "N"
        xt = xa + 1 : yt = ya - 8
      case "S"
        xt = xa - 1 : yt = ya + 8
      case "W"
        xt = xa - 8 : yt = ya - 1
      case "E"
        xt = xa + 8 : yt = ya + 1
    end select    
    if m$(xt, yt) <> wc$ then
      line 402, 299, 404, 299 '8TR
      line 402, 301, 404, 301 '8BR    
    endif
  endif
  print @(399, 12) ch$;"            ";score;" /";maxscore
  pause 200
end sub





















































