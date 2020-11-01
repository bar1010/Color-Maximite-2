'Bill's Chess
option base 1
dim integer c, d, i, j, k, l, m, x, y, z, number, board(9, 9) 'current board position
dim integer bhistory(8, 8, 1500) 'board history, all the positions from the game
dim integer check, checkmate, draw, num_moves, half_moves, legal, pc 'piece/color
dim integer wkm, bkm, a1m, h1m, a8m, h8m 'white king moved, black king moved, rook has moved
dim integer wc, bc 'white king in check, black king in check
dim integer m1, m2, m3, m4 'the first, second, third, and fourth characters/digits of the move
dim integer kf, kr, bp, file, rank 'king file, king rank, blocking piece
dim integer im, tfr, fmr 'insufficient material, three fold repetition, fifty moves rule
dim integer tot_wpawns, tot_wknights, tot_wbishops, tot_wrooks, tot_wqueens
dim integer tot_bpawns, tot_bknights, tot_bbishops, tot_brooks, tot_bqueens
dim integer ctr, repctr, fmr_ctr 'counter, repetition counter, fifty move rule counter
dim string a$, move$ length 5, whos_move$ length 1, sm$ length 5 'special move
dim string pml$(500) length 5, move_history(999) length 5, m5$ length 1 'position move list
dim string letter$, square$, playerc$ length 1 'player color (W or B)

new_game()

do
  determine_result() 'check to see if we have reached the end of the game
  if (whos_move$ = "W" and playerc$ = "W") or (whos_move$ = "B" and playerc$ = "B") then
    ask:
    get_move()
    for i = 1 to num_moves
      if pml$(i) = move$ then
        legal = 1 : exit for
      else
        legal = 0 
      endif
    next i
    if legal = 0 then
      print @(0, 60) "Illegal"
      print @(0, 72) "Move"
      pause 2000
      print_board()
      goto ask:
    endif
  else
    pause 1500
    'goto ask:
    think()
  endif
  make_move()
  for i = 1 to 499
    pml$(i) = "" 'Clear the list of all legal moves in the position
  next i
  half_moves = half_moves + 1 'Either white or black has completed a move
  move_history(half_moves) = move$ 'Keep a record of the half move just made
  for i = 1 to 8
    for j = 1 to 8
      bhistory(8, 8, half_moves) = board(i, j) 'Keep a record of the position
    next j
  next i
  if whos_move$ = "W" then
    whos_move$ = "B"
  else
    whos_move$ = "W"
  endif
  move$ = "" : sm$ = "" : file = 0 : rank = 0 : m = 0
  num_moves = 0 : fmr_ctr = fmr_ctr + 1 : check = 0
loop

sub new_game
  cls : mode 1, 16                       
  color rgb(yellow), rgb(black)
  load font "DiagramTTHabsburg72.fnt"
  whos_move$ = "W" : sm$ = "" : check = 0 : checkmate = 0 : draw = 0
  num_moves = 20 : half_moves = 0 : legal = 1 : m = 0 : wkm = 0 : bkm = 0
  a1m = 0 : h1m = 0 : a8m = 0 : h8m = 0 : fmr_ctr = 0 : file = 0 : rank = 0
  print@(0, 12) "Do you want";
  print@(0, 24) "(W)hite or";
  print@(0, 36) "(B)lack?";
  input a$ 
  if a$ = "W" or a$ = "w" or a$ = "White" then
    playerc$ = "W" 'Computer is Black
  else 
    playerc$ = "B" 'Computer is White
  endif
  cls
  initial_position()
  print_board()
end sub

sub initial_position
  'Note that board() can always have White at the bottom
  'since we are not displaying the actual array
  board(1, 1) = 4 : board(2, 1) = 2
  board(3, 1) = 3 : board(4, 1) = 5 
  board(5, 1) = 6 : board(6, 1) = 3 
  board(7, 1) = 2 : board(8, 1) = 4
  for i = 1 to 8
    board(i, 2) = 1
    board(i, 3) = 0
    board(i, 4) = 0
    board(i, 5) = 0
    board(i, 6) = 0
    board(i, 7) = -1
  next i 
  board(1, 8) = -4 : board(2, 8) = -2
  board(3, 8) = -3 : board(4, 8) = -5
  board(5, 8) = -6 : board(6, 8) = -3 
  board(7, 8) = -2 : board(8, 8) = -4
end sub

sub get_move
  font 1 : color rgb(green), rgb(black)
  print @(0, 84) "";
  for i = 1 to num_moves step 2
    if i < 81 then
      print pml$(i);"  "pml$(i + 1)
    endif
  next i

  'for i = 1 to half_moves
  '  if i mod 2 = 1 then
  '    print @(704, 12 * (half_moves + 1) / 2) (half_moves + 1) / 2;".";move_history(i); 
  '  else
  '    print @(704, 12 * (half_moves + 1) / 2 + 12) "   ";move_history(i)
  '  endif
  'next i 

  if whos_move$ = "W" then
    print @(0, 12) "White: "
  else 
    print @(0, 12) "Black: "
  endif
  input move$
end sub

sub make_move
  m1 = fton(lcase$(left$(move$, 1))) 
  m2 = val(mid$(move$, 2, 1))
  m3 = fton(lcase$(mid$(move$, 3, 1)))
  m4 = val(mid$(move$, 4, 1))
  m5$ = lcase$(mid$(move$, 5, 1))

  if move$ = "e1g1" then sm$ = "WCK"  
  if move$ = "e8g8" then sm$ = "BCK"
  if move$ = "e1c1" then sm$ = "WCQ"
  if move$ = "e8c8" then sm$ = "BCQ"

  if m1 > 1 then
    if m2 = 5 and board(m1 - 1, 5) = -1 and m3 = m1 - 1 and m4 = 6 then
      if bhistory(m3, 7, half_moves - 1) = - 1 then
        sm$ = "WEPL"
      endif
    endif
  endif
  if m1 < 8 then 
    if m2 = 5 and board(m1 + 1, 5) = -1 and m3 = m1 + 1 and m4 = 6 then
      if bhistory(m3, 7, half_moves - 1) = - 1 then
        sm$ = "WEPR"
      endif
    endif
  endif
  if m1 > 1 then
    if m2 = 4 and board(m1 - 1, 5) = 1 and m3 = m1 - 1 and m4 = 3 then
      if bhistory(m3, 2, half_moves - 1) = 1 then
        sm$ = "BEPL"
      endif
    endif
  endif
  if m1 < 8 then
    if m2 = 4 and board(m1 + 1, 5) = 1 and m3 = m1 + 1 and m4 = 3 then
      if bhistory(m3, 2, half_moves - 1) = 1 then 
        sm$ = "BEPR"
      endif
    endif
  endif

  if m5$ = "q" and whos_move$ = "W" then sm$ = "WPQ"
  if m5$ = "r" and whos_move$ = "W" then sm$ = "WPR"
  if m5$ = "b" and whos_move$ = "W" then sm$ = "WPB"
  if m5$ = "n" and whos_move$ = "W" then sm$ = "WPN"
  if m5$ = "q" and whos_move$ = "B" then sm$ = "BPQ"
  if m5$ = "r" and whos_move$ = "B" then sm$ = "BPR"
  if m5$ = "b" and whos_move$ = "B" then sm$ = "BPB"
  if m5$ = "n" and whos_move$ = "B" then sm$ = "BPN"

  'print "m1=";m1;" m2=";m2 : pause 3000
  if abs(board(m1, m2)) = 1 then fmr_ctr = 0 'reset counter because there has been a pawn move
  if board(m3, m4) <> 0 then fmr_ctr = 0 'reset counter because there has been a capture

  select case sm$
    case ""
      board(m3, m4) = board(m1, m2) 'move the piece to its destination square capturing enemy piece if one exists
      board(m1, m2) = 0 'no piece will exist on the piece's origin square
    case "WCK" 
      board(5, 1) = 0 
      board(7, 1) = 6
      board(8, 1) = 0
      board(6, 1) = 4    
    case "WCQ"
      board(5, 1) = 0
      board(3, 1) = 6
      board(1, 1) = 0
      board(4, 1) = 4
    case "BCK" 
      board(5, 8) = 0
      board(7, 8) = -6
      board(8, 8) = 0
      board(6, 8) = -4
    case "BCQ"
      board(5, 8) = 0
      board(3, 8) = -6
      board(1, 8) = 0
      board(4, 8) = -4
    case "WEPL"
      board(m1, m2) = 0
      board(m1 - 1, m2) = 0
      board(m1 - 1, m2 + 1) = 1
    case "WEPR"
      board(m1, m2) = 0
      board(m1 + 1, m2) = 0
      board(m1 + 1, m2 + 1) = 1
    case "BEPL"
      board(m1, m2) = 0
      board(m1 - 1, m2) = 0
      board(m1 - 1, y - 1) = -1
    case "BEPR"
      board(m1, m2) = 0
      board(m1 + 1, m2) = 0
      board(m1 + 1, y - 1) = -1
    case "WPQ"
      board(m3, 8) = 5
      board(m1, m2) = 0
    case "WPR"
      board(m3, 8) = 4
      board(m1, m2) = 0
    case "WPB"
      board(m3, 8) = 3
      board(m1, m2) = 0
    case "WPN"
      board(m3, 8) = 2
      board(m1, m2) = 0
    case "BPQ"
      board(m3, 1) = -5
      board(m1, m2) = 0
    case "BPR"
      board(m3, 1) = -4
      board(m1, m2) = 0
    case "BPB"
      board(m3, 1) = -3
      board(m1, m2) = 0
    case "BPN"
      board(m3, 1) = -2
      board(m1, m2) = 0
  end select

  print_board()
end sub

sub print_board
  cls
  font 8
  load png "600p_green_vinyl_coordinates_605x600.png", 97, 0  
  if playerc$ = "B" then 
    image rotate_fast 97, 0, 605, 600, 97, 0, 180
  endif

  for i = 1 to 8
    for j = 1 to 8
      if playerc$ = "W" then
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
      else 'player has Black pieces
        select case i
          case 8 'H
            x = 129
          case 7 'G
            x = 197
          case 6 'F
            x = 263
          case 5 'E
            x = 330
          case 4 'D
            x = 398
          case 3 'C
            x = 465
          case 2 'B
            x = 532
          case 1 'A
            x = 599
        end select
        select case j
          case 8
            y = 503
          case 7
            y = 437
          case 6
            y = 368
          case 5
            y = 301
          case 4
            y = 233
          case 3
            y = 166
          case 2
            y = 101
          case 1
            y = 32
        end select
      endif
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

function fton(letter$) as integer
  select case letter$
    case "a"
      fton = 1
    case "b"
      fton = 2
    case "c"
      fton = 3
    case "d"
      fton = 4
    case "e" 
      fton = 5
    case "f"
      fton = 6
    case "g"
      fton = 7
    case "h"
      fton = 8
  end select
end function

function ntof(number) as string
  select case number
    case 1
      ntof = "a"
    case 2
      ntof = "b"
    case 3
      ntof = "c"
    case 4
      ntof = "d" 
    case 5
      ntof = "e"
    case 6
      ntof = "f"
    case 7
      ntof = "g"
    case 8
      ntof = "h"
  end select
end function 

sub generate_posmovelist
  if whos_move$ = "W" then
    find_wpawn_moves(1)
    find_knight_moves(2)
    find_bishop_moves(3)
    find_rook_moves(4)
    find_bishop_moves(5) 'queen is bishop + rook
    find_rook_moves(5)   'queen is bishop + rook
    find_king_moves(6)
  else
    find_bpawn_moves(-1)
    find_knight_moves(-2)
    find_bishop_moves(-3)
    find_rook_moves(-4)
    find_bishop_moves(-5) 'queen is bishop + rook
    find_rook_moves(-5)   'queen is bishop + rook
    find_king_moves(-6)
  endif
  'The number of moves available for white/black
  num_moves = m  
end sub

sub find_wpawn_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if board(i, j) = 1 and pc = 1 then 'white pawn
        if j + 1 < 9 then
          if board(i, j + 1) = 0 and nocheck() then 'move one square forward
            if j + 1 = 8 then
              pml$(m + 1) = ntof(i) + "7" + ntof(i) + "8q"
              pml$(m + 2) = ntof(i) + "7" + ntof(i) + "8r"
              pml$(m + 3) = ntof(i) + "7" + ntof(i) + "8b"
              pml$(m + 4) = ntof(i) + "7" + ntof(i) + "8n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + 1)
            endif
            if j + 2 < 9 then
              if j = 2 and board(i, j + 2) = 0 and nocheck() then 'move two squares forward
                m = m + 1
                pml$(m) = ntof(i) + "2" + ntof(i) + str$(j + 2) 
              endif
            endif
          endif
        endif
        if i - 1 > 0 and j + 1 < 9 then
          if board(i - 1, j + 1) < 0 and nocheck() then 'capture to the left
            if j + 1 = 8 then
              pml$(m + 1) = ntof(i) + "7" + ntof(i - 1) + "8q"
              pml$(m + 2) = ntof(i) + "7" + ntof(i - 1) + "8r"
              pml$(m + 3) = ntof(i) + "7" + ntof(i - 1) + "8b"
              pml$(m + 4) = ntof(i) + "7" + ntof(i - 1) + "8n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j + 1)
            endif
          endif
        endif
        if i + 1 < 9 and j + 1 < 9 then
          if board(i + 1, j + 1) < 0 and nocheck() then 'capture to the right
            if j + 1 = 8 then
              pml$(m + 1) = ntof(i) + "7" + ntof(i + 1) + "8q"
              pml$(m + 2) = ntof(i) + "7" + ntof(i + 1) + "8r"
              pml$(m + 3) = ntof(i) + "7" + ntof(i + 1) + "8b"
              pml$(m + 4) = ntof(i) + "7" + ntof(i + 1) + "8n"       
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j + 1)
            endif
          endif
        endif        
        if half_moves > 2 and m1 - 1 > 0 then
          if m2 = 5 and board(m1 - 1, 5) = -1 and m3 = m1 - 1 and m4 = 6 and nocheck() then 'and bhistory(m3, 7, half_moves - 1) = -1 then 'en passant to the left
            pml$(m) = ntof(i) + "5" + ntof(i - 1) + "6"  
          endif
        endif
        if half_moves > 2 and m1 + 1 < 9 then
          if m2 = 5 and board(m1 + 1, 5) = -1 and m3 = m1 + 1 and m4 = 6 and nocheck() then 'and bhistory(m3, 7, half_moves - 1) = -1 then 'en passant to the right
            pml$(m) = ntof(i) + "5" + ntof(i + 1) + "6"
          endif
        endif
      endif
    next j
  next i
end sub

sub find_bpawn_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if pc = -1 and board(i, j) = -1 then 'black pawn
        if j - 1 > 0 then
          if board(i, j - 1) = 0 then 'and nocheck() then 'move one square forward
            if j - 1 = 1 then
              pml$(m + 1) = ntof(i) + "2" + ntof(i) + "1q"
              pml$(m + 2) = ntof(i) + "2" + ntof(i) + "1r"
              pml$(m + 3) = ntof(i) + "2" + ntof(i) + "1b"
              pml$(m + 4) = ntof(i) + "2" + ntof(i) + "1n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - 1)
            endif
            if j - 2 > 0 then if j = 7 and board(i, j - 2) = 0 then 'and nocheck() then 'move two squares forward
              m = m + 1
              pml$(m) = ntof(i) + "7" + ntof(i) + str$(j - 2) 
            endif
          endif
        endif
        if board(i, j) = -1 and i - 1 > 0 and j - 1 > 0 then
          if board(i - 1, j - 1) > 0 then 'and nocheck() then 'capture to the left
            if j - 1 = 1 then
              pml$(m + 1) = ntof(i) + "2" + ntof(i - 1) + "1q"
              pml$(m + 2) = ntof(i) + "2" + ntof(i - 1) + "1r"
              pml$(m + 3) = ntof(i) + "2" + ntof(i - 1) + "1b"
              pml$(m + 4) = ntof(i) + "2" + ntof(i - 1) + "1n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j - 1)
            endif
          endif
        endif
        if board(i, j) = -1 and j = 2 and i + 1 < 9 and j - 1 > 0 then
          if board(i + 1, j - 1) > 0 then 'and nocheck() then 'capture to the right
            if j - 1 = 1 then
              pml$(m + 1) = ntof(i) + "2" + ntof(i + 1) + "1q"
              pml$(m + 2) = ntof(i) + "2" + ntof(i + 1) + "1r"
              pml$(m + 3) = ntof(i) + "2" + ntof(i + 1) + "1b"
              pml$(m + 4) = ntof(i) + "2" + ntof(i + 1) + "1n"       
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j - 1) 
            endif
          endif
        endif
        if half_moves > 2 and m1 - 1 > 0 then
          if m2 = 4 and board(m1 - 1, 4) = -1 and m3 = m1 - 1 and m4 = 3 then 'and nocheck() then 'and bhistory(m3, 2, half_moves - 1) = 1 then 'en passant to the left
            pml$(m) = ntof(i) + "4" + ntof(i - 1) + "3"  
          endif
        endif
        if half_moves > 2 and m1 + 1 < 9 then
          if m2 = 4 and board(m1 + 1, 4) = -1 and m3 = m1 + 1 and m4 = 3 then 'and nocheck() then 'and bhistory(m3, 2, half_moves - 1) = 1 then 'en passant to the right
            pml$(m) = ntof(i) + "4" + ntof(i + 1) + "3"
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
        if i - 1 > 0 and j + 2 < 9 then
          if board(i - 1, j + 2) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j + 2)
          endif
        endif
        if i + 1 < 9 and j + 2 < 9 then
          if board(i + 1, j + 2) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j + 2)
          endif
        endif
        if i - 1 > 0 and j - 2 > 0 then
          if board(i - 1, j - 2) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j - 2)
          endif
        endif
        if i + 1 < 9 and j - 2 > 0 then
          if board(i + 1, j - 2) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j - 2)
          endif
        endif
        if i - 2 > 0 and j + 1 < 9 then
          if board(i - 2, j + 1) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j + 1)
          endif
        endif
        if i - 2 > 0 and j - 1 > 0 then
          if board(i - 2, j - 1) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j - 1)
          endif
        endif
        if i + 2 < 9 and j + 1 < 9 then
          if board(i + 2, j + 1) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j + 1)
          endif
        endif
        if i + 2 < 9 and j - 1 > 0 then
          if board(i + 2, j - 1) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j - 1) 
          endif
        endif
      elseif pc = -2 and board(i, j) = -2 then 'black knight 
        if i - 1 > 0 and j + 2 < 9 then
          if board(i - 1, j + 2) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j + 2)
          endif
        endif
        if i + 1 < 9 and j + 2 < 9 then
          if board(i + 1, j + 2) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j + 2)
          endif
        endif
        if i - 1 > 0 and j - 2 > 0 then
          if board(i - 1, j - 2) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 1) + str$(j - 2)
          endif
        endif
        if i + 1 < 9 and j - 2 > 0 then
          if board(i + 1, j - 2) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 1) + str$(j - 2)
          endif
        endif
        if i - 2 > 0 and j + 1 < 9 then
          if board(i - 2, j + 1) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j + 1)
          endif
        endif
        if i - 2 > 0 and j - 1 > 0 then
          if board(i - 2, j - 1) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j - 1)
          endif
        endif
        if i + 2 < 9 and j + 1 < 9 then
          if board(i + 2, j + 1) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j + 1)
          endif
        endif
        if i + 2 < 9 and j - 1 > 0 then
          if board(i + 2, j - 1) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j - 1) 
          endif
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
          if i + k < 9 and j + k < 9 then
            if board(i + k, j + k) <= 0 and nocheck() then 
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
            endif
          endif
          if i + k < 9 and j + k < 9 then
            if board(i + k, j + k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i + k < 9 and j - k > 0 then
            if board(i + k, j - k) <= 0 and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
            endif
          endif
          if i + k < 9 and j - k > 0 then
            if board(i + k, j - k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i - k > 0 and j + k < 9 then
            if board(i - k, j + k) <= 0 and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
            endif
          endif
          if i - k > 0 and j + k < 9 then
            if board(i - k, j + k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i - k > 0 and j - k > 0 then
            if board(i - k, j - k) <= 0 and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
            endif
          endif
          if i - k > 0 and j - k > 0 then
            if board(i - k, j - k) <> 0 then exit for
          endif
        next k
      elseif (pc = -3 and board(i, j) = -3) or (pc = -5 and board(i, j) = -5) then 'black bishop or queen
        for k = 1 to 7
          if i + k < 9 and j + k < 9 then
            if board(i + k, j + k) >= 0 then 'and nocheck() then 
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
            endif
          endif
          if i + k < 9 and j + k < 9 then
            if board(i + k, j + k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i + k < 9 and j - k > 0 then
            if board(i + k, j - k) >= 0 then 'and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
            endif
          endif
          if i + k < 9 and j - k > 0 then
            if board(i + k, j - k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i - k > 0 and j + k < 9 then
            if board(i - k, j + k) >= 0 then 'and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
            endif
          endif
          if i - k > 0 and j + k < 9 then
            if board(i - k, j + k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i - k > 0 and j - k > 0 then
            if board(i - k, j - k) >= 0 then 'and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
            endif
          endif
          if i - k > 0 and j - k > 0 then
            if board(i - k, j - k) <> 0 then exit for
          endif
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
          if j + k < 9 then
            if board(i, j + k) <= 0 and nocheck() then  
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
            endif
          endif
          if j + k < 9 then
            if board(i, j + k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if j - k > 0 then
            if board(i, j - k) <= 0 and nocheck() then 
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
            endif
          endif
          if j - k > 0 then
            if board(i, j - k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i + k < 9 then
            if board(i + k, j) <= 0 and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
            endif
          endif
          if i + k < 9 then
            if board(i + k, j) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i - k > 0 then
            if board(i - k, j) <= 0 and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
            endif
          endif
          if i - k > 0 then
            if board(i - k, j) <> 0 then exit for
          endif
        next k
      elseif (pc = -4 and board(i, j) = -4) or (pc = -5 and board(i, j) = -5) then 'black rook or queen
        for k = 1 to 7
          if j + k < 9 then
            if board(i, j + k) >= 0 then 'and nocheck() then  
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
            endif
          endif
          if j + k < 9 then
            if board(i, j + k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if j - k > 0 then
            if board(i, j - k) >= 0 then 'and nocheck() then 
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
            endif
          endif
          if j - k > 0 then
            if board(i, j - k) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i + k < 9 then
            if board(i + k, j) >= 0 then 'and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
            endif
          endif
          if i + k < 9 then
            if board(i + k, j) <> 0 then exit for
          endif
        next k
        for k = 1 to 7
          if i - k > 0 then
            if board(i - k, j) >= 0 then 'and nocheck() then
              m = m + 1
              pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
            endif
          endif
          if i - k > 0 then
            if board(i - k, j) <> 0 then exit for
          endif
        next k
      endif        
    next j
  next i
end sub

sub find_king_moves(pc)
  for i = 1 to 8
    for j = 1 to 8
      if pc = 6 and board(i, j) = 6 then 'white king
        if i + k < 9 and j + k < 9 then
          if board(i + k, j + k) <= 0 and nocheck() then 
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
          endif
        endif
        if i + k < 9 and j - k > 0 then
          if board(i + k, j - k) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
          endif
        endif
        if i - k > 0 and j + k < 9 then
          if board(i - k, j + k) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
          endif
        endif
        if i - k > 0 and j - k > 0 then
          if board(i - k, j - k) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
          endif
        endif
        if j + k < 9 then
          if board(i, j + k) <= 0 and nocheck() then  
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
          endif
        endif
        if j - k > 0 then
          if board(i, j - k) <= 0 and nocheck() then 
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
          endif
        endif
        if i + k < 9 then
          if board(i + k, j) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
          endif
        endif
        if i - k > 0 then
          if board(i - k, j) <= 0 and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
          endif
        endif
        if i = 5 and j = 1 and wkm = 0 and h1m = 0 and wc = 0 and board(6, 1) = 0 then
          if board(7, 1) = 0 and nocheck(6, 1) and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j)
          endif
        endif
        if i = 5 and j = 1 and wkm = 0 and a1m = 0 and wc = 0 and board(4, 1) = 0 then
          if board(3, 1) = 0 and nocheck(4, 1) and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j)
          endif
        endif
      elseif pc = -6 and board(i, j) = -6 then 'black king
        if i + k < 9 and j + k < 9 then
          if board(i + k, j + k) >= 0 then 'and nocheck() then 
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j + k)
          endif
        endif
        if i + k < 9 and j - k > 0 then
          if board(i + k, j - k) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j - k)          
          endif
        endif
        if i - k > 0 and j + k < 9 then
          if board(i - k, j + k) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j + k)
          endif
        endif
        if i - k > 0 and j - k > 0 then
          if board(i - k, j - k) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j - k)
          endif
        endif
        if j + k < 9 then
          if board(i, j + k) >= 0 then 'and nocheck() then  
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j + k)
          endif
        endif
        if j - k > 0 then
          if board(i, j - k) >= 0 then 'and nocheck() then 
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i) + str$(j - k)
          endif
        endif
        if i + k < 9 then
          if board(i + k, j) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + k) + str$(j)
          endif
        endif
        if i - k > 0 then
          if board(i - k, j) >= 0 then 'and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - k) + str$(j)
          endif
        endif
        if i = 5 and j = 8 and bkm = 0 and h8m = 0 and bc = 0 and board(6, 8) = 0 then
          if board(7, 8) = 0 then 'and nocheck(6, 8) and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i + 2) + str$(j)
          endif
        endif
        if i = 5 and j = 8 and bkm = 0 and a8m = 0 and bc = 0 and board(4, 8) = 0 then
          if board(3, 8) = 0 then 'and nocheck(4, 8) and nocheck() then
            m = m + 1
            pml$(m) = ntof(i) + str$(j) + ntof(i - 2) + str$(j)
          endif
        endif
      endif
    next j
  next i
end sub

function nocheck(file, rank) 
  nocheck = 1 ' Initially set to king is NOT in check  
  bp = 0  ' Set blocking piece to NO
   
  'Find the king's square
  if file <> 0 and rank <> 0 then
    kf = file : kr = rank
    file = 0 : rank = 0
  else
    for c = 1 to 8
      for d = 1 to 8
        if whos_move = "W" then
          if board(c, d) = 6 then kf = c : kr = d 
        elseif whos_move = "B" then
          if board(d, d) = -6 then kf = c : kr = d
        endif   
      next d
    next c
  endif

  if whos_move$ = "W" then
    if kf - 1 > 0 and kr + 1 < 9 then
      if board(kf - 1, kr + 1) = -1 then nocheck = 0 : exit function 'The king IS in check by PAWN
    endif
    if kf + 1 < 9 and kr + 1 < 9 then
      if board(kf + 1, kr + 1) = -1 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr + 2 < 9 then
      if board(kf + 1, kr + 2) = -2 then nocheck = 0 : exit function 'The king IS in check by KNIGHT
    endif
    if kf + 1 < 9 and kr - 2 > 0 then
      if board(kf + 1, kr - 2) = -2 then nocheck = 0 : exit function
    endif
    if kf + 2 < 9 and kr + 1 < 9 then
      if board(kf + 2, kr + 1) = -2 then nocheck = 0 : exit function
    endif
    if kf + 2 < 9 and kr - 1 > 0 then
      if board(kf + 2, kr - 1) = -2 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 and kr + 2 < 9 then
      if board(kf - 1, kr + 2) = -2 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 and kr - 2 > 0 then
      if board(kf - 1, kr - 2) = -2 then nocheck = 0 : exit function
    endif
    if kf - 2 > 0 and kr + 1 < 9 then
      if board(kf - 2, kr + 1) = -2 then nocheck = 0 : exit function
    endif
    if kf - 2 > 0 and kr - 1 > 0 then
      if board(kf - 2, kr - 1) = -2 then nocheck = 0 : exit function
    endif
    for c = 1 to 7     
      if kf + c < 9 and kr + c < 9 then
        if board(kf + c, kr + c) = -3 then 'Is there an enemy BISHOP in line with the king?    
          for d = 1 to 7
            if kf + d < 9 and kr + d < 9 then
              if board(kf + d, kr + d) = -3 and bp = 0 then nocheck = 0 : exit function 'The king IS in check by BISHOP
            endif
            if kf + d < 9 and kr + d < 9 then
              if board(kf + d, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next j
        endif
      endif
      if kf + c < 9 and kr - c > 0 then
        if board(kf + c, kr - c) = -3 then 
          for d = 1 to 7
            if kf + d < 9 and kr - d > 0 then
              if board(kf + d, kr - d) = -3 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 and kr - d > 0 then
              if board(kf + d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 and kr + c < 9 then
        if board(kf - c, kr + c) = -3 then 
          for d = 1 to 7
            if kf - d > 0 and kr + d < 9 then
              if board(kf - d, kr + d) = -3 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr + d < 9 then
              if board(kf - d, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 and kr - c > 0 then
        if board(kf - c, kr - c) = -3 then 
          for d = 1 to 7
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) = -3 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
    next c
    for c = 1 to 7     
      if kr + c < 9 then
        if board(kf, kr + c) = -4 then 'Is there an enemy ROOK in line with the king?    
          for d = 1 to 7
            if kr + d < 9 then
              if board(kf, kr + d) = -4 and bp = 0 then nocheck = 0 : exit function 'The king IS in check by ROOK
            endif
            if kr + d < 9 then
              if board(kf, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kr - c > 0 then
        if board(kf, kr - c) = -4 then 
          for d = 1 to 7
            if kr - d > 0 then
              if board(kf, kr - d) = -4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kr - d > 0 then
              if board(kf, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 then
        if board(kf - c, kr) = -4 then 
          for d = 1 to 7
            if kf - d > 0 then
              if board(kf - d, kr) = -4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 then
              if board(kf - d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 then
        if board(kf + c, kr) = -4 then 
          for d = 1 to 7
            if kf + d < 9 then
              if board(kf + d, kr) = -4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 then
              if board(kf + d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
    next c
    for c = 1 to 7     
      if kr + c < 9 then
        if board(kf, kr + c) = -5 then 'Is there an enemy QUEEN in line with the king?    
          for d = 1 to 7
            if kr + d < 9 then
              if board(kf, kr + d) = -5 and bp = 0 then nocheck = 0 : exit function 'The king IS in check by QUEEN
            endif
            if kr + d < 9 then
              if board(kf, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kr - c > 0 then
        if board(kf, kr - c) = -5 then 
          for d = 1 to 7
            if kr - d > 0 then
              if board(kf, kr - d) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kr - d > 0 then
              if board(kf, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 then
        if board(kf - c, kr) = -5 then 
          for d = 1 to 7
            if kf - d > 0 then
              if board(kf - d, kr) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 then
              if board(kf - d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 then
        if board(kf + c, kr) = -5 then 
          for j = 1 to 7
            if kf + d < 9 then
              if board(kf + d, kr) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 then
              if board(kf + d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 and kr + c < 9 then
        if board(kf + c, kr + c) = -5 then   
          for d = 1 to 7
            if kf + d < 9 and kr + d < 9 then
              if board(kf + d, kr + d) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 and kr + d < 9 then
              if board(kf + d, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 and kr - c > 0 then
        if board(kf + c, kr - c) = -5 then 
          for d = 1 to 7
            if kf + d < 9 and kr - d > 0 then
              if board(kf + d, kr - d) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 and kr - d > 0 then
              if board(kf + d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 and kr + c < 9 then
        if board(kf - c, kr + c) = -5 then 
          for d = 1 to 7
            if kf - d > 0 and kr + d < 9 then
              if board(kf - d, kr + d) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr + d < 9 then
              if board(kf - d, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 and kr - c > 0 then
        if board(kf - c, kr - c) = -5 then 
          for d = 1 to 7
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) = -5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
    next c
    if kf - 1 > 0 and kr - 1 > 0 then
      if board(kf - 1, kr - 1) = -6 then nocheck = 0 : exit function 'The king IS in check by KING
    endif
    if kf - 1 > 0 then
      if board(kf - 1, kr) = -6 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 and kr + 1 < 9 then
      if board(kf - 1, kr + 1) = -6 then nocheck = 0 : exit function
    endif
    if kr - 1 > 0 then
      if board(kf, kr - 1) = -6 then nocheck = 0 : exit function
    endif
    if kr + 1 < 9 then
      if board(kf, kr + 1) = -6 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr - 1 > 0 then
      if board(kf + 1, kr - 1) = -6 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 then
      if board(kf + 1, kr) = -6 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr + 1 < 9 then
      if board(kf + 1, kr + 1) = -6 then nocheck = 0 : exit function
    endif
  elseif whos_move$ = "B" then
    if kf - 1 > 0 and kr - 1 > 0 then
      if board(kf - 1, kr - 1) = 1 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr - 1 > 0 then
      if board(kf + 1, kr - 1) = 1 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr + 2 < 9 then
      if board(kf + 1, kr + 2) = 2 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr - 2 > 0 then
      if board(kf + 1, kr - 2) = 2 then nocheck = 0 : exit function
    endif
    if kf + 2 < 9 and kr + 1 < 9 then
      if board(kf + 2, kr + 1) = 2 then nocheck = 0 : exit function
    endif
    if kf + 2 < 9 and kr - 1 > 0 then
      if board(kf + 2, kr - 1) = 2 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 and kr + 2 < 9 then
      if board(kf - 1, kr + 2) = 2 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 and kr - 2 > 0 then
      if board(kf - 1, kr - 2) = 2 then nocheck = 0 : exit function
    endif
    if kf - 2 > 0 and kr + 1 < 9 then
      if board(kf - 2, kr + 1) = 2 then nocheck = 0 : exit function
    endif
    if kf - 2 > 0 and kr - 1 > 0 then
      if board(kf - 2, kr - 1) = 2 then nocheck = 0 : exit function
    endif
    for c = 1 to 7     
      if kf + c < 9 and kr + c < 9 then
        if board(kf + c, kr + c) = 3 then 
          for d = 1 to 7
            if kf + d < 9 and kr + d < 9 then if board(kf + d, kr + d) = 3 and bp = 0 then nocheck = 0 : exit function 
            if kf + d < 9 and kr + d < 9 then if board(kf + d, kr + d) <> 0 then bp = 1 : exit function    
          next d
        endif
      endif
      if kf + c < 9 and kr - c > 0 then
        if board(kf + c, kr - c) = 3 then 
          for d = 1 to 7
            if kf + d < 9 and kr - d > 0 then if board(kf + d, kr - d) = 3 and bp = 0 then nocheck = 0 : exit function 
            if kf + d < 9 and kr - d > 0 then if board(kf + d, kr - d) <> 0 then bp = 1 : exit function    
          next d
        endif
      endif
      if kf - c > 0 and kr + c < 9 then
        if board(kf - c, kr + c) = 3 then 
          for d = 1 to 7
            if kf - d > 0 and kr + d < 9 then if board(kf - d, kr + d) = 3 and bp = 0 then nocheck = 0 : exit function 
            if kf - d > 0 and kr + d < 9 then if board(kf - d, kr + d) <> 0 then bp = 1 : exit function    
          next d
        endif
      endif
      if kf - c > 0 and kr - c > 0 then
        if board(kf - c, kr - c) = 3 then 
          for d = 1 to 7
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) = 3 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
    next c
    for c = 1 to 7     
      if kr + c < 9 then
        if board(kf, kr + c) = 4 then 
          for d = 1 to 7
            if kr + d < 9 then
              if board(kf, kr + d) = 4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kr + d < 9 then
              if board(kf, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kr - 1 > 0 then
        if board(kf, kr - c) = 4 then 
          for d = 1 to 7
            if kr - d > 0 then
              if board(kf, kr - d) = 4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kr - d > 0 then
              if board(kf, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 then
        if board(kf - c, kr) = 4 then 
          for d = 1 to 7
            if kf - d > 0 then
              if board(kf - d, kr) = 4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 then
              if board(kf - d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 then
        if board(kf + c, kr) = 4 then 
          for d = 1 to 7
            if kf + d < 9 then
              if board(kf + d, kr) = 4 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 then
              if board(kf + d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
    next c
    for c = 1 to 7     
      if kr + c < 9 then
        if board(kf, kr + c) = 5 then 
          for d = 1 to 7
            if kr + d < 9 then
              if board(kf, kr + d) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kr + d < 9 then
              if board(kf, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kr - c > 0 then
        if board(kf, kr - c) = 5 then 
          for d = 1 to 7
            if kr - d > 0 then
              if board(kf, kr - d) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kr - d > 0 then
              if board(kf, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 then
        if board(kf - c, kr) = 5 then 
          for d = 1 to 7
            if kf - d > 0 then
              if board(kf - d, kr) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 then
              if board(kf - d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 then
        if board(kf + c, kr) = 5 then 
          for d = 1 to 7
            if kf + d < 9 then
              if board(kf + d, kr) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 then
              if board(kf + d, kr) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 and kr + c < 9 then
        if board(kf + c, kr + c) = 5 then   
          for d = 1 to 7
            if kf + d < 9 and kr + d < 9 then
              if board(kf + d, kr + d) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 and kr + d < 9 then
              if board(kf + d, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf + c < 9 and kr - c > 0 then
        if board(kf + c, kr - c) = 5 then 
          for d = 1 to 7
            if kf + d < 9 and kr - d > 0 then
              if board(kf + d, kr - d) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf + d < 9 and kr - d > 0 then
              if board(kf + d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 and kr + c < 9 then
        if board(kf - c, kr + c) = 5 then 
          for d = 1 to 7
            if kf - d > 0 and kr + d < 9 then
              if board(kf - d, kr + d) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr + d < 9 then
              if board(kf - d, kr + d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
      if kf - c > 0 and kr - c > 0 then
        if board(kf - c, kr - c) = 5 then 
          for d = 1 to 7
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) = 5 and bp = 0 then nocheck = 0 : exit function 
            endif
            if kf - d > 0 and kr - d > 0 then
              if board(kf - d, kr - d) <> 0 then bp = 1 : exit function    
            endif
          next d
        endif
      endif
    next c
    if kf - 1 > 0 and kr - 1 > 0 then
      if board(kf - 1, kr - 1) = 6 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 then
      if board(kf - 1, kr) = 6 then nocheck = 0 : exit function
    endif
    if kf - 1 > 0 and kr + 1 < 9 then
      if board(kf - 1, kr + 1) = 6 then nocheck = 0 : exit function
    endif
    if kr - 1 > 0 then
      if board(kf, kr - 1) = 6 then nocheck = 0 : exit function
    endif
    if kr + 1 < 9 then
      if board(kf, kr + 1) = 6 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr - 1 > 0 then
      if board(kf + 1, kr - 1) = 6 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 then
      if board(kf + 1, kr) = 6 then nocheck = 0 : exit function
    endif
    if kf + 1 < 9 and kr + 1 < 9 then
      if board(kf + 1, kr + 1) = 6 then nocheck = 0 : exit function
    endif
  endif  
end function

sub determine_result
  num_moves = 0 : im = 0 : tfr = 0 : fmr = 0 : ctr = 0
  tot_wpawns = 0 : tot_wknights = 0 : tot_wbishops = 0 : tot_wrooks = 0 : tot_wqueens = 0
  tot_bpawns = 0 : tot_bknights = 0 : tot_bbishops = 0 : tot_brooks = 0 : tot_bqueens = 0 
  generate_posmovelist() 'Note that num_moves is calculated within this subroutine
  if nocheck() then check = 0 else check = 1

  for i = 1 to 8
    for j = 1 to 8
      if board(i, j) = 1 then tot_wpawns = tot_wpawns + 1
      if board(i, j) = 2 then tot_wknights = tot_wknights + 1
      if board(i, j) = 3 then tot_wbishops = tot_wbishops + 1
      if board(i, j) = 4 then tot_wrooks = tot_wrooks + 1
      if board(i, j) = 5 then tot_wqueens = tot_wqueens + 1
      if board(i, j) = -1 then tot_bpawns = tot_bpawns + 1
      if board(i, j) = -2 then tot_bknights = tot_bknights + 1
      if board(i, j) = -3 then tot_bbishops = tot_bbishops + 1
      if board(i, j) = -4 then tot_brooks = tot_brooks + 1
      if board(i, j) = -5 then tot_bqueens = tot_bqueens + 1  
    next j
  next i
 
  if tot_wqueens > 0 or tot_bqueens > 0 then 
    im = 0
  elseif tot_wrooks > 0 or tot_brooks > 0 then
    im = 0
  elseif tot_wbishops > 1 or tot_bbishops > 1 then
    im = 0
  elseif tot_wknights > 2 or tot_bknights > 2 then
    im = 0
  elseif tot_wpawns > 0 or tot_bpawns > 0 then
    im = 0
  else
    im = 1
  endif
  
  for i = 1 to half_moves
    for j = 1 to 8
      for k = 1 to 8
        if bhistory(j, k, i) = board(j, k) then ctr = ctr + 1
      next k
    next j
    if ctr = 64 then repctr = repctr + 1
    ctr = 0
  next i
  if repctr > 2 then tfr = 1

  if whose_move$ = "B" and check = 1 and num_moves = 0 then
    checkmate = 1 
    print @(0, 12) "Checkmate!"
    print @(0, 24) "White won"
    another()
  endif
  if whose_move$ = "W" and check = 1 and num_moves = 0 then
    checkmate = -1 
    print @(0, 12) "Checkmate!"
    print @(0, 24) "Black won"
    another()
  endif
  if check = 0 and num_moves = 0 then
    draw = 1 
    print @(0, 12) "Draw by"
    print @(0, 24) "Stalemate"
    another()
  endif
  if im = 1 then
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Insufficient"
    print @(0, 36) "Material"
    another()
  endif
  if tfr = 1 then
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Three fold"
    print @(0, 36) "repetition"
    another()
  endif
  if fmr_ctr > 99 then
    draw = 1
    print @(0, 12) "Draw by"
    print @(0, 24) "Fifty Moves"
    another()
  endif
end sub

sub another
  pause 4000
  print @(0, 60) "New game?"
  input a$
  if a$ = "y" or a$ = "Y" or a$ = "yes" or a$ = "YES" then
    new_game()
  else 
    cls : end
  endif
end sub

sub think
  font 1 : color rgb(green), rgb(black)
  if whos_move$ = "W" then
    print @(0, 12) "White is"
  else 
    print @(0, 12) "Black is"
  endif
  print @(0, 24) "thinking..."
  
  'print "nm =";num_moves 
  z = int(rnd * num_moves) + 1  
  'print "z=";z; : pause 4000
  move$ = pml$(z) 

  if whos_move$ = "W" then
    print @(0, 12) "White's move"
  else 
    print @(0, 12) "Black's move"
  endif
  print @(0, 24) "is ";move$;"   ";
end sub

