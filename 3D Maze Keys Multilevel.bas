
'3D Maze Keys Multilevel
#include "colors.inc"
option base 0
dim integer width, height, depth, view, done, have_key, floor, level
dim integer i, x, y, z, xt, yt, zt, screen_drawn, drawn_maze
dim integer xa, ya, za, xs, ys, zs 'x, y, and z locations in the array
dim integer oldxa, oldya, oldza, oldxs, oldys, oldzs
dim integer score, d, f, seed, sx, sy, sz, starttime, countdown
dim integer xtlow, xthigh, ytlow, ythigh
dim integer ybottom, screen, screenx, screeny, maxscreenx, maxscreeny
dim integer mg(48, 48, 32)
dim string ch$ length 1 'Compass Heading
dim string m$(48, 48, 32) length 1 'Maze array
dim string draw$ = "Y" length 1
dim string wc$ length 1 = chr$(219) 'Wall character
dim string uc$ length 1 = chr$(146) 'Arrow UP character
dim string dc$ length 1 = chr$(147) 'Arrow DOWN character
dim string bc$ length 1 = chr$(144) 'Arrows BOTH up and down character
cls : mode 1, 16 : color Indigo
? "Controls are Space Bar, M, Page Up, Page Down, and the four cursor keys."
pause 3000 : cls

'**************************************
width = 11 : height = 11 : depth = 11  'dimensions must be ODD
'**************************************

level = 1 : score = 0 

generate()

sub generate
  seed = int(rnd * 1234567890)
  for z = 1 to depth 
    for y = 1 to height  
      for x = 1 to width   
        mg(x, y, z) = 0
      next x   
    next y
  next z
  for z = 1 to depth
    for y = 1 to height
      mg(1, y, z) = 2: mg(width, y, z) = 2 'The edges
    next y
  next z
  for z = 1 to depth 
    for x = 1 to width  
      mg(x, 1, z) = 2 : mg(x, height, z) = 2 'The edges
    next x
  next z
  for y = 1 to height
    for x = 1 to width
      mg(x, y, 1) = 2 : mg(x, y, depth) = 2 'The edges
    next x
  next y
  mg(3, 3, 3) = 1   
  f = ((width - 3) / 2) * ((height - 3) / 2) * ((depth - 3) / 2) - 1

  TwentyOne: 
  for sz = 3 to depth - 2 step 2
    for sy = 3 to height - 2 step 2
      for sx = 3 to width - 2 step 2
        gosub TwentySeven
      next sx
    next sy
  next sz
  if f > 0 goto TwentyOne
  'mg(2, 3, 3) = 1 : mg(width - 1, height - 2, depth - 2) = 1 'Maze entrance and exit
  goto main  
 
  TwentySeven:
  x = sx : y = sy : z =sz
  if mg(x, y, z) <> 1 then return
  goto FourtyOne

  Thirty:
  on d goto ThirtyThree, ThirtyFour, ThirtyFive, ThirtySix, ThirtySeven, ThirtyEight

  ThirtyOne:
  if i = 6 then return
  d = int(rnd * 6) + 1 : i = i + 1 : goto Thirty

  ThirtyThree:
  if mg(x + 1, y, z) + mg(x + 2, y, z) goto ThirtyOne
  mg(x + 1, y, z) = 1 : x = x + 2 : goto FourtyOne

  ThirtyFour:
  if mg(x - 1, y, z) + mg(x - 2, y, z) goto ThirtyOne
  mg(x - 1, y, z) = 1 : x = x - 2 : goto FourtyOne

  ThirtyFive:
  if mg(x, y + 1, z) + mg(x, y + 2, z) goto ThirtyOne
  mg(x, y + 1, z) = 1 : y = y + 2 : goto FourtyOne

  ThirtySix:
  if mg(x, y - 1, z) + mg(x, y - 2, z) goto ThirtyOne
  mg(x, y - 1, z) = 1 : y = y - 2 : goto FourtyOne

  ThirtySeven:
  if mg(x, y, z + 1) + mg(x, y, z + 2) goto ThirtyOne
  mg(x, y, z + 1) = 1 : z = z + 2 : goto FourtyOne

  ThirtyEight:
  if mg(x, y, z - 1) + mg(x, y, z - 2) goto ThirtyOne
  mg(x, y, z - 1) = 1 : z = z - 2 : goto FourtyOne

  FourtyOne:
  i = 0 : d = int(rnd(seed) * 6) + 1
  if mg(x, y, z) = 0 then f = f - 1
  mg(x, y, z) = 1 : goto Thirty
end sub

main:
'For now convert the generated array into the other array 
'Need to convert some empty space cubes to up, down, and both ladders
for z = 0 to depth - 3
  for y = 0 to height - 3  
    for x = 0 to width - 3 
      if mg(x + 2, y + 2, z + 2) = 0 then 
        m$(x, y, z) = wc$
      else
        if mg(x + 2, y + 2, z + 1) <> 0 and mg(x + 2, y + 2, z + 3) <> 0 then
          m$(x, y, z) = bc$
        elseif mg(x + 2, y + 2, z + 1) <> 0 then
          m$(x, y, z) = uc$
        elseif mg(x + 2, y + 2, z + 3) <> 0 then
          m$(x, y, z) = dc$
        else
          m$(x, y, z) = " " 
        endif
      endif
    next x
  next y
next z
if m$(width - 4, height - 4, depth - 5) = wc$ then 
  m$(width - 4, height - 4, depth - 4) = dc$ 'exit of maze is down a ladder
else
  m$(width - 4, height - 4, depth - 4) = bc$ 'exit of maze is down a ladder, also has up ladder
endif
cls

'-----------------------------------------------------------------------------------------
xa = 1 : ya = 1 : za = 1 : xs = 1 : ys = 1 : zs = 1 : view = 2 '2 for 2D 
oldxa = xa : oldya = ya : oldza = za : oldxs = xs : oldys = ys : oldzs = zs
floor = 1 : have_key = 0 : timer = 0 : starttime = 240000 * level 
screen_drawn = 0 : m$(1, 1, 1) = "x" : ch$ = "S" : drawn_maze = 0 

do
  x = int(rnd * width) : y = int(rnd * height) : z = int(rnd * depth)
  if m$(x, y, z) = " " then
    m$(x, y, z) = "k" : exit
  endif
loop

for i = 1 to level
  do
    x = int(rnd * width) : y = int(rnd * height) : z = int(rnd * depth)
    if m$(x, y, z) = " " then
      m$(x, y,z) = "t" : exit
    endif
  loop
next i

calculate()
draw_2d_maze()

do
  countdown = (cint(int(starttime - int(timer)) / 1000))
  if countdown = 0 then 
    play STOP
    play FLAC "13 Red Alert Klaxon.flac"
  endif  
  if keydown(1) = 32 then ' User presses space bar
    view = 3
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
      if m$(xa - 1, ya, za) <> wc$ then
        if m$(xa - 1, ya, za) = "t" then
          score = score + 1
        elseif m$(xa - 1, ya, za) = "k" then
          have_key = 1
        endif
        oldxs = xs : oldys = ys : oldzs = zs : oldxa = xa : oldya = ya : oldza = za 
        m$(xa - 1, ya, za) = "x" : putback()
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
      if m$(xa + 1, ya, za) <> wc$ then
        if m$(xa + 1, ya, za) = "t" then
          score = score + 1
        elseif m$(xa + 1, ya, za) = "k" then
          have_key = 1
        endif
        oldxs = xs : oldys = ys : oldzs = zs : oldxa = xa : oldya = ya : oldza = za
        m$(xa + 1, ya, za) = "x" : putback()
        xs = xs + 1 : xa = xa + 1 
        if xs = 100 then 
          xs = 0 : screen_drawn = 0 : drawn_maze = 0
        endif
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 128 then 'User presses the cursor forward key
    if view = 3 then
      select case ch$
        case "W"
          if m$(xa - 1, ya, za) <> wc$ then 
            if m$(xa - 1, ya, za) = "t" then
              score = score + 1
            elseif m$(xa - 1, ya, za) = "k" then
              have_key = 1
            endif
            m$(xa - 1, ya, za) = "x" 'Update the location of the user
            putback() 'Update the former location of the user
            xs = xs - 1 : xa = xa - 1 
          endif
        case "E"
          if m$(xa + 1, ya, za) <> wc$ then 
            if m$(xa + 1, ya, za) = "t" then
              score = score + 1
            elseif m$ (xa + 1, ya, za) = "k" then
              have_key = 1
            endif
            m$(xa + 1, ya, za) = "x" : putback()
            xs = xs + 1 : xa = xa + 1
          endif
        case "N"
          if m$(xa, ya - 1, za) <> wc$ then 
            if m$(xa, ya - 1, za) = "t" then 
              score = score + 1
            elseif m$(xa, ya - 1, za) = "k" then
              have_key = 1
            endif
            m$(xa, ya - 1, za) = "x" : putback()
            ys = ys - 1 : ya = ya - 1
          endif
        case "S"
          if m$(xa, ya + 1, za) <> wc$ then
            if m$(xa, ya + 1, za) = "t" then
              score = score + 1
            elseif m$(xa, ya + 1, za) = "k" then
              have_key = 1
            endif
            m$(xa, ya + 1, za) = "x" : putback()
            ys = ys + 1 : ya = ya + 1
          endif
      end select
      draw_3d_maze() 
    else 'view = 2
      if m$(xa, ya - 1, za) <> wc$ then
        if m$(xa, ya - 1, za) = "t" then
          score = score + 1
        elseif m$(xa, ya - 1, za) = "k" then
          have_key = 1
        endif
        oldxs = xs : oldys = ys : oldzs = zs : oldxa = xa : oldya = ya : oldza = za
        m$(xa, ya - 1, za) = "x" : putback()
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
          if m$(xa + 1, ya, za) <> wc$ then
            if m$(xa + 1, ya, za) = "t" then
              score = score + 1
            elseif m$(xa + 1, ya, za) = "k" then
              have_key = 1
            endif
            m$(xa + 1, ya, za) = "x" : putback()
            xs = xs + 1 : xa = xa + 1
          endif
        case "E"
          if m$(xa - 1, ya, za) <> wc$ then 
            if m$(xa - 1, ya, za) = "t" then
              score = score + 1
            elseif m$(xa - 1, ya, za) = "k" then
              have_key = 1
            endif
            m$(xa - 1, ya, za) = "x" : putback()
            xs = xs - 1 : xa = xa - 1
          endif
        case "N"
          if m$(xa, ya + 1, za) <> wc$ then 
            if m$(xa, ya + 1, za) = "t" then
              score = score + 1
            elseif m$(xa, ya + 1, za) = "k" then
              have_key = 1
            endif
            m$(xa, ya + 1, za) = "x" : putback()
            ys = ys + 1 : ya = ya + 1
          endif
        case "S"
          if m$(xa, ya - 1, za) <> wc$ then  
            if m$(xa, ya - 1, za) = "t" then
              score = score + 1
            elseif m$(xa, ya - 1, za) = "k" then
              have_key = 1
            endif
            m$(xa, ya - 1, za) = "x" : putback()
            ys = ys - 1 : ya = ya - 1
          endif
      end select 
      draw_3d_maze() 
    else ' view = 2
      if m$(xa, ya + 1, za) <> wc$ then
        if m$(xa, ya + 1, za) = "t" then
          score = score + 1
        elseif m$(xa, ya + 1, za) = "k" then
          have_key = 1
        endif
        oldxs = xs : oldys = ys : oldzs = zs : oldxa = xa : oldya = ya : oldza = za
        m$(xa, ya + 1, za) = "x" : putback()
        ys = ys + 1 : ya = ya + 1 
        if ys > 48 then
          ys = 0 : screen_drawn = 0 : drawn_maze = 0
        endif
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 136 then 'user presses Page Up key to climb UP one floor
    if view = 3 then
      if m$(xa, ya, za - 1) <> wc$ then 
        if m$(xa, ya, za - 1) = "t" then
          score = score + 1
        elseif m$(xa, ya, za - 1) = "k" then
          have_key = 1
        endif
        m$(xa, ya, za - 1) = "x" : putback()
        zs = zs - 1 : za = za - 1
      endif      
      draw_3d_maze() 
    else 'view = 2
      if m$(xa, ya, za - 1) <> wc$ then
        if m$(xa, ya, za - 1) = "t" then
          score = score + 1
        elseif m$(xa, ya, za - 1) = "k" then
          have_key = 1
        endif
        oldxs = xs : oldys = ys : oldzs = zs : oldxa = xa : oldya = ya : oldza = za
        m$(xa, ya, za - 1) = "x" : putback()
        zs = zs - 1 : za = za - 1
        screen_drawn = 0 : drawn_maze = 0
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 137 then 'user presses Page Down key to climb DOWN one floor
    if xa = width - 4 and ya = height - 4 and za = depth - 4 and have_key = 1 then
      if (level + 1) mod 6 = 0 then
        depth = depth + 2
      else
        width = width + 2 : height = height + 2 
      endif
      level = level + 1 : have_key = 0 : generate()
    endif
    if view = 3 then
      if m$(xa, ya, za + 1) <> wc$ then 
        if m$(xa, ya, za + 1) = "t" then
          score = score + 1
        elseif m$(xa, ya, za + 1) = "k" then
          have_key = 1
        endif
        m$(xa, ya, za + 1) = "x" : putback()
        zs = zs + 1 : za = za + 1
      endif      
      draw_3d_maze() 
    else 'view = 2
      if m$(xa, ya, za + 1) <> wc$ then
        if m$(xa, ya, za + 1) = "t" then
          score = score + 1
        elseif m$(xa, ya, za + 1) = "k" then
          have_key = 1
        endif
        oldxs = xs : oldys = ys : oldzs = zs : oldxa = xa : oldya = ya : oldza = za
        m$(xa, ya, za + 1) = "x" : putback()
        zs = zs + 1 : za = za + 1
        screen_drawn = 0 : drawn_maze = 0
        draw_2d_maze()
      endif
    endif
  elseif keydown(1) = 109 then 'user presses M key to see the map / top view of the maze
    if view = 3 then
      view = 2 : screen_drawn = 0 : drawn_maze = 0 : draw_2d_maze()
    endif
  endif
loop

sub putback
  if m$(xa, ya, za - 1) <> wc$ and m$(xa, ya, za + 1) <> wc$ then
    m$(xa, ya, za) = bc$
  elseif m$(xa, ya, za - 1) <> wc$ then
    m$(xa, ya, za) = uc$
  elseif m$(xa, ya, za + 1) <> wc$ then
    m$(xa, ya, za) = dc$
  else
    m$(xa, ya, za) = " " 
  endif
  if m$(width - 4, height - 4, depth - 4) = " " then
    m$(width - 4, height - 4, depth - 4) = dc$  
  elseif m$(width - 4, height - 4, depth - 4) = uc$ then
    m$(width - 4, height - 4, depth - 4) = bc$
  endif
end sub

sub putback2d 
  if m$(oldxa, oldya, oldza - 1) <> wc$ and m$(oldxa, oldya, oldza + 1) <> wc$ then 
    print @(oldxs * 8, oldys * 12) bc$; 
  elseif m$(oldxa, oldya, oldza - 1) <> wc$ then 
    print @(oldxs * 8, oldys * 12) uc$; 
  elseif m$(oldxa, oldya, oldza + 1) <> wc$ then 
    print @(oldxs * 8, oldys * 12) dc$; 
  else
    print @(oldxs * 8, oldys * 12) " "; 
  endif
  if floor = depth - 4 then
    if m$(width - 4, height - 4, depth - 4) = dc$ then
      print @((width - 4) * 8, (height - 4) * 12) dc$;
    elseif m$(width - 4, height - 4, depth - 4) = bc$ then
      print @((width - 4) * 8, (height - 4) * 12) bc$;
    endif
  endif
end sub

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

    for yt = ytlow to 47 'ythigh
      for xt = xtlow to 47 'xthigh
        if m$(xt, yt, za) <> "x" then
          print m$(xt, yt, za); 'prints ONE character
        else
          color Yellow : print m$(xt, yt, za); : color Indigo
        endif
      next xt
      if yt <> ybottom or yt = 0 then 
        print 'go to the next line
      endif
    next yt

    color Yellow
    print @(9 * 8, 49 * 12) "Level =";
    color Indigo
    print @(16 * 8, 49 * 12) level; 
    color Yellow
    print @(25 * 8, 49 * 12) "Floor =";
    color Indigo
    print @(32 * 8, 49 * 12) za; 
    color Yellow
    print @(41 * 8, 49 * 12) "Score =";
    color Indigo
    print @(48 * 8, 49 * 12) score; 
    color Yellow
    if have_key = 0 then
      print @(57 * 8, 49 * 12) "  need key ";
    elseif have_key = 1 then
      print @(57 * 8, 49 * 12) "  found key";
    endif
    print @(70 * 8, 49 * 12) "Timer =";
    color Indigo
    print @(77 * 8, 49 * 12) countdown;
    screen_drawn = 1
    drawn_maze = 1
    pause 64
  else 'maze has already been drawn
    color Yellow
    print @(xs * 8, ys * 12)"x"; 'draw current location of player
    color Indigo
    'if abs(xs - oldxs) < 2 and abs(ys - oldys) < 2 then 'added to fix a bug
      putback2d() 
    'endif
    print @(16 * 8, 49 * 12) level;
    print @(32 * 8, 49 * 12) za;
    print @(48 * 8, 49 * 12) score;
    if have_key = 0 then
      print @(57 * 8, 49 * 12) "  need key ";   
    elseif have_key = 1 then
      print @(57 * 8, 49 * 12) "  found key";
    endif
    print @(77 * 8, 49 * 12) countdown;
    pause 64
  endif
end sub

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
  zt = za
  if m$(xt, yt, zt) = "t" then circle 399, 525, 32
  if m$(xt, yt, zt) = "k" then
    circle 399, 525, 16
    line 415, 525, 463, 525
    line 463, 525, 463, 541
    line 447, 525, 447, 541
  endif
  if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
    line 350,  40, 350, 560
    line 450,  40, 450, 560
    line 350,  60, 450,  60
    line 350, 140, 450, 140
    line 350, 220, 450, 220
    line 350, 300, 450, 300
    line 350, 380, 450, 380
    line 350, 460, 450, 460
    line 350, 540, 450, 540
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
      line 265,  40, 535,  40
      line 325, 100, 475, 100
      line 265,  40, 325, 100
      line 535,  40, 475, 100
    endif
    if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 265, 560, 535, 560 
      line 325, 500, 475, 500 
      line 265, 560, 325, 500 
      line 535, 560, 475, 500 
    endif
  endif
  if xt < 0 then xt = 0
  if yt < 0 then yt = 0
  if zt < 0 then zt = 0
  if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if xt < 0 then xt = 0 'BAR
    if yt < 0 then yt = 0 'BAR
    if zt < 1 then zt = 1 'BAR
    if m$(xt, yt, zt) = "t" then circle 399, 413, 16
    if m$(xt, yt, zt) = "k" then
      circle 399, 413, 8
      line 407, 413, 431, 413
      line 431, 413, 431, 421
      line 423, 413, 423, 421
    endif
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 375, 170, 375, 430
      line 425, 170, 425, 430
      line 375, 180, 425, 180
      line 375, 220, 425, 220
      line 375, 260, 425, 260
      line 375, 300, 425, 300
      line 375, 340, 425, 340
      line 375, 380, 425, 380
      line 375, 420, 425, 420
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 340, 170, 460, 170 
        line 380, 200, 420, 200 
        line 340, 170, 380, 200 
        line 460, 170, 420, 200 
      endif
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 340, 430, 460, 430 
        line 380, 400, 425, 400 
        line 340, 430, 380, 400 
        line 460, 430, 425, 400 
      endif
    endif   
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then 
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = "t" then circle 399, 356, 8
    if m$(xt, yt, zt) = "k" then
      circle 399, 356, 4
      line 403, 356, 415, 356
      line 415, 356, 415, 360
      line 411, 356, 411, 360
    endif
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 387, 240, 387, 360
      line 413, 240, 413, 360
      line 387, 243, 413, 243
      line 387, 262, 413, 262
      line 387, 281, 413, 281
      line 387, 300, 413, 300
      line 387, 319, 413, 319
      line 387, 338, 413, 338
      line 387, 357, 413, 357
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 390, 253, 410, 253  
        line 367, 238, 433, 238 
        line 390, 253, 367, 238 
        line 410, 253, 433, 238
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 390, 347, 410, 347 
        line 370, 360, 430, 360 
        line 390, 347, 370, 360 
        line 410, 347, 430, 360 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = "t" then circle 399, 328, 4
    if m$(xt, yt, zt) = "k" then
      circle 399, 328, 2
      line 401, 328, 407, 328
      line 407, 328, 407, 330
      line 405, 328, 405, 330
    endif
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 393, 270, 393, 330
      line 407, 270, 407, 330
      line 393, 272, 407, 272
      line 393, 281, 407, 281
      line 393, 290, 407, 290
      line 393, 299, 407, 299
      line 393, 308, 407, 308
      line 393, 318, 407, 318
      line 393, 328, 407, 328
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 395, 277, 405, 277   
        line 384, 270, 416, 270 
        line 395, 277, 384, 270 
        line 405, 277, 416, 270
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 395, 323, 405, 323 
        line 384, 330, 416, 330 
        line 395, 323, 384, 330 
        line 405, 323, 416, 330 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = "t" then circle 399, 314, 2
    if m$(xt, yt, zt) = "k" then
      circle 399, 314, 1
      line 400, 314, 403, 314
      line 403, 314, 403, 315
      line 402, 314, 402, 315
    endif
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 396, 285, 396, 315
      line 404, 285, 404, 315
      line 396, 286, 404, 286
      line 396, 291, 404, 291
      line 396, 296, 404, 296
      line 396, 301, 404, 301
      line 396, 306, 404, 306
      line 396, 310, 404, 310
      line 396, 314, 404, 314
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 392, 284, 408, 284    
        line 397, 288, 403, 288 
        line 392, 284, 397, 288 
        line 408, 284, 403, 288
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 392, 316, 408, 316 
        line 397, 312, 403, 312 
        line 392, 316, 397, 312 
        line 408, 316, 403, 312 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = "t" then circle 399, 308, 1
    if m$(xt, yt, zt) = "k" then line 399, 308, 400, 308
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 398, 292, 398, 308
      line 402, 292, 402, 308
      line 398, 292, 402, 292
      line 398, 295, 402, 295
      line 398, 297, 402, 297
      line 398, 300, 402, 300
      line 398, 302, 402, 302
      line 398, 305, 402, 305
      line 398, 308, 402, 308
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 398, 292, 402, 292     
        line 396, 290, 404, 290 
        line 398, 292, 396, 290 
        line 402, 292, 404, 290
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 396, 308, 404, 308 
        line 398, 310, 402, 310 
        line 396, 308, 398, 310 
        line 404, 308, 402, 310 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = "t" then circle 399, 304, 1
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 399, 296, 399, 304
      line 401, 296, 401, 304
      line 399, 296, 401, 296
      line 399, 297, 401, 297
      line 399, 299, 401, 299
      line 399, 300, 401, 300
      line 399, 302, 401, 302
      line 399, 303, 401, 303
      line 399, 304, 401, 304
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 398, 296, 402, 296     
        line 399, 297, 401, 297 
        line 398, 296, 399, 297 
        line 402, 296, 401, 297
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 398, 304, 402, 304 
        line 399, 305, 401, 305 
        line 398, 304, 399, 305 
        line 402, 304, 401, 305 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = "t" then circle 399, 302, 1
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 399, 298, 399, 302
      line 400, 298, 400, 302
      line 399, 298, 400, 298
      line 399, 299, 400, 299
      line 399, 299, 400, 299
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      line 399, 301, 400, 301
      line 399, 302, 400, 302
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 399, 297, 401, 297     
        line 400, 299, 400, 300 
        line 399, 296, 400, 299 
        line 401, 296, 400, 300
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 399, 304, 401, 304 
        line 400, 305, 400, 305 
        line 399, 304, 400, 305 
        line 401, 304, 400, 305 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = wc$ then
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
    zt = za
    if m$(xt, yt, zt) = "t" then circle 399, 301, 1
    if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then 
      line 399, 299, 399, 300
      line 400, 299, 400, 300
      line 399, 299, 400, 299
      line 399, 299, 400, 299
      line 399, 299, 400, 299
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      line 399, 300, 400, 300
      if m$(xt, yt, zt) = uc$ or m$(xt, yt, zt) = bc$ then
        line 399, 299, 400, 299     
        line 400, 300, 400, 300 
        line 399, 299, 400, 300 
        line 400, 299, 400, 300
      endif 
      if m$(xt, yt, zt) = dc$ or m$(xt, yt, zt) = bc$ then
        line 399, 302, 400, 302 
        line 400, 303, 400, 303 
        line 399, 302, 400, 303 
        line 400, 302, 400, 303 
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if zt < 0 then zt = 0
    if m$(xt, yt, zt) = wc$ then 
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
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
    zt = za
    if m$(xt, yt, zt) <> wc$ then
      line 402, 299, 404, 299 '8TR
      line 402, 301, 404, 301 '8BR    
    endif
  endif
  if have_key = 0 then
    print @(399, 12) ch$;"    L";level;"  F";za;"  S";score;"  need key ";"  T";countdown;   
  elseif have_key = 1 then
    print @(399, 12) ch$;"    L";level;"  F";za;"  S";score;"  found key";"  T";countdown;
  endif
  pause 200
end sub





















































