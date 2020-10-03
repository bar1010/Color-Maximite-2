'Test scrolling demo
dim string m$(302, 152) length 1 'Three screens wide by three screens high
dim integer i, j, x, y, xt, yt, xn, yn, oldx, oldy, screen
cls : mode 1, 8 : color rgb(green)
x = 5 : y = 5 : oldx = 5 : oldy = 5 : screen = 1

'Fill array
for i = 0 to 300
  for j = 0 to 150
    if i = 50 and j = 25 then
      m$(i, j) = "1" : xn = i : yn = j
    elseif i = 150 and j = 25 then
      m$(i, j) = "2" : xn = i : yn = j
    elseif i = 250 and j = 25 then
      m$(i, j) = "3" : xn = i : yn = j 
    elseif i = 50 and j = 75 then
      m$(i, j) = "4" : xn = i : yn = j
    elseif i = 150 and j = 75 then
      m$(i, j) = "5" : xn = i : yn = j
    elseif i = 250 and j = 75 then
      m$(i, j) = "6" : xn = i : yn = j
    elseif i = 50 and j = 125 then
      m$(i, j) = "7" : xn = i : yn = j
    elseif i = 150 and j = 125 then
      m$(i, j) = "8" : xn = i : yn = j
    elseif i = 250 and j = 125 then
      m$(i, j) = "9" : xn = i : yn = j
    elseif i = 5 and j = 5 then
      m$(i, j) = "X" 'the user
    else
      m$(i, j) = " "
    endif
  next j
next i

'Print first screen worth of the array.  There are 9 screens total.
for j = 0 to 49
  for i = 0 to 99
    if m$(i, j) <> " " then
      print @(i * 8, j * 12) m$(i, j);
    endif
  next i
next j

detect()

'User controls an X character on screen.
sub detect
  do
    if keydown(1) = 128 and y > 0 then 'up
      if m$(x, y - 1) = " " then 
        oldx = x : oldy = y
        m$(x, y - 1) = "X"   'draw new X location
        m$(oldx, oldy) = " " 'remove old X location
        y = y - 1 'x, y is the user's new location
        if y = 49 or y = 99 then  
          screen = screen - 3
          offset() 
        endif
        show()
      endif
    elseif keydown(1) = 129 and y < 149 then 'down
      if m$(x, y + 1) = " " then
        oldx = x : oldy = y 
        m$(x, y + 1) = "X"
        m$(oldx, oldy) = " "
        y = y + 1
        if y = 50 or y = 100 then  
          screen = screen + 3
          offset() 
        endif
        show()
      endif
    elseif keydown(1) = 130 and x > 0 then 'left
      if m$(x - 1, y) = " " then
        oldx = x : oldy = y
        m$(x - 1, y) = "X"
        m$(oldx, oldy) = " "
        x = x - 1
        if x = 99 or x = 199 then  
          screen = screen - 1 
          offset()
        endif
        show()
      endif
    elseif keydown(1) = 131 and x < 299 then 'right
      if m$(x + 1, y) = " " then
        oldx = x : oldy = y
        m$(x + 1, y) = "X"
        m$(oldx, oldy) = " "
        x = x + 1
        if x = 100 or x = 200 then  
          screen = screen + 1 
          offset() 
        endif
        show()
      endif
    endif
  loop
end sub

sub offset
  select case screen
    case 1
      xt = 0 : yt = 0
    case 2
      xt = 100 : yt = 0
    case 3
      xt = 200 : yt = 0
    case 4
      xt = 0 : yt = 50
    case 5
      xt = 100 : yt = 50
    case 6
      xt = 200 : yt = 50
    case 7
      xt = 0 : yt = 100 
    case 8
      xt = 100 : yt = 100
    case 9
      xt = 200 : yt = 100
  end select
end sub

sub show 
  cls
  print @((x - xt) * 8, (y - yt) * 12) "X"; 'print the X character
  print @(50 * 8, 25 * 12) screen 'print the number character  
  pause 27
end sub




























