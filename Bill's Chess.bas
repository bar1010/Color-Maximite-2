'Bill's Chess
option base 1
dim integer hs, he 'horizotal start file, horizonal end file
dim integer i, j, k, l, m, x, y, board(8, 8), oboard(8, 8) 'board position before the current move
dim integer check, checkmate, draw, max_moves, half_moves, legal, pc 'piece/color
dim integer wkm, bkm, a1m, h1m, a8m, h8m 'white king moved, black king moved, rook has moved
dim integer wc, bc 'white king in check, black king in check
dim integer m1, m2, m3, m4 'the first, second, third, and fourth characters/digits of the move
dim string move$ length 5, whos_move$ length 1, sm$ length 4 'special move
dim string movelist$(999) length 5, move_history(9999) length 5, m5$ length 1

'Initial position
board(1, 1) = 4 : board(2, 1) = 2 : board(3, 1) = 3 : board(4, 1) = 5
board(5, 1) = 6 : board(6, 1) = 3 : board(7, 1) = 2 : board(8, 1) = 4
for i = 1 to 8
  board(i, 2) = 1
  board(i, 3) = 0
  board(i, 4) = 0
  board(i, 5) = 0
  board(i, 6) = 0
  board(i, 7) = -1
next i 
board(1, 8) = -4 : board(2, 8) = -2 : board(3, 8) = -3 : board(4, 8) = -5
board(5, 8) = -6 : board(6, 8) = -3 : board(7, 8) = -2 : board(8, 8) = -4

cls : mode 1, 16                       
color rgb(yellow), rgb(black)
load font "DiagramTTHabsburg72.fnt"
whos_move$ = "W" : sm$ = "" : check = 0 : checkmate = 0 : draw = 0
num_moves = 20 : half_moves = 0 : legal = 1 : m = 0 : wkm = 0 : bkm = 0
a1m = 0 : h1m = 0 : a8m = 0 : h8m = 0
print_board()

do
  get_move() 
  for i = 1 to 999
    movelist$(i) = ""
  next i
  half_moves = half_moves + 1
  move_history(half_moves) = move$
  sm$ = "" : check = 0 : max_moves = 0 : move$ = "" : m = 0
loop

sub get_move
  font 1 : color rgb(green), rgb(black)
  if whos_move$ = "W" then
    print @(0, 12) "White: "
  else 
    print @(0, 12) "Black: "
  endif
  input move$
  m1 = fton(left$(move$, 1)) 
  m2 = val(mid$(move$, 2, 1))
  m3 = fton(mid$(move$, 3, 1))
  m4 = val(mid$(move$, 4, 1))
  m5$ = mid$(move$, 5, 1))

  for i = 1 to 8
    for j = 1 to 8
      oboard(i, j) = board(i, j)
    next j
  next i

  'castle kingside
  if move$ = "e1g1" then sm$ = "WCK"  
  if move$ = "e8g8" then sm$ = "BCK"
  
  'castle queenside
  if move$ = "e1c1" then sm$ = "WCQ"
  if move$ = "e8c8" then sm$ = "BCQ"

  'en passant
  'if something then sm$ = "WEP"
  'if something then sm$ = "BEP"

  'promotion
  if m5$ = "q" and whos_move$ = "W" then sm$ = "WPQ"
  if m5$ = "r" and whos_move$ = "W" then sm$ = "WPR"
  if m5$ = "b" and whos_move$ = "W" then sm$ = "WPB"
  if m5$ = "n" and whos_move$ = "W" then sm$ = "WPN"
  if m5$ = "q" and whos_move$ = "B" then sm$ = "BPQ"
  if m5$ = "r" and whos_move$ = "B" then sm$ = "BPR"
  if m5$ = "b" and whos_move$ = "B" then sm$ = "BPB"
  if m5$ = "n" and whos_move$ = "B" then sm$ = "BPN"

  board(m1, m2) = 0  
  board(m3, m4) = oboard(m1, m2)

  if sm$ = "WCK" then
    board(8, 1) = 0
    board(6, 1) = 4    
  elseif sm$ = "WCQ" then
    board(1, 1) = 0
    board(4, 1) = 4
  elseif sm$ = "BCK" then
    board(8, 8) = 0
    board(6, 8) = -4
  elseif sm$ = "BCQ" then
    board(1, 8) = 0
    board(4, 8) = -4
  elseif sm$ = "WPQ" then
    board(m3, 8) = 5
  elseif sm$ = "WPR" then
    board(m3, 8) = 4
  elseif sm$ = "WPB" then
    board(m3, 8) = 3
  elseif sm$ = "WPN" then
    board(m3, 8) = 2
  elseif sm$ = "BPQ" then
    board(m3, 1) = -5
  elseif sm$ = "BPR" then
    board(m3, 1) = -4
  elseif sm$ = "BPB" then
    board(m3, 1) = -3
  elseif sm$ = "BPN" then
    board(m3, 1) = -2
  endif

  print_board()

  if whos_move$ = "W" then
    whos_move$ = "B"
  else
    whos_move$ = "W"
  endif

  sm$ = ""
end sub

sub print_board
  cls
  font 8
  load png "../chess boards/600p_green_vinyl_coordinates_605x600.png", 97, 0

  for i = 1 to 8
    for j = 1 to 8
      select case i
        case 1 'A
          x = 133
        case 2 'B
          x = 200
        case 3 'C
          x = 267
        case 4 'D
          x = 334
        case 5 'E
          x = 402
        case 6 'F
          x = 469
        case 7 'G
          x = 535
        case 8 'H
          x = 603
      end select
      select case j
        case 1
          y = 500
        case 2
          y = 435
        case 3
          y = 368
        case 4
          y = 301
        case 5
          y = 233
        case 6
          y = 166
        case 7
          y = 100
        case 8
          y = 31
      end select
      select case board(i, j)
        case 1
          color rgb(yellow), rgb(white)  
          print @(x, y, 5) chr$(112);
        case 2
          color rgb(yellow), rgb(white)
          print @(x, y, 5) chr$(110);
        case 3
          color rgb(yellow), rgb(white)
          print @(x, y, 5) chr$(108);
        case 4
          color rgb(yellow), rgb(white)
          print @(x, y, 5) chr$(114);
        case 5
          color rgb(yellow), rgb(white)
          print @(x, y, 5) chr$(113);
        case 6
          color rgb(yellow), rgb(white)
          print @(x, y, 5) chr$(107);
        case -1
          color rgb(yellow), rgb(black)
          print @(x, y, 5) chr$(112);
        case -2
          color rgb(yellow), rgb(black)
          print @(x, y, 5) chr$(110);
        case -3
          color rgb(yellow), rgb(black)
          print @(x, y, 5) chr$(108);
        case -4
          color rgb(yellow), rgb(black)
          print @(x, y, 5) chr$(114);
        case -5
          color rgb(yellow), rgb(black)
          print @(x, y, 5) chr$(113);
        case -6
          color rgb(yellow), rgb(black)
          print @(x, y, 5) chr$(107);
      end select
    next j
  next i    
end sub

sub determine_legality
  legal = 1
  if len(move$) < 4 or len(move$) > 5 then legal = 0 : exit sub
  if m1 <> 1 and m1 <> 2 and m1 <> 3 and m1 <> 4 and m1 <> 5 and m1 <> 6 and m1 <> 7 and m1 <> 8 then 
    legal = 0 : exit sub
  endif
  if m2 <> 1 and m2 <> 2 and m2 <> 3 and m2 <> 4 and m2 <> 5 and m2 <> 6 and m2 <> 7 and m2 <> 8 then 
    legal = 0 : exit sub
  endif
  if m3 <> 1 and m3 <> 2 and m3 <> 3 and m3 <> 4 and m3 <> 5 and m3 <> 6 and m3 <> 7 and m3 <> 8 then 
    legal = 0 : exit sub
  endif
  if m4 <> 1 and m4 <> 2 and m4 <> 3 and m4 <> 4 and m4 <> 5 and m4 <> 6 and m4 <> 7 and m4 <> 8 then
    legal = 0 : exit sub
  end if
  if m5$ <> "q" and m5$ <> "r" and m5$ <> "b" and m5$ <> "n" then
    legal = 0 : exit sub
  end if
  if board(m1, m2) = 0 then 
    legal = 0 : exit sub
  endif
  if whos_move = "W" and board(m1, m2) < 0 then
    legal = 0 : exit sub
  endif
  if whos_move = "B" and board(m1, m2) > 0 then
    legal = 0 : exit sub
  endif
  if whos_move = "W" and board(m3, m4) > 0 then 
    legal = 0 : exit sub
  endif
  if whos_move = "B" and board(m3, m4) < 0 then
    legal = 0 : exit sub
  endif  
  if abs(board(m3, m4)) = 6 then 'cannot capture king
    legal = 0 : exit sub
  endif
  if not noc() then legal = 0 'making the move would put one's king in check
  if abs(board(m1, m2)) = 1 then 'white or black pawn
    legal = 0
    if whos_move$ = "W" and m3 = m1 and m4 = m2 + 1 then legal = 1 'is this a move a pawn can make?
    if whos_move$ = "B" and m3 = m1 and m4 = m2 - 1 then legal = 1
    if whos_move$ = "W" and m3 = m1 - 1 and m4 = m2 + 1 then legal = 1 'capture 
    if whos_move$ = "W" and m3 = m1 + 1 and m4 = m2 + 1 then legal = 1 'capture
    if whos_move$ = "B" and m3 = m1 - 1 and m4 = m2 - 1 then legal = 1 'capture
    if whos_move$ = "B" and m3 = m1 + 1 and m4 = m2 - 1 then legal = 1 'capture
    if whos_move$ = "W" and m2 = 2 and m1 = m3 and m4 = m2 + 2 then legal = 1 'two forward
    if whos_move$ = "B" and m2 = 7 and m1 = m3 and m4 = m2 - 2 then legal = 1 'two forward
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 and m5$ = "q" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 and m5$ = "r" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 and m5$ = "b" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 and m5$ = "n" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 and m5$ = "q" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 and m5$ = "r" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 and m5$ = "b" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 and m5$ = "n" then legal = 1 
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 - 1 and m5$ = "q" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 + 1 and m5$ = "q" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 - 1 and m5$ = "r" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 + 1 and m5$ = "r" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 - 1 and m5$ = "b" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 + 1 and m5$ = "b" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 - 1 and m5$ = "n" then legal = 1
    if whos_move$ = "W" and m2 = 7 and m4 = 8 and m3 = m1 + 1 and m5$ = "n" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 - 1 and m5$ = "q" then legal = 1 
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 + 1 and m5$ = "q" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 - 1 and m5$ = "r" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 + 1 and m5$ = "r" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 - 1 and m5$ = "b" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 + 1 and m5$ = "b" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 - 1 and m5$ = "n" then legal = 1
    if whos_move$ = "B" and m2 = 2 and m4 = 1 and m3 = m1 + 1 and m5$ = "n" then legal = 1
    if whos_move$ = "W" and m2 = 2 and m1 = m3 and m4 = m2 + 2 and board(m1, 3) <> 0 then 'for a two square pawn move, is there a blocking piece in between?
      legal = 0
    endif
    if whos_move$ = "B" and m2 = 7 and m1 = m3 and m4 = m2 - 2 and board(m1, 6) <> 0 then
      legal = 0
    endif
  endif
  if abs(board(m1, m2)) = 2 then 'white or black knight
    legal = 0
    if m4 = m2 + 2 and m3 = m1 + 1 then legal = 1 'is this a move a knight can make? 
    if m4 = m2 + 2 and m3 = m1 - 1 then legal = 1
    if m4 = m2 - 2 and m3 = m1 + 1 then legal = 1
    if m4 = m2 - 2 and m3 = m1 - 1 then legal = 1
    if m4 = m2 + 1 and m3 = m1 + 2 then legal = 1
    if m4 = m2 + 1 and m3 = m1 - 2 then legal = 1
    if m4 = m2 - 1 and m3 = m1 + 2 then legal = 1
    if m4 = m2 - 1 and m3 = m1 - 2 then legal = 1
  end if
  if abs(board(m1, m2)) = 3 then 'white or black bishop
    legal = 0
    for i = 1 to 7
      if m4 = m2 + i and m3 = m1 + i then legal = 1 'is this a move a bishop can make?
      if m4 = m2 + i and m3 = m1 - i then legal = 1
      if m4 = m2 - i and m3 = m1 + i then legal = 1
      if m4 = m2 - i and m3 = m1 - i then legal = 1
    next i
    for i = 1 to 7     
      if m4 = m2 + i and m3 = m1 + i then
        for j = 1 to 6
          if m1 + j = m3 and m2 + j = m4 then legal = 1 : exit sub 'there are no (more) squares in between
          if board(m1 + j, m2 + j) <> 0 then legal = 0 : exit sub 'is there a blocking piece in between?
        next j
      endif
      if m4 = m2 + i and m3 = m1 - i then
        for j = 1 to 6
          if m1 - j = m3 and m2 + j = m4 then legal = 1 : exit sub  
          if board(m1 + j, m2 - j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 - i and m3 = m1 + i then
        for j = 1 to 6      
          if m1 + j = m3 and m2 - j = m4 then legal = 1 : exit sub
          if board(m1 - j, m2 + j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 - i and m3 = m1 - i then
        for j = 1 to 6
          if m1 - j = m3 and m2 - j = m4 then legal = 1 : exit sub
          if board(m1 - j, m2 - j) <> 0 then legal = 0 : exit sub
        next j
      endif
    next i
  endif
  if abs(board(m1, m2)) = 4 then 'white or black rook
    legal = 0
    for i = 1 to 7
      if m4 = m2 and m3 = m1 + i then legal = 1 'is this a move a rook can make?
      if m4 = m2 and m3 = m1 - i then legal = 1
      if m4 = m2 + i and m3 = m1 then legal = 1
      if m4 = m2 - i and m3 = m1 then legal = 1
    next i 
    for i = 1 to 7     
      if m4 = m2 and m3 = m1 + i then
        for j = 1 to 6
          if m1 + j = m3 and m2 = m4 then legal = 1 : exit sub 'there are no (more) squares in between
          if board(m1 + j, m2) <> 0 then legal = 0 : exit sub 'is there a blocking piece in between?
        next j
      endif
      if m4 = m2 and m3 = m1 - i then
        for j = 1 to 6
          if m1 - j = m3 and m2 = m4 then legal = 1 : exit sub  
          if board(m1 - j, m2) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 + i and m3 = m1 then
        for j = 1 to 6      
          if m1 = m3 and m2 + j = m4 then legal = 1 : exit sub
          if board(m1, m2 + j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 - i and m3 = m1 then
        for j = 1 to 6
          if m1 = m3 and m2 - j = m4 then legal = 1 : exit sub
          if board(m1, m2 - j) <> 0 then legal = 0 : exit sub
        next j
      endif
    next i
  endif
  if abs(board(m1, m2)) = 5 then 'white or black queen
    legal = 0
    for i = 1 to 7
      if m4 = m2 and m3 = m1 + i then legal = 1 'is this a move a queen can make?
      if m4 = m2 and m3 = m1 - i then legal = 1
      if m4 = m2 + i and m3 = m1 then legal = 1
      if m4 = m2 - i and m3 = m1 then legal = 1
      if m4 = m2 + i and m3 = m1 + i then legal = 1
      if m4 = m2 + i and m3 = m1 - i then legal = 1
      if m4 = m2 - i and m3 = m1 + i then legal = 1
      if m4 = m2 - i and m3 = m1 - i then legal = 1
    next i
    for i = 1 to 7     
      if m4 = m2 and m3 = m1 + i then
        for j = 1 to 6
          if m1 + j = m3 and m2 = m4 then legal = 1 : exit sub 'there are no (more) squares in between
          if board(m1 + j, m2) <> 0 then legal = 0 : exit sub 'is there a blocking piece in between?
        next j
      endif
      if m4 = m2 and m3 = m1 - i then
        for j = 1 to 6
          if m1 - j = m3 and m2 = m4 then legal = 1 : exit sub  
          if board(m1 - j, m2) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 + i and m3 = m1 then
        for j = 1 to 6      
          if m1 = m3 and m2 + j = m4 then legal = 1 : exit sub
          if board(m1, m2 + j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 - i and m3 = m1 then
        for j = 1 to 6
          if m1 = m3 and m2 - j = m4 then legal = 1 : exit sub
          if board(m1, m2 - j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 + i and m3 = m1 + i then
        for j = 1 to 6
          if m1 + j = m3 and m2 + j = m4 then legal = 1 : exit sub 
          if board(m1 + j, m2 + j) <> 0 then legal = 0 : exit sub 
        next j
      endif
      if m4 = m2 + i and m3 = m1 - i then
        for j = 1 to 6
          if m1 - j = m3 and m2 + j = m4 then legal = 1 : exit sub  
          if board(m1 + j, m2 - j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 - i and m3 = m1 + i then
        for j = 1 to 6      
          if m1 + j = m3 and m2 - j = m4 then legal = 1 : exit sub
          if board(m1 - j, m2 + j) <> 0 then legal = 0 : exit sub
        next j
      endif
      if m4 = m2 - i and m3 = m1 - i then
        for j = 1 to 6
          if m1 - j = m3 and m2 - j = m4 then legal = 1 : exit sub
          if board(m1 - j, m2 - j) <> 0 then legal = 0 : exit sub
        next j
      endif
    next i
  endif
  if abs(board(m1, m2)) = 6 then 'white or black king
    legal = 0
    if m3 = m1 + 1 and m4 = m2 then legal = 1 : exit sub 'is this a move a king can make?
    if m3 = m1 - 1 and m4 = m2 then legal = 1 : exit sub
    if m3 = m1 and m4 = m2 + 1 then legal = 1 : exit sub
    if m3 = m1 and m4 = m2 - 1 then legal = 1 : exit sub
    if m3 = m1 + 1 and m4 = m2 + 1 then legal = 1 : exit sub
    if m3 = m1 + 1 and m4 = m2 - 1 then legal = 1 : exit sub
    if m3 = m1 - 1 and m4 = m2 + 1 then legal = 1 : exit sub
    if m3 = m1 - 1 and m4 = m2 - 1 then legal = 1 : exit sub
    if m1 = 5 and m3 = 7 and m2 = 1 and m4 = 1 and wkm = 0 and h1m = 0 and wc = 0 and board(6, 1) = 0 and board(7, 1) = 0 and F1 is not under attack and G1 is not under attack then legal = 1 : exit sub 'castling kingside
    if m1 = 5 and m3 = 7 and m2 = 8 and m4 = 8 and bkm = 0 and h8m = 0 and bc = 0 and board(6, 8) = 0 and board(7, 8) = 0 and F8 is not under attack and G8 is not under attack then legal = 1 : exit sub
    if m1 = 5 and m3 = 3 and m2 = 1 and m4 = 1 and wkm = 0 and a1m = 0 and wc = 0 and board(4, 1) = 0 and board(3, 1) = 0 and D1 is not under attack and C1 is not under attack then legal = 1 : exit sub 'castling queenside
    if m1 = 5 and m3 = 3 and m2 = 8 and m4 = 8 and bkm = 0 and a8m = 0 and bc = 0 and board(4, 8) = 0 and board(3, 8) = 0 and D8 is not under attack and C8 is not under attack then legal = 1 : exit sub 
  endif
end sub

function fton(file)
  select case file
    case "a"
      return 1
    case "b"
      return 2
    case "c"
      return 3
    case "d"
      return 4
    case "e" 
      return 5
    case "f"
      return 6
    case "g"
      return 7
    case "h"
      return 8
  end select
end function

function ntof(num)
  select case file
    case 1
      return "a"
    case 2
      return "b"
    case 3
      return "c"
    case 4
      return "d"
    case 5
      return "e"
    case 6
      return "f"
    case 7
      return "g"
    case 8
      return "h"
  end select
end function 

sub find_pawn_moves
  for i = 1 to 8
    for j = 1 to 8
      if pc = 1 and board(i, j) = 1 then 'white pawn
        if board(i, j + 1) = 0 and noc() then 'move one square forward
          if j + 1 = 8 then
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8r"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8r"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8b"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8n"
          else
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + 1)
          endif
          if j = 2 and board(i, j + 2) = 0 and noc() then 'move two squares forward
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + str$(j + 2) 
          endif
        endif
        if board(i - 1, j + 1 < 0 and i > 0 and noc() then 'capture to the left
          if j + 1 = 8 then
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8r"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8r"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8b"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8n"
          else
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j + 1)
         endif
        endif
        if board(i + 1, j + 1 < 0 and i < 9 and noc() then 'capture to the right
          if j + 1 = 8 then
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8r"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8r"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8b"
            m = m + 1
            movelist$(m) = ntof(i) + "7" + ntof(i) + "8n"       
          else
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j + 1)
          endif
        endif
      elseif pc = -1 and board(i, j) = -1 then 'black pawn
        if board(i, j - 1) = 0 and noc() then 'move one square forward
          if j - 1 = 1 then
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1r"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1r"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1b"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1n"
          else
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - 1)
          endif
          if j = 7 and board(i, j - 2) = 0 and noc() then 'move two squares forward
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + str$(j - 2) 
          endif
        endif
        if board(i - 1, j - 1 > 0 and i > 0 and noc() then 'capture to the left
          if j - 1 = 1 then
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1r"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1r"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1b"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1n"
          else
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j - 1)
         endif
        endif
        if board(i + 1, j - 1 > 0 and i < 9 and noc() then 'capture to the right
          if j - 1 = 1 then
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1r"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1r"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1b"
            m = m + 1
            movelist$(m) = ntof(i) + "2" + ntof(i) + "1n"       
          else
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j - 1)
          endif
        endif
      endif 
    next j
  next i
end sub

sub find_knight_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if pc = 2 and board(i, j) = 2 then 'white knight 
        if board(i - 1, j + 2) <= 0 and i > 0 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j + 2)
        endif
        if board(i + 1, j + 2) <= 0 and i < 9 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j + 2)
        endif
        if board(i - 1, j - 2) <= 0 and i > 0 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j - 2)
        endif
        if board(i + 1, j - 2) <= 0 and i < 9 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j - 2)
        endif
        if board(i - 2, j + 1) <= 0 and i > 0 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j + 1)
        endif
        if board(i - 2, j - 1) <= 0 and i > 0 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j - 1)
        endif
        if board(i + 2, j + 1) <= 0 and i < 9 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j + 1)
        endif
        if board(i + 2, j - 1) <= 0 and i < 9 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j - 1) 
        endif
      elseif pc = -2 and board(i, j) = -2 then 'black knight 
        if board(i - 1, j + 2) >= 0 and i > 0 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j + 2)
        endif
        if board(i + 1, j + 2) >= 0 and i < 9 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j + 2)
        endif
        if board(i - 1, j - 2) >= 0 and i > 0 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j - 2)
        endif
        if board(i + 1, j - 2) >= 0 and i < 9 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j - 2)
        endif
        if board(i - 2, j + 1) >= 0 and i > 0 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j + 1)
        endif
        if board(i - 2, j - 1) >= 0 and i > 0 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j - 1)
        endif
        if board(i + 2, j + 1) >= 0 and i < 9 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j + 1)
        endif
        if board(i + 2, j - 1) >= 0 and i < 9 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j - 1) 
        endif
      endif
    next j
  next i
end sub

sub find_bishop_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if (pc = 3 and board(i, j) = 3) or (pc = 5 and board(i, j) = 5) then 'white bishop or queen
        for k = 1 to 7
          if board(i + k, j + k) <= 0 and i < 9 and j < 9 and noc() then 
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
          endif
          if board(i + k, j + k) <> 0 or i > 8 or j > 8 then exit for
        next k
        for k = 1 to 7
          if board(i + k, j - k) <= 0 and i < 9 and j > 0 and noc() then
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
          endif
          if board(i + k, j - k) <> 0 or i > 8 or j < 1 then exit for
        next k
        for k = 1 to 7
          if board(i - k, j + k) <= 0 and i > 0 and j < 9 and noc() then
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
          endif
          if board(i - k, j + k) <> 0 or i < 1 or j > 8 then exit for
        next k
        for k = 1 to 7
          if board(i - k, j - k) <= 0 and i > 0 and j > 0 and noc() then
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
          endif
          if board(i - k, j - k) <> 0 or i < 1 or j < 1 then exit for
        next k
      elseif (pc = -3 and board(i, j) = -3) or (pc = -5 and board(i, j) = -5) then 'black bishop or queen
        for k = 1 to 7
          if board(i + k, j + k) >= 0 and i < 9 and j < 9 and noc() then 
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
          endif
          if board(i + k, j + k) <> 0 or i > 8 or j > 8 then exit for
        next k
        for k = 1 to 7
          if board(i + k, j - k) >= 0 and i < 9 and j > 0 and noc() then
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
          endif
          if board(i + k, j - k) <> 0 or i > 8 or j < 1 then exit for
        next k
        for k = 1 to 7
          if board(i - k, j + k) >= 0 and i > 0 and j < 9 and noc() then
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
          endif
          if board(i - k, j + k) <> 0 or i < 1 or j > 8 then exit for
        next k
        for k = 1 to 7
          if board(i - k, j - k) >= 0 and i > 0 and j > 0 and noc() then
             m = m + 1
             movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
          endif
          if board(i - k, j - k) <> 0 or i < 1 or j < 1 then exit for
        next k
      endif
    next j
  next i
end sub

sub find_rook_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if (pc = 4 and board(i, j) = 4) or (pc = 5 and board(i, j) = 5) then 'white rook or queen
        for k = 1 to 7
          if board(i, j + k) <= 0 and j < 9 and noc() then  
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
          endif
          if board(i, j + k) <> 0 or j > 8 then exit for
        next k
        for k = 1 to 7
          if board(i, j - k) <= 0 and j > 0 and noc() then 
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
          endif
          if board(i, j - k) <> 0 or j < 1 then exit for
        next k
        for k = 1 to 7
          if board(i + k, j) <= 0 and i < 9 and noc() then
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
          endif
          if board(i + k, j) <> 0 or i > 8 then exit for
        next k
        for k = 1 to 7
          if board(i - k, j) <= 0 or i > 0 and noc() then
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
          endif
          if board(i - k, j) <> 0 or i < 1 then exit for
        next k
      elseif (pc = -4 and board(i, j) = -4) or (pc = -5 and board(i, j) = -5) then 'black rook or queen
        for k = 1 to 7
          if board(i, j + k) >= 0 and j < 9 and noc() then  
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
          endif
          if board(i, j + k) <> 0 or j > 8 then exit for
        next k
        for k = 1 to 7
          if board(i, j - k) >= 0 and j > 0 and noc() then 
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
          endif
          if board(i, j - k) <> 0 or j < 1 then exit for
        next k
        for k = 1 to 7
          if board(i + k, j) >= 0 and i < 9 and noc() then
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
          endif
          if board(i + k, j) <> 0 or i > 8 then exit for
        next k
        for k = 1 to 7
          if board(i - k, j) >= 0 or i > 0 and noc() then
            m = m + 1
            movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
          endif
          if board(i - k, j) <> 0 or i < 1 then exit for
        next k
      endif        
    next j
  next i
end sub

sub find_king_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if pc = 6 and board(i, j) = 6 then 'white king
        if board(i + k, j + k) <= 0 and i < 9 and j < 9 and noc() then 
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
        endif
        if board(i + k, j - k) <= 0 and i < 9 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
        endif
        if board(i - k, j + k) <= 0 and i > 0 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
        endif
        if board(i - k, j - k) <= 0 and i > 0 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
        endif
        if board(i, j + k) <= 0 and j < 9 and noc() then  
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
        endif
        if board(i, j - k) <= 0 and j > 0 and noc() then 
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
        endif
        if board(i + k, j) <= 0 and i < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
        endif
        if board(i - k, j) <= 0 or i > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
        endif
        if i = 5 and j = 1 and wkm = 0 and h1m = 0 and wc = 0 and board(i + 1) = 0 and board(i + 2) = 0 and F1 is not under attack and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j)
        endif
        if i = 5 and j = 1 and wkm = 0 and a1m = 0 and wc = 0 and board(i - 1) = 0 and board(i - 2) = 0 and D1 is not under attack and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j)
        endif
      elseif pc = -6 and board(i, j) = -6 then 'black king
        if board(i + k, j + k) >= 0 and i < 9 and j < 9 and noc() then 
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
        endif
        if board(i + k, j - k) >= 0 and i < 9 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
        endif
        if board(i - k, j + k) >= 0 and i > 0 and j < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
        endif
        if board(i - k, j - k) >= 0 and i > 0 and j > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
        endif
        if board(i, j + k) >= 0 and j < 9 and noc() then  
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
        endif
        if board(i, j - k) >= 0 and j > 0 and noc() then 
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
        endif
        if board(i + k, j) >= 0 and i < 9 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
        endif
        if board(i - k, j) >= 0 or i > 0 and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
        endif
        if i = 5 and j = 8 and bkm = 0 and h8m = 0 and bc = 0 and board(i + 1) = 0 and board(i + 2) = 0 and F8 is not under attack and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j)
        endif
        if i = 5 and j = 8 and bkm = 0 and a8m = 0 and bc = 0 and board(i - 1) = 0 and board(i - 2) = 0 and D8 is not under attack and noc() then
          m = m + 1
          movelist$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j)
        endif
      endif
    next j
  next i
end sub

sub generate_movelist
  if whos_move$ = "W" then
    find_pawn_moves(1)
    find_knight_moves(2)
    find_bishop_moves(3)
    find_rook_moves(4)
    find_bishop_moves(5) 'queen is bishop + rook
    find_rook_moves(5)   'queen is bishop + rook
    find_king_moves(6)
  else
    find_pawn_moves(-1)
    find_knight_moves(-2)
    find_bishop_moves(-3)
    find_rook_moves(-4)
    find_bishop_moves(-5) 'queen is bishop + rook
    find_rook_moves(-5)   'queen is bishop + rook
    find_king_moves(-6)
  endif
end sub

function noc() 'no check
  'On which square is the king that may be in check?
  'Look for opposing pieces in the eight directions and also the eight L directions (for knights)
  'For opposing bishops, rooks, and queens, is there a blocking piece in between?

  'find pawn of opposite color causing check
 
  'find knight of opposite color causing check

  'find bishop of opposite color causing check
 
  'find rook of opposite color causing check
  
  'find queen of opposite color causing check

  'find king of opposite color causing check
  
  'noc = 0
  'noc = 1
end function

sub determine_result
  'check, checkmate, stalemate, other draws
  if something then
    check = 1
  elseif something then
    check = -1
  endif
  if check = 1 and something then
    checkmate = 1
  endif
  if check = -1 and something then
    checkmate = -1
  endif
  if check = 0 and something then 'stalemate
    draw = 1 
    print @(0, 12) "Draw by"
    print @(0, 24) "Stalemate"
  if check = 0 and something then 'insufficient material
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Insufficient"
    print @(0, 36) "Material"
  elseif something then 'three fold repetition
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Three fold"
    print @(0, 36) "repetition"
  elseif something then 'perpetual check
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Perpetual"
    print @(0, 36) "Check"
  elseif something then 'fifty moves
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Fifty Moves"
  endif
end sub

sub think
  'for now just make a random move
  for i = 1 to 999 
    if movelist$(i) = "" then
      num_moves = i
      exit for 
    endif
  next i
  move$ = int(rnd(num_moves)) + 1  
end sub








