
'3D Maze filled walls
#include "colors.inc"
option base 0
dim integer width, height, done, i, x, y, xt, yt, screen_drawn, drawn_maze, view
dim integer xa, ya, xs, ys, starttime, countdown, duld, ddld 'draw up/down ladder distance
dim integer oldxa, oldya, oldxs, oldys
dim integer score, maxscore, d, f, seed, sx, sy, have_key, floor, fc 'floor color
dim integer xtlow, xthigh, ytlow, ythigh
dim integer ybottom, screen, screenx, screeny, maxscreenx, maxscreeny
dim integer mg(301, 301), px(4), py(4)
dim string ch$ length 1 'Compass Heading
dim string m$(301, 301) length 1 'Maze array
dim string draw$ = "Y" length 1
dim string wc$ length 1 = chr$(219) 'Wall character
cls : mode 1, 16 : color Indigo
? "Controls are Space Bar, M, D, and the four cursor keys."
pause 3000 : cls

'***************************
width = 11 : height = 11     'Initial width and height which is actually 9 x 9
'*************************** 'Note that actual size is two units less in both dimensions

floor = 1 : have_key = 0 : score = 0 : max_score = 0 : fc = rgb(0, 0, 139)
generate()

sub generate
  seed = int(rnd * 1234567890)
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
  mg(x, y) = 1 : goto Thirty

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
  xa = 1 : ya = 1 : xs = 1 : ys = 1 : view = 3 : duld = 99 : ddld = 99
  oldxa = xa : oldya = ya : oldxs = xs : oldys = ys
  screen_drawn = 0 : m$(1, 1) = "x" : ch$ = "S"
  drawn_maze = 0 : m$(width - 4, height - 4) = "d"
  timer = 0 : starttime = 90000 * floor

  do 'Create a key at a random location in the maze floor 
    x = int(rnd * width)
    y = int(rnd * height)
    if m$(x, y) = " " then
      m$(x, y) = "k"
      exit
    endif
  loop 

  for i = 1 to floor 
    do 'Create a treasure at a random location in the maze floor   
      x = int(rnd * width)
      y = int(rnd * height)
      if m$(x, y) = " " then
        m$(x, y) = "t"
        exit
      endif
    loop
  next i 

  calculate()
  draw_3d_maze()
end sub

  do
    countdown = (cint(int(starttime - int(timer)) / 1000 ))
    if countdown = 0 then
      play STOP
      play FLAC "13 Red Alert Klaxon.flac"
    endif
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
          if m$(xa - 1, ya) = "t" then
            score = score + 1
          elseif m$(xa - 1, ya) = "k" then
            have_key = 1
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
          if m$(xa + 1, ya) = "t" then
            score = score + 1
          elseif m$(xa + 1, ya ) = "k" then
            have_key = 1
          endif
          oldxs = xs : oldys = ys : oldxa = xa : oldya = ya
          m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
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
            if m$(xa - 1, ya) <> wc$ then 'There is NO wall blocking the path
              if m$(xa - 1, ya) = "t" then
                score = score + 1
              elseif m$(xa - 1, ya) = "k" then
                have_key = 1
              endif
              m$(xa - 1, ya) = "x" 
              m$(xa, ya) = " " 'Reset the former loccation of the user to empty cell 'deal with ladder
              xs = xs - 1 : xa = xa - 1 
            endif
          case "E"
            if m$(xa + 1, ya) <> wc$ then 
              if m$(xa + 1, ya) = "t" then
                score = score + 1
              elseif m$(xa + 1, ya) = "k" then
                have_key = 1
              endif
              m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
              xs = xs + 1 : xa = xa + 1
            endif
          case "N"
            if m$(xa, ya - 1) <> wc$ then 
              if m$(xa, ya - 1) = "t" then
                score = score + 1
              elseif m$(xa, ya - 1) = "k" then
                have_key = 1
              endif
              m$(xa, ya - 1) = "x" : m$(xa, ya) = " " 
              ys = ys - 1 : ya = ya - 1
            endif
          case "S"
            if m$(xa, ya + 1) <> wc$ then
              if m$(xa, ya + 1) = "t" then
                score = score + 1
              elseif m$(xa, ya + 1) = "k" then
                have_key = 1
              endif
              m$(xa, ya + 1) = "x" : m$(xa, ya) = " "
              ys = ys + 1 : ya = ya + 1
            endif
        end select
        if m$(1, 1) = " " then m$(1, 1) = "u"
        if m$(width - 4, height - 4) = " " then m$(width - 4, height - 4) = "d"
        draw_3d_maze() 
      else 'view = 2
        if m$(xa, ya - 1 ) <> wc$ then
          if m$(xa, ya - 1) = "t" then
            score = score + 1
          elseif m$(xa, ya - 1) = "k" then
            have_key = 1
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
              if m$(xa + 1, ya) = "t" then 
                score = score + 1
              elseif m$(xa + 1, ya) = "k" then
                have_key = 1
              endif
              m$(xa + 1, ya) = "x" : m$(xa, ya) = " "
              xs = xs + 1 : xa = xa + 1
            endif
          case "E"
            if m$(xa - 1, ya) <> wc$ then 
              if m$(xa - 1, ya) = "t" then
                score = score + 1
              elseif m$(xa - 1, ya) = "k" then
                have_key = 1
              endif
              m$(xa - 1, ya) = "x" : m$(xa, ya) = " "
              xs = xs - 1 : xa = xa - 1
            endif
          case "N"
            if m$(xa, ya + 1) <> wc$ then 
              if m$(xa, ya + 1) = "t" then
                score = score + 1
              elseif m$(xa, ya + 1) = "k" then
                have_key = 1
              endif
              m$(xa, ya + 1) = "x" : m$(xa, ya) = " "
              ys = ys + 1 : ya = ya + 1
            endif
          case "S"
            if m$(xa, ya - 1) <> wc$ then  
              if m$(xa, ya - 1) = "t" then
                score = score + 1
              elseif m$(xa, ya - 1) = "k" then
                have_key = 1
              endif
              m$(xa, ya - 1) = "x" : m$(xa, ya) = " "
              ys = ys - 1 : ya = ya - 1
            endif
        end select 
        if m$(1, 1) = " " then m$(1, 1) = "u"
        if m$(width - 4, height - 4) = " " then m$(width - 4, height - 4) = "d"
        draw_3d_maze() 
      else ' view = 2
        if m$(xa, ya + 1) <> wc$ then
          if m$(xa, ya + 1) = "t" then
            score = score + 1
          elseif m$(xa, ya + 1) = "k" then
            have_key = 1
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
    elseif keydown(1) = 100 then 'user presses D key to go down a floor
      if xa = width - 4 and ya = height - 4 and have_key = 1 then
        width = width + 2 : height = height + 2
        floor = floor + 1 : have_key = 0
        if floor mod 16 = 1 then fc = rgb(0, 0, 139)
        if floor mod 16 = 2 then fc = rgb(255, 14, 0)
        if floor mod 16 = 3 then fc = rgb(128, 128, 128)
        if floor mod 16 = 4 then fc = rgb(128, 0, 128)
        if floor mod 16 = 5 then fc = rgb(128, 128, 0)
        if floor mod 16 = 6 then fc = rgb(139, 69, 19)
        if floor mod 16 = 7 then fc = rgb(139, 0, 0)
        if floor mod 16 = 8 then fc = rgb(0, 100, 0)
        if floor mod 16 = 9 then fc = rgb(255, 255, 255)
        if floor mod 16 = 10 then fc = rgb(64, 224, 208)
        if floor mod 16 = 11 then fc = rgb(255, 215, 0)
        if floor mod 16 = 12 then fc = rgb(105, 105, 105)
        if floor mod 16 = 13 then fc = rgb(210, 180, 140)
        if floor mod 16 = 14 then fc = rgb(255, 10, 255)
        if floor mod 16 = 15 then fc = rgb(250, 240, 230)
        if floor mod 16 = 0 then fc = rgb(250, 128, 114)
        generate()
      endif
    endif
  loop

sub calculate 
  maxscreenx = fix((width - 1) / 100) + 1 
  maxscreeny = fix((height - 2) / 49) + 1
end sub

sub draw_2d_maze
  if screen_drawn = 0 and drawn_maze = 0 then 
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
      if yt <> ybottom or yt = 0 then 
        print 'go to the next line
      endif
    next yt

    color Yellow
    print @(9 * 8, 49 * 12) "Score =";score;
    print @(27 * 8, 49 * 12) "Floor =";floor;
    print @(39 * 8, 49 * 12) "Timer =";countdown;
    if have_key = 0 then
      print @(58 * 8, 49 * 12) "  need key";
    elseif have_key = 1 then
      print @(58 * 8, 49 * 12) "  found key";
    endif
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
    endif
    if screenx = maxscreenx and screeny = maxscreeny then
      print @((width - 4) * 8, (height - 4) * 12)"d"; 'the down ladder
    endif
    print @(16 * 8, 49 * 12) score;
    print @(34 * 8, 49 * 12) floor;
    print @(46 * 8, 49 * 12) countdown;
    if have_key = 0 then
      print @(58 * 8, 49 * 12) "  need key"; 
    elseif have_key = 1 then
      print @(58 * 8, 49 * 12) "  found key"; 
    endif
    color Indigo
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
  if m$(xt, yt) = "t" then circle 399, 525, 32
  if m$(xt, yt) = "k" then
    circle 399, 525, 16
    line 415, 525, 463, 525
    line 463, 525, 463, 541
    line 447, 525, 447, 541
  endif
  if xt < 0 then xt = 0
  if yt < 0 then yt = 0
  if m$(xt, yt) = wc$ then
    box 0, 0, 799, 599, 1, Indigo, fc
    draw$ = "N"
  else
    draw$ = "Y"
  endif  
  if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
    if m$(xt, yt) = "u" then
      duld = 0
    else 'down ladder
      ddld = 0
    endif
  endif

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
      px(0) = 0 : py(0) = 0 
      px(1) = 200 : py(1) = 150
      px(2) = 200 : py(2) = 450
      px(3) = 0 : py(3) = 599
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 799 : py(0) = 0
      px(1) = 600 : py(1) = 150
      px(2) = 600 : py(2) = 450
      px(3) = 799 : py(3) = 599
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 413, 16
    if m$(xt, yt) = "k" then
      circle 399, 413, 8
      line 407, 413, 431, 413
      line 431, 413, 431, 421
      line 423, 413, 423, 421
    endif
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 1 
      else 'down ladder
        ddld = 1 
      endif
    endif   
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then
      box 200, 150, 400, 300, 1, Indigo, fc
      draw$ = "N"
    endif
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
      box 0, 150, 200, 300, 1, Indigo, fc
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
      box 600, 150, 200, 300, 1, Indigo, fc
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
      px(0) = 200 : py(0) = 150 
      px(1) = 300 : py(1) = 225 
      px(2) = 300 : py(2) = 375 
      px(3) = 200 : py(3) = 450 
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 600 : py(0) = 150 
      px(1) = 500 : py(1) = 225
      px(2) = 500 : py(2) = 375
      px(3) = 600 : py(3) = 450 
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 356, 8
    if m$(xt, yt) = "k" then
      circle 399, 356, 4
      line 403, 356, 415, 356
      line 415, 356, 415, 360
      line 411, 356, 411, 360 
    endif
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 2 
      else 'down ladder
        ddld = 2
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then
      box 300, 225, 200, 150, 1, Indigo, fc
      draw$ = "N"
    endif
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
      box 200, 225, 100, 150, 1, Indigo, fc
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
      box 500, 225, 100, 150, 1, Indigo, fc
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
      px(0) = 300 : py(0) = 225  
      px(1) = 350 : py(1) = 262
      px(2) = 350 : py(2) = 338 
      px(3) = 300 : py(3) = 375  
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 500 : py(0) = 225 
      px(1) = 450 : py(1) = 262 
      px(2) = 450 : py(2) = 338
      px(3) = 500 : py(3) = 375  
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 328, 4
    if m$(xt, yt) = "k" then
      circle 399, 328, 2
      line 401, 328, 407, 328
      line 407, 328, 407, 330
      line 405, 328, 405, 330
    endif
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 3 
      else 'down ladder
        ddld = 3
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      box 350, 262, 100, 76, 1, Indigo, fc
    draw$ = "N" 
    endif
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
      box 300, 262, 50, 76, 1, Indigo, fc
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
      box 450, 262, 50, 76, 1, Indigo, fc
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
      px(0) = 350 : py(0) = 262  
      px(1) = 375 : py(1) = 281
      px(2) = 375 : py(2) = 319
      px(3) = 350 : py(3) = 338
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 450 : py(0) = 262 
      px(1) = 425 : py(1) = 281 
      px(2) = 425 : py(2) = 319 
      px(3) = 450 : py(3) = 338  
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 314, 2
    if m$(xt, yt) = "k" then
      circle 399, 314, 1
      line 400, 314, 403, 314
      line 403, 314, 403, 315
      line 402, 314, 402, 315
    endif
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 4 
      else 'down ladder
        ddld = 4
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      box 375, 281, 50, 38, 1, Indigo, fc
    draw$ = "N" 
    endif
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
      box 350, 281, 25, 38, 1, Indigo, fc
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
      box 425, 281, 25, 38, 1, Indigo, fc
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
      px(0) = 375 : py(0) = 281 
      px(1) = 387 : py(1) = 290 
      px(2) = 387 : py(2) = 310
      px(3) = 375 : py(3) = 319
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 425 : py(0) = 281  
      px(1) = 413 : py(1) = 290  
      px(2) = 413 : py(2) = 310  
      px(3) = 425 : py(3) = 319  
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 308, 1
    if m$(xt, yt) = "k" then line 399, 308, 400, 308
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 5
      else 'down ladder
        ddld = 5
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      box 387, 290, 26, 20, 1, Indigo, fc
      draw$ = "N" 
    endif
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
      box 375, 290, 12, 20, 1, Indigo, fc
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
      box 413, 290, 12, 20, 1, Indigo, fc
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
      px(0) = 387 : py(0) = 290  
      px(1) = 393 : py(1) = 295  
      px(2) = 393 : py(2) = 305  
      px(3) = 387 : py(3) = 310
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 413 : py(0) = 290 
      px(1) = 407 : py(1) = 295 
      px(2) = 407 : py(2) = 305
      px(3) = 413 : py(3) = 310 
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 304, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 6
      else 'down ladder
        ddld = 6
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      box 393, 295, 14, 10, 1, Indigo, fc
    draw$ = "N" 
    endif
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
      box 387, 295, 6, 10, 1, Indigo, fc
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
      box 407, 295, 6, 10, 1, Indigo, fc
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
      px(0) = 393 : py(0) = 295  
      px(1) = 396 : py(1) = 297  
      px(2) = 396 : py(2) = 303 
      px(3) = 393 : py(3) = 305 
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 407 : py(0) = 295  
      px(1) = 404 : py(1) = 297 
      px(2) = 404 : py(2) = 303
      px(3) = 407 : py(3) = 305
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 302, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 7
      else 'down ladder
        ddld = 7
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      box 396, 297, 8, 6, 1, Indigo, fc
    draw$ = "N" 
    endif
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
      box 393, 297, 3, 6, 1, Indigo, fc
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
      box 404, 297, 3, 6, 1, Indigo, fc
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
      px(0) = 396 : py(0) = 297 
      px(1) = 398 : py(1) = 299 
      px(2) = 398 : py(2) = 301
      px(3) = 396 : py(3) = 303 
      polygon 4, px(), py(), Indigo, fc
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
      px(0) = 404 : py(0) = 297  
      px(1) = 402 : py(1) = 299  
      px(2) = 402 : py(2) = 301 
      px(3) = 404 : py(3) = 303 
      polygon 4, px(), py(), Indigo, fc
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
    if m$(xt, yt) = "t" then circle 399, 301, 1
    if m$(xt, yt) = "u" or m$(xt, yt) = "d" then 
      if m$(xt, yt) = "u" then
        duld = 8
      else 'down ladder
        ddld = 8
      endif
    endif
    if xt < 0 then xt = 0
    if yt < 0 then yt = 0
    if m$(xt, yt) = wc$ then 
      box 398, 299, 4, 2, 1, Indigo, fc
      draw$ = "N" 
    endif
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
      box 396, 299, 2, 2, 1, Indigo, fc
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
      box 402, 299, 2, 2, 1, Indigo, fc
    endif
  endif

  if duld = 0 or ddld = 0 then
    line 350,  40, 350, 560, 5
    line 450,  40, 450, 560, 5
    line 350,  60, 450,  60, 5
    line 350, 140, 450, 140, 5
    line 350, 220, 450, 220, 5
    line 350, 300, 450, 300, 5
    line 350, 380, 450, 380, 5
    line 350, 460, 450, 460, 5
    line 350, 540, 450, 540, 5
    if duld = 0 then
      line 265,  40, 535,  40
      line 325, 100, 475, 100
      line 265,  40, 325, 100
      line 535,  40, 475, 100
    else 'down ladder
      if have_key = 1 then
        line 265, 560, 535, 560
        line 325, 500, 475, 500
        line 265, 560, 325, 500
        line 535, 560, 475, 500
      endif 
    endif
  endif

  if duld = 1 or ddld = 1 then
    line 375, 170, 375, 430, 3
    line 425, 170, 425, 430, 3
    line 375, 180, 425, 180, 3
    line 375, 220, 425, 220, 3
    line 375, 260, 425, 260, 3
    line 375, 300, 425, 300, 3
    line 375, 340, 425, 340, 3
    line 375, 380, 425, 380, 3
    line 375, 420, 425, 420, 3
    if duld = 1 then
      line 340, 170, 460, 170 
      line 380, 200, 420, 200 
      line 340, 170, 380, 200 
      line 460, 170, 420, 200 
    else 'down ladder
      if have_key = 1 then
        line 340, 430, 460, 430 
        line 380, 400, 425, 400 
        line 340, 430, 380, 400 
        line 460, 430, 425, 400
      endif 
    endif
  endif

  if duld = 2 or ddld = 2 then
    line 387, 240, 387, 360, 2
    line 413, 240, 413, 360, 2
    line 387, 243, 413, 243, 2
    line 387, 262, 413, 262, 2
    line 387, 281, 413, 281, 2
    line 387, 300, 413, 300, 2
    line 387, 319, 413, 319, 2
    line 387, 338, 413, 338, 2
    line 387, 357, 413, 357, 2
    if duld = 2 then
      line 390, 253, 410, 253  
      line 367, 238, 433, 238 
      line 390, 253, 367, 238 
      line 410, 253, 433, 238 
    else 'down ladder
      if have_key = 1 then
        line 390, 347, 410, 347 
        line 370, 360, 430, 360 
        line 390, 347, 370, 360 
        line 410, 347, 430, 360 
      endif
    endif
  endif

  if duld = 3 or ddld = 3 then 
    line 393, 270, 393, 330
    line 407, 270, 407, 330
    line 393, 272, 407, 272
    line 393, 281, 407, 281
    line 393, 290, 407, 290
    line 393, 299, 407, 299
    line 393, 308, 407, 308
    line 393, 318, 407, 318
    line 393, 328, 407, 328
    if duld = 3 then
      line 395, 277, 405, 277   
      line 384, 270, 416, 270 
      line 395, 277, 384, 270 
      line 405, 277, 416, 270 
    else 'down ladder
      if have_key = 1 then
        line 395, 323, 405, 323 
        line 384, 330, 416, 330 
        line 395, 323, 384, 330 
        line 405, 323, 416, 330 
      endif
    endif
  endif

  if duld = 4 or ddld = 4 then 
    line 396, 285, 396, 315
    line 404, 285, 404, 315
    line 396, 286, 404, 286
    line 396, 291, 404, 291
    line 396, 296, 404, 296
    line 396, 301, 404, 301
    line 396, 306, 404, 306
    line 396, 310, 404, 310
    line 396, 314, 404, 314
    if duld = 4 then
      line 392, 284, 408, 284    
      line 397, 288, 403, 288 
      line 392, 284, 397, 288 
      line 408, 284, 403, 288 
    else 'down ladder
      if have_key = 1 then
        line 392, 316, 408, 316 
        line 397, 312, 403, 312 
        line 392, 316, 397, 312 
        line 408, 316, 403, 312 
      endif
    endif
  endif

  if duld = 5 or ddld = 5 then 
    line 398, 292, 398, 308
    line 402, 292, 402, 308
    line 398, 292, 402, 292
    line 398, 295, 402, 295
    line 398, 297, 402, 297
    line 398, 300, 402, 300
    line 398, 302, 402, 302
    line 398, 305, 402, 305
    line 398, 308, 402, 308
    if duld = 5 then
      line 398, 292, 402, 292     
      line 396, 290, 404, 290 
      line 398, 292, 396, 290 
      line 402, 292, 404, 290 
    else 'down ladder
      if have_key = 1 then
        line 396, 308, 404, 308 
        line 398, 310, 402, 310 
        line 396, 308, 398, 310 
        line 404, 308, 402, 310 
      endif
    endif
  endif

  if duld = 6 or ddld = 6 then 
    line 399, 296, 399, 304
    line 401, 296, 401, 304
    line 399, 296, 401, 296
    line 399, 297, 401, 297
    line 399, 299, 401, 299
    line 399, 300, 401, 300
    line 399, 302, 401, 302
    line 399, 303, 401, 303
    line 399, 304, 401, 304
    if duld = 6 then
      line 398, 296, 402, 296     
      line 399, 297, 401, 297 
      line 398, 296, 399, 297 
      line 402, 296, 401, 297 
    else 'down ladder
      if have_key = 1 then
        line 398, 304, 402, 304 
        line 399, 305, 401, 305 
        line 398, 304, 399, 305 
        line 402, 304, 401, 305 
      endif
    endif
  endif

  if duld = 7 or ddld = 7 then 
    line 399, 298, 399, 302
    line 400, 298, 400, 302
    line 399, 298, 400, 298
    line 399, 299, 400, 299
    line 399, 299, 400, 299
    line 399, 300, 400, 300
    line 399, 300, 400, 300
    line 399, 301, 400, 301
    line 399, 302, 400, 302
    if duld = 7 then
      line 399, 297, 401, 297     
      line 400, 299, 400, 300 
      line 399, 296, 400, 299 
      line 401, 296, 400, 300 
    else 'down ladder
      if have_key = 1 then
        line 399, 304, 401, 304 
        line 400, 305, 400, 305 
        line 399, 304, 400, 305 
        line 401, 304, 400, 305 
      endif
    endif
  endif

  if duld = 8 or ddld = 8 then 
    line 399, 299, 399, 300
    line 400, 299, 400, 300
    line 399, 299, 400, 299
    line 399, 299, 400, 299
    line 399, 299, 400, 299
    line 399, 300, 400, 300
    line 399, 300, 400, 300
    line 399, 300, 400, 300
    line 399, 300, 400, 300
    if duld = 8 then
      line 399, 299, 400, 299     
      line 400, 300, 400, 300 
      line 399, 299, 400, 300 
      line 400, 299, 400, 300 
    else 'down ladder
      if have_key = 1 then
        line 399, 302, 400, 302 
        line 400, 303, 400, 303 
        line 399, 302, 400, 303 
        line 400, 302, 400, 303 
      endif
    endif
  endif

  duld = 99 : ddld = 99
  print @(399, 12) ch$;space$(7)"S=";score;"  F=";floor;"  T=";countdown;
  if have_key = 0 then
    print @(679, 12) "need key";
  elseif have_key = 1 then
    print @(670, 12) "found key";
  endif
  pause 200
end sub

