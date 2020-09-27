'Chess adapted from QuickBasic tutorial by Dean Menezes
#include "colors.inc"
dim integer board(8, 8) 'board(7, 7)
dim integer besta(7), bestb(7), bestx(7), besty(7) 'List of best moes
dim integer level, maxlevel, score, cflag, icolor 'BAR added icolor which was colour in code
dim integer a, b, k, x, y, z, result, ndx, id, prune, piece, mover
dim xx(28), yy(28) 'xx(27), yy(27)
cflag = 0 : level = 0 : maxlevel = 5

'Fill the starting position into the board array
data -500, -270, -300, -900, -7500, -300, -270, -500
data -100, -100, -100, -100,  -100, -100, -100, -100
data    0,    0,    0,    0,     0,    0,    0,    0
data    0,    0,    0,    0,     0,    0,    0,    0
data    0,    0,    0,    0,     0,    0,    0,    0
data    0,    0,    0,    0,     0,    0,    0,    0
data  100,  100,  100,  100,   100,  100,  100,  100
data  500,  270,  300,  900,  5000,  300,  270,  500
for x = 0 to 7
  for y = 0 to 7
    read z : board(x, y) = z
  next y
next x
a = -1 : result = 0

do
  score = 0 : io(a, b, x, y, result) 'Get white's move
  cls : showbd 'Update board to show white's move
  result = evaluate(-1, 10000) 'Get black's move
  a = besta(1) 'start column for black's move
  b = bestb(1) 'start row for black's move
  x = bestx(1) 'end column for black's move
  y = besty(1) 'end row for black's move
loop

function evaluate(id, prune)
  'dim xx(26), yy(26)
  level = level + 1 'Update recursion level
  bestscore = 10000 * id
  for b = 7 to 0 step -1 'loop through each square
    for a = 7 to 0 step -1
      'if sgn(board(b, a)) <> id then goto line1 'if the square does not have right color piece, go to next square
      'if sgn(board(b, a)) = id then
        if level = 1 then showman(a, b, 8) 'show the move currently trying
        movelist(a, b, xx(), yy(), ndx) 'Get list of moves for current piece
        for i = 0 to ndx 'loop through each possible move
          x = xx(i) : y = yy(i)
          if level = 1 then
            'locate 1, 1
            text 8, 12, "trying: ",,,, White, Black '; chr$(65 + a); 8 - b; "-"; chr$(65 + x); 8 - y,,,, White, Black 
            'print "trying: "; chr$(65 + a); 8 - b; "-"; chr$(65 + x); 8 - y 'show move currently trying
            showman(x, y, 8)
          endif
          oldscore = score : mover = board(b, a) : target = board(y, x) 'store these locations so we can set the move back
          makemove(a, b, x, y) 'make the move so we can evaluate
          if level < maxlevel then 
            score = score + evaluate(-id, bestscore - target + id * (8 - abs(4 - x) - abs(4 - y)))
          endif
          score = score + target - id * (8 - abs(4 - x) - abs(r - y)) 'work out score for move
          if (id < 0 and score > bestscore) or (id > 0 and score < bestscore) then 'update current best score
            besta(level) = a : bestb(level) = b : bestx(level) = x : besty(level) = y
            bestscore = score
            if (id < 0 and bestscore >= prune) or (id > 0 and bestscore <= prune) then 'prune to avoid wasting time
              board(b, a) = mover 'reset position back to before modified
              board(y, x) = target
              score = oldscore
              if level = 1 then showman(x, y, 0) 'show move currently trying
              if level = 1 then showman(a, b, 0) 'show move currently trying
              level = level - 1 'update recursion level
              evaluate = bestscore 'return
              exit function
            endif
          endif
          '? b, a 'BAR debugging
          if b < 0 then b = 0 'BAR added
          if a < 0 then a = 0 'BAR added
          board(b, a) = mover 'reset position back to before modified
          board(y, x) = target : score = oldscore
          if level = 1 then showman(x, y, 0) 'show move currently trying
        next i
      endif
      if level = 1 then showman(a, b, 0) 'show move currently trying
    next a
  next b
  level = level - 1 'update recursion level
  evaluate = bestscore 'return
end function

'This geneates a list of moves
sub movelist (a, b, xx(), yy(), ndx)
  piece = int(abs(board(b, a))) 'get value corresponding to piece
  ndx = -1
  if piece = 100 then 
    pawn(a, b, xx(), yy(), ndx) 'call proper move listing routine depending on piece
  elseif piece = 270 then
    knight(a, b, xx(), yy(), ndx)
  elseif piece = 300 then
    bishop(a, b, xx(), yy(), ndx)
  elseif piece = 500 then
    rook(a, b, xx(), yy(), ndx)
  elseif piece = 900 then
    queen(a, b, xx(), yy(), ndx)
  else
    king(a, b, xx(), yy(), ndx)
  endif
end sub

'This is the move-list generator for the pawn
sub pawn(a, b, xx(), yy(), ndx)
  id = sgn(board(b, a)) 'get color
  if a - 1 >= 0 and a - 1 <= 7 and b - id >= 0 and b - id <= 7 then 'capture
    if sgn(board((b - id), (a - 1))) = -id then 'make sure there is piece to capture
      ndx = ndx + 1 : xx(ndx) = a - 1 : yy(ndx) = b - id
    endif
  endif
  if a + 1 >= 0 and a + 1 <= 7 and b - id >= 0 and b - id <= 7 then 'capture
    if sgn(board((b - id), (a + 1))) = -id then 'make sure there is piece to capture
      ndx = ndx + 1 : xx(ndx) = a + 1 : yy(ndx) = b - id
    endif
  endif
  if a >= 0 and a <= 7 and b - id >= 0 and b - id <= 7 then 'one square forward
    if board((b - id), a) = 0 then 'make sure square is empty
      ndx = ndx + 1 : xx(ndx) = a : yy(ndx) = b - id
      if (id < 0 and b = 1) or (id > 0 and b = 6) then '2 squares forward
        if board((b - id - id), a) = 0 then 'make sure square is empty
          ndx = ndx + 1 : xx(ndx) = a : yy(ndx) = b - 2 * id
        endif
      endif
    endif
  endif
end sub

'move list generator for knight
sub knight(a, b, xx(), yy(), ndx)
  id = sgn(board(b, a)) 'get color (white side or black side)
  x = a - 1 : y = b - 2 : gosub 5
  x = a - 2 : y = b - 1 : gosub 5
  x = a + 1 : y = b - 2 : gosub 5
  x = a + 2 : y = b - 1 : gosub 5
  x = a - 1 : y = b + 2 : gosub 5
  x = a - 2 : y = b + 1 : gosub 5
  x = a + 1 : y = b + 2 : gosub 5
  x = a + 2 : y = b + 1 : gosub 5
  exit sub
5:
  if x < 0 or x > 7 or y < 0 or y > 7 then return 'make sure on board
    if id <> sgn(board(y, x)) then
      '? ndx, x, y 'BAR debugging
      if ndx < 27 then 'BAR added
        ndx = ndx + 1 : xx(ndx) = x: yy(ndx) = y 'make sure no piece of same color
      endif 'BAR added
    endif
    return
end sub

'generation for bishop
sub bishop(a, b, xx(), yy(), ndx)
  id = sgn(board(b, a))
  for dxy = 1 to 7 'work out diagonally one direction
    x = a - dxy : y = b + dxy
    if x < 0 or x > 7 or y < 0 or y > 7 then exit for 'stop when go off board
    gosub 3
    if board(y, x) then exit for 'stop when hit piece
  next
  for dxy = 1 to 7
    x = a + dxy : y = b + dxy
    if x < 0 or x > 7 or y < 0 or y > 7 then exit for
    gosub 3
    if board(y, x) then exit for
    gosub 3
    if board(y, x) then exit for
  next
  for dxy = 1 to 7
    x = a - dxy : y = b - dxy
    if x < 0 or x > 7 or y < 0 or y > 7 then exit for
    gosub 3
    if board(y, x) then exit for
  next
  for dxy = 1 to 7
    x = a + dxy : y = b - dxy
    if x < 0 or x > 7 or y < 0 or y > 7 then exit for
    gosub 3
    if board(y, x) then exit for
  next
  exit sub
3:
  if id <> sgn(board(y, x)) then 'make sure no piece of same color
    '? ndx, x, y 'BAR debugging
    if ndx < 27 then 'BAR added
       ndx = ndx + 1 : xx(ndx) = x : yy(ndx) = y 'receiving index out of BOUNDS
    endif 'BAR added
  endif
  return
end sub
  
'generation for rook
sub rook(a, b, xx(), yy(), ndx)
  id = sgn(board(b, a))
  for x = a - 1 to 0 step -1 'work out vertical/horizontal for each direction
    if id <> sgn(board(b, x)) then 'make sure no piece of same color
      ndx = ndx + 1 : xx(ndx) = x : yy(ndx) = b
    endif
    if (board(b, x)) then exit for
  next
  for x = a + 1 to 7 step 1
    if id <> sgn(board(b, x)) then
      ndx = ndx + 1 : xx(ndx) = x : yy(ndx) = b
    endif
  next
  for y = b - 1 to 0 step -1
    if id <> sgn(board(y, a)) then
      ndx = ndx + 1 : xx(ndx) = a : yy(ndx) = y
    endif
    if (board(y, a)) then exit for
  next
  for y = b + 1 to 7 step 1
    if id <> sgn(board(y, a)) then
      ndx = ndx + 1 : xx(ndx) = a : yy(ndx) = y
    endif
    if (board(y, a)) then exit for
  next
end sub

'generation for queen
sub queen(a, b, xx(), yy(), ndx)
  bishop(a, b, xx(), yy(), ndx) 'queen's move = bishop + rook
  rook(a, b, xx(), yy(), ndx)
end sub

'generation for king
sub king(a, b, xx(), yy(), ndx)
  id = sgn(board(b, a))
  for dy = -1 to 1 'go through each of 8 king moves, checking for same color and off bord
    if b + dy < 0 or b + dy > 7 then goto 12
    for dx = -1 to 1
      if a + dx < 0 or a + dx > 7 then goto 11
      if id <> sgn(board(b + dy, a + dx)) then
        ndx = ndx + 1
        xx(ndx) = a + dx
        yy(ndx) = b + dy
      endif
11:
    next
12:
  next
end sub

function incheck(x)
  'dim xx(27), yy(27), ndx
  for b = 0 to 7
    for a = 0 to 7
      if board(b, a) >= 0 then goto 6
      movelist(a, b, xx(), yy(), ndx)
      for i = 0 to ndx step 1
        x = xx(i) : y = yy(i)
        if board(y, x) = 5000 then
          print "You are in check!" : ?" " : ?" " : incheck = 1
          exit function
        endif
      next
6:
    next
  next
  incheck = 0
end function

'routine to make a move on the chessboard
sub makemove(a, b, x, y)
  board(y, x) = board(b, a) 'the piece moves to the target square
  board(b, a) = 0 'the old square is now empty
  if y = 0 and board(y, x) = 100 then board(y, x) = 900 'simple pawn promotion routine
  if y = 7 and board(y, x) = -100 then board(y, x) = -900
end sub

'routine to get player move
sub io(a, b, x, y, result)
  'dim xx(26), yy(26)
  cls
  if a >= 0 then
    if result < -2500 then
      print "I resign" 'Do something additional here?
    endif
    piece = board(y, x)
    makemove(a, b, x, y)
    print "My move: "; chr$(65 + a); 8 - b; "-"; chr$(65 + x); 8 - y 'show computer move
    if piece then
      print "I took your ";
      if piece = 100 then print "pawn"
      if piece = 270 then print "knight"
      if piece = 300 then print "bishop"
      if piece = 500 then print "rook"
      if piece = 900 then print "queen"
      if piece = 5000 then print "king"
    endif
    null = incheck(0)
  endif
  do
    showbd 
    'locate 24, 1
    text 8, 288, ""
    input "Your move (ex: E2-E4): ", in$
    if ucase$(in$) = "QUIT" then cls : end
    if ucase$(in$) = "O-O" or in$ = "0-0" then
      if cflag then goto 16
      if board(7, 7) <> 500 then goto 16
      if board(7, 6) or board(7, 5) then goto 16
      board(7, 6) = 5000 : board(7, 4) = 0 : board(7, 5) = 500 : board(7, 7) = 0 : cflag = 1
      exit sub
    endif
    if ucase$(in$) = "O-O-O" or in$ = "0-0-0" then
      if cflag then goto 16
      if board(7, 0) <> 500 then goto 16
      if board(7, 1) or board(7, 2) or board(7, 3) then goto 16
      board(7, 2) = 5000 : board(7, 4) = 0 : board(7, 3) = 500 : board(7, 0) = 0 : cflag = 1
      exit sub
    endif
    if len(in$) < 5 then goto 16
    b = 8 - (asc(mid$(in$, 2, 1)) - 48)
    a = asc(ucase$(mid$(in$, 1, 1))) - 65
    x = asc(ucase$(mid$(in$, 4, 1))) - 65
    y = 8 - (asc(mid$(in$, 5, 1)) - 48)
    if b > 7 or b < 0 or a > 7 or a < 0 or x > 7 or x < 0 or y > 7 or y < 0 then goto 16
    if board(b, a) <= 0 then goto 16
    if board(b, a) <= 0 then goto 16
    movelist(a, b, xx(), yy(), ndx)
    for k = 0 to ndx step 1 'validate move
      if x = xx(k) and y = yy(k) then
        mover = board(b, a) : target = board(y, x) : makemove(a, b, x, y)
        'locate 1, 1
        text 8, 12, ""
        if incheck(0) = 0 then exit sub 'make sure move out of check
        board(b, a) = mover 'if not move out of check, reset board
        board(y, x) = target
        goto 16
      endif
    next
16:
    cls
  loop
end sub

'show board
sub showbd
  'locate 3, 30 : color 7, 0 : print"A  B  C  D  E  F  G  H"
  text 240, 36, "A  B  C  D  E  F  G  H",,,, White, Black
  for k = 0 to 25
    'locate 4, 28 + k : color 6, 0 : print chr$(220)
    text (28 + k) * 8, 48, chr$(220),,,, Yellow, Black
  next
  for b = 0 to 7
    'locate 2 * b + 5, 26 : color 7, 0 : print chr$(56 - b)  
    text 208, (2 * b + 6) * 12, chr$(56 - b),,,, White, Black 'These are numbers 1-8 
    'locate 2 * b + 5, 28 : color 6, 0 : print chr$(219)
    text 224, (2 * b + 5) * 12, chr$(219),,,, Yellow, Black 
    'locate 2 * b + 6, 28 : color 6, 0 : print chr$(219)
    text 224, (2 * b + 6) * 12, chr$(219),,,, Yellow, Black 
    for a = 0 to 7
      if ((a + b) mod 2) then
        icolor = 8 'Gray
      else
        icolor = 12 'Tomato
      endif
      square(3 * a + 31, 2 * b + 5, icolor)
    next
    'locate 2 * b + 5, 53 : color 6, 0 : print chr$(219)
    text 424, (2 * b + 5) * 12, chr$(219),,,, Yellow, Black 
    'locate 2 * b + 6, 53 : color 6, 0 : print chr$(219)
    text 424, (2 * b + 6) * 12, chr$(219),,,, Yellow, Black 
    'locate 2 * b + 6, 55 : color 7, 0 : print chr$(56 - b)
    text 440, (2 * b + 6) * 12, chr$(56 - b),,,, White, Black 'These are numbers 1-8
  next
  for k = 0 to 25
    'locate 21, 28 + k : color 6, 0 : print chr$(223)
    text (28 + k) * 8, 252, chr$(223),,,, Yellow, Black
  next
  'locate 22, 30 : color 7, 0 : print "A  B  C  D  E  F  G  H"
  text 240, 264, "A  B  C  D  E  F  G  H",,,, White, Black
  for b = 0 to 7
    for a = 0 to 7
      showman(a, b, 0)
    next
  next
  color Green, Black 
end sub

'show piece
sub showman(a, b, flag) 'flag seems to be either 0 or 8
  if board(b, a) < 0 then back = 0
  if board(b, a) > 0 then back = 7
  fore = 7 - back + flag
  if board(b, a) = 0 then
    if (a + b) and 1 then back = 8 else back = 12
    fore = back + -1 * (flag > 0)
  end if
  piece = int(abs(board(b, a)))
  if piece = 0 then n$ = chr$(219)
  if piece = 100 then n$ = "P"
  if piece = 270 then n$ = "N"
  if piece = 300 then n$ = "B"
  if piece = 500 then n$ = "R"
  if piece = 900 then n$ = "Q"
  if piece = 5000 or piece = 7500 then n$ = "K"
  'locate 2 * b + 5 - (board(b, a) > 0), 3 * a + 30 : color fore, back, print n$
  if back = 0 then 
    if fore = 7 then
      text (3 * a + 30) * 8, (2 * b + 6 - (board(b, a) > 0)) * 12, n$,,,, White, Black 'Black pieces
    elseif fore = 15 then
      text (3 * a + 30) * 8, (2 * b + 6 - (board(b, a) > 0)) * 12, n$,,,, LightGray, Black
    endif
  elseif back = 7 then
    if fore = 0 then
      text (3 * a + 30) * 8, (2 * b + 7 - (board(b, a) > 0)) * 12, n$,,,, Black, White 'White pieces
    elseif fore = 8 then
      text (3 * a + 30) * 8, (2 * b + 7 - (board(b, a) > 0)) * 12, n$,,,, Gray, White      
    endif
  elseif back = 8 then
    if fore = 0 then 
      text (3 * a + 30) * 8, (2 * b + 6 - (board(b, a) > 0)) * 12, n$,,,, Black, Gray 'good, empty squares
    elseif fore = 7 then
      text (3 * a + 30) * 8, (2 * b + 6 - (board(b, a) > 0)) * 12, n$,,,, White, Gray     
    endif
  elseif back = 12 then
    if fore = 0 then
      text (3 * a + 30) * 8, (2 * b + 6 - (board(b, a) > 0)) * 12, n$,,,, Black, Tomato 'good, empty squares
    elseif fore = 11 then
      text (3 * a + 30) * 8, (2 * b + 6 - (board(b, a) > 0)) * 12, n$,,,, LightCyan, Tomato
    endif
  endif
  'locate 1, 1 : color 7, 0
  text 8, 12, n$,,,, Green, Black 
end sub

'Display a square
sub square(a, b, c) 'c will either equate to 8 = Gray or 12 = Tomato
  mt$ = chr$(219) : mt$ = mt$ + mt$ + mt$
  if c = 8 then
    text (a - 2) * 8, b * 12, mt$,,,, Gray, Gray 
    text (a - 2) * 8, (b + 1) * 12, mt$,,,, Gray, Gray
  elseif c = 12 then
    text (a - 2) * 8, b * 12, mt$,,,, Tomato, Tomato  
    text (a - 2) * 8, (b + 1) * 12, mt$,,,, Tomato, Tomato
  endif
  color White, Black 
end sub

'List of Quickbasic colors
' 0 = Black, 1 = Blue, 2 = Green, 3 = Cyan, 4 = Red, 5 = Purple, 6 = Brown/Orange, 
' 7 = White, 8 = Gray, 9 = Light Blue, 10 = Light Green, 11 = Light Cyan,
'12 = Tomato, 13 = Light Purple, 14 = Yellow/Light Orange, 15 = LightGray










































































































