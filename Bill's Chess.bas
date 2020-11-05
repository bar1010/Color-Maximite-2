'Bill's Chess
option base 1
dim integer b, c, d, e, f, g, h, i, ii, j, k, l, m, x, y, z
dim integer t1, t2, t3, t4, t5 'the move being thought about broken into pieces, t5 is the piece
dim integer number, board(9, 9), tboard(9, 9) 'board position, thinking board position
dim integer wcb(9, 9), bcb(9, 9) 'white/black control board
dim integer bhistory(8, 8, 1500) 'board history, all the positions from the game
dim integer check, checkmate, draw, num_moves, half_moves, legal, pc 'piece/color
dim integer wkm, bkm, a1m, h1m, a8m, h8m 'white king moved, black king moved, rook has moved
dim integer wc, bc, level 'white king in check, black king in check, computer thinking level
dim integer m1, m2, m3, m4 'the first, second, third, and fourth characters/digits of the move
dim integer kf, kr, wkf, wkr, bkf, bkr 'king file/rank, white king file/rank, black king file/rank 
dim integer bp, file, rank 'blocking piece
dim integer im, tfr, fmr 'insufficient material, three fold repetition, fifty moves rule
dim integer tot_wpawns, tot_wknights, tot_wbishops, tot_wrooks, tot_wqueens
dim integer tot_bpawns, tot_bknights, tot_bbishops, tot_brooks, tot_bqueens
dim integer ctr, repctr, fmr_ctr 'counter, repetition counter, fifty move rule counter
dim integer score, hscore 'evaluating a position
dim string a$, move$ length 5, whos_move$ length 1, sm$ length 5, tsm$ length 5 'special move, thinking special move
dim string pml$(500) length 5, move_history$(999) length 5, m5$ length 1 'position move list
dim string letter$, square$, playerc$ length 1 'player color (W or B)

newg:
new_game()

do
  determine_result()
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
      color rgb(red) : print @(0, 60) "Illegal"
      print @(0, 72) "Move" : color rgb(green)
      pause 2000
      print_board()
      goto ask:
    endif
  else
    think()
  endif
  make_move()
  for i = 1 to 499
    pml$(i) = "" 
  next i
  half_moves = half_moves + 1 
  move_history$(half_moves) = move$ 
  for i = 1 to 8
    for j = 1 to 8
      bhistory(i, j, half_moves) = board(i, j) 'made a change here from 8, 8 to i, j
    next j
  next i
  if whos_move$ = "W" then
    whos_move$ = "B"
  else
    whos_move$ = "W"
  endif
  move$ = "" : sm$ = "" : file = 0 : rank = 0 : m = 0
  num_moves = 0 : fmr_ctr = fmr_ctr + 1 : check = 0
  m1 = 0 : m2 = 0 : m3 = 0 : m4 = 0 : m5$ = ""
loop

sub new_game
  cls : mode 1, 16 : color rgb(yellow), rgb(black)
  load font "DiagramTTHabsburg72.fnt"
  whos_move$ = "W" : sm$ = "" : check = 0 : checkmate = 0 : draw = 0 : level = 1
  num_moves = 20 : half_moves = 0 : legal = 1 : m = 0 : wkm = 0 : bkm = 0
  a1m = 0 : h1m = 0 : a8m = 0 : h8m = 0 : fmr_ctr = 0 : file = 0 : rank = 0
  wkf = 5 : wkr = 1 : bkf = 5 : bkr = 8
  print@(0, 12) "Do you want";
  print@(0, 24) "(W)hite or";
  print@(0, 36) "(B)lack?";
  input a$ 
  if a$ = "W" or a$ = "w" or a$ = "White" then
    playerc$ = "W" 
  else 
    playerc$ = "B" 
  endif
  cls
  initial_position()
  print_board()
end sub

sub initial_position
  board(1, 1) = 4 : board(2, 1) = 2 : board(3, 1) = 3 : board(4, 1) = 5 
  board(5, 1) = 6 : board(6, 1) = 3 : board(7, 1) = 2 : board(8, 1) = 4
  for i = 1 to 8
    board(i, 2) = 1 : board(i, 3) = 0 : board(i, 4) = 0
    board(i, 5) = 0 : board(i, 6) = 0 : board(i, 7) = -1
  next i 
  board(1, 8) = -4 : board(2, 8) = -2 : board(3, 8) = -3 : board(4, 8) = -5
  board(5, 8) = -6 : board(6, 8) = -3 : board(7, 8) = -2 : board(8, 8) = -4
end sub

sub get_move
  font 1 : color rgb(green), rgb(black)
  print @(0, 84) "";
  for i = 1 to num_moves step 2
    if i < 81 then
      print pml$(i);"  "pml$(i + 1)
    endif
  next i

  color rgb(red) : print @(704, 0) " Level";level : color rgb(green)
  if half_moves > 10 then
    j = 1
    for i = half_moves - 9 to half_moves
      if i mod 2 = 1 then
        print @(704, 12 * j) (i + 1) / 2;". ";move_history$(i)
      else
        if i < 20 then
          print @(704, 12 * j) "    ";move_history$(i)
        elseif halfmoves < 200 then
          print @(704, 12 * j) "     ";move_history$(i)
        else
          print @(704, 12 * j) "      ";move_history$(i)
        endif
      endif
      j = j + 1
    next i 
  else
    for i = 1 to half_moves
      if i mod 2 = 1 then
        print @(704, 12 * i) (i + 1) / 2;". ";move_history$(i)
      else
        print @(704, 12 * i) "    ";move_history$(i)
      endif
    next i
  endif

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
      if move_history$(half_moves) = mid$(move$, 3, 1) + "7" + mid$(move$, 3, 1) + "5" then
        sm$ = "WEPL"
      endif
    endif
  endif
  if m1 < 8 then 
    if m2 = 5 and board(m1 + 1, 5) = -1 and m3 = m1 + 1 and m4 = 6 then
      if move_history$(half_moves) = mid$(move$, 3, 1) + "7" + mid$(move$, 3, 1) + "5" then 
        sm$ = "WEPR"
      endif
    endif
  endif
  if m1 > 1 then
    if m2 = 4 and board(m1 - 1, 4) = 1 and m3 = m1 - 1 and m4 = 3 then
      if move_history$(half_moves) = mid$(move$, 3, 1) + "2" + mid$(move$, 3, 1) + "4" then 'this works right
        sm$ = "BEPL"
      endif
    endif
  endif
  if m1 < 8 then
    if m2 = 4 and board(m1 + 1, 4) = 1 and m3 = m1 + 1 and m4 = 3 then
      if move_history$(half_moves) = mid$(move$, 3, 1) + "2" + mid$(move$, 3, 1) + "4" then 'this works right
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

  if abs(board(m1, m2)) = 1 then fmr_ctr = 0 'reset counter because there has been a pawn move
  if board(m3, m4) <> 0 then fmr_ctr = 0 'reset counter because there has been a capture

  select case sm$
    case ""
      board(m3, m4) = board(m1, m2) 'move the piece to its destination square capturing enemy piece if one exists
      board(m1, m2) = 0 'no piece will exist on the piece's origin square
    case "WCK" : board(5, 1) = 0 : board(7, 1) = 6 : board(8, 1) = 0 : board(6, 1) = 4    
    case "WCQ" : board(5, 1) = 0 : board(3, 1) = 6 : board(1, 1) = 0 : board(4, 1) = 4
    case "BCK" : board(5, 8) = 0 : board(7, 8) = -6 : board(8, 8) = 0 : board(6, 8) = -4
    case "BCQ" : board(5, 8) = 0 : board(3, 8) = -6 : board(1, 8) = 0 : board(4, 8) = -4
    case "WEPL" : board(m1, m2) = 0 : board(m1 - 1, m2) = 0 : board(m1 - 1, m2 + 1) = 1
    case "WEPR" : board(m1, m2) = 0 : board(m1 + 1, m2) = 0 : board(m1 + 1, m2 + 1) = 1
    case "BEPL" : board(m1, m2) = 0 : board(m1 - 1, m2) = 0 : board(m1 - 1, m2 - 1) = -1
    case "BEPR" : board(m1, m2) = 0 : board(m1 + 1, m2) = 0 : board(m1 + 1, m2 - 1) = -1
    case "WPQ" : board(m3, 8) = 5 : board(m1, m2) = 0
    case "WPR" : board(m3, 8) = 4 : board(m1, m2) = 0
    case "WPB" : board(m3, 8) = 3 : board(m1, m2) = 0
    case "WPN" : board(m3, 8) = 2 : board(m1, m2) = 0
    case "BPQ" : board(m3, 1) = -5 : board(m1, m2) = 0
    case "BPR" : board(m3, 1) = -4 : board(m1, m2) = 0
    case "BPB" : board(m3, 1) = -3 : board(m1, m2) = 0
    case "BPN" : board(m3, 1) = -2 : board(m1, m2) = 0
  end select
  print_board()
end sub

sub print_board
  cls : font 8
  load png "600pd32_green_vinyl_coordinates_605x600.png", 97, 0 'board that is 32% darker
  if playerc$ = "B" then 
    image rotate_fast 97, 0, 605, 600, 97, 0, 180
  endif

  for i = 1 to 8
    for j = 1 to 8
      if playerc$ = "W" then
        select case i
          case 1 : x = 133 'A
          case 2 : x = 200 'B
          case 3 : x = 267 'C
          case 4 : x = 334 'D
          case 5 : x = 402 'E
          case 6 : x = 469 'F
          case 7 : x = 535 'G
          case 8 : x = 603 'H
        end select
        select case j
          case 1 : y = 500
          case 2 : y = 435
          case 3 : y = 368
          case 4 : y = 301
          case 5 : y = 233
          case 6 : y = 166
          case 7 : y = 100
          case 8 : y = 31
        end select
      else 'player has Black pieces
        select case i
          case 8 : x = 129 'H
          case 7 : x = 197 'G
          case 6 : x = 263 'F
          case 5 : x = 330 'E
          case 4 : x = 398 'D
          case 3 : x = 465 'C
          case 2 : x = 532 'B
          case 1 : x = 599 'A
        end select
        select case j
          case 8 : y = 503
          case 7 : y = 437
          case 6 : y = 368
          case 5 : y = 301
          case 4 : y = 233
          case 3 : y = 166
          case 2 : y = 101
          case 1 : y = 32
        end select
      endif
      select case board(i, j)
        case 1 : color rgb(yellow), rgb(white) : print @(x, y, 5) chr$(112); 
        case 2 : color rgb(yellow), rgb(white) : print @(x, y, 5) chr$(110);
        case 3 : color rgb(yellow), rgb(white) : print @(x, y, 5) chr$(108);
        case 4 : color rgb(yellow), rgb(white) : print @(x, y, 5) chr$(114);
        case 5 : color rgb(yellow), rgb(white) : print @(x, y, 5) chr$(113);
        case 6 : color rgb(yellow), rgb(white) : print @(x, y, 5) chr$(107);
        case -1 : color rgb(yellow), rgb(black) : print @(x, y, 5) chr$(112);
        case -2 : color rgb(yellow), rgb(black) : print @(x, y, 5) chr$(110);
        case -3 : color rgb(yellow), rgb(black) : print @(x, y, 5) chr$(108);
        case -4 : color rgb(yellow), rgb(black) : print @(x, y, 5) chr$(114);
        case -5 : color rgb(yellow), rgb(black) : print @(x, y, 5) chr$(113);
        case -6 : color rgb(yellow), rgb(black) : print @(x, y, 5) chr$(107);
      end select
    next j
  next i    
end sub

function fton(letter$) as integer
  select case letter$
    case "a" : fton = 1
    case "b" : fton = 2
    case "c" : fton = 3
    case "d" : fton = 4
    case "e" : fton = 5
    case "f" : fton = 6
    case "g" : fton = 7
    case "h" : fton = 8
  end select
end function

function ntof(number) as string
  select case number
    case 1 : ntof = "a"
    case 2 : ntof = "b"
    case 3 : ntof = "c"
    case 4 : ntof = "d" 
    case 5 : ntof = "e"
    case 6 : ntof = "f"
    case 7 : ntof = "g"
    case 8 : ntof = "h"
  end select
end function 

sub generate_posmovelist
  if whos_move$ = "W" then
    find_wpawn_moves()
    find_knight_moves(2)
    find_bishop_moves(3)
    find_rook_moves(4)
    find_bishop_moves(5) 'queen is bishop + rook
    find_rook_moves(5)   
    find_king_moves(6)
  else
    find_bpawn_moves()
    find_knight_moves(-2)
    find_bishop_moves(-3)
    find_rook_moves(-4)
    find_bishop_moves(-5) 
    find_rook_moves(-5)   
    find_king_moves(-6)
  endif
  num_moves = m  
end sub

sub find_wpawn_moves
  for c = 1 to 8
    for d = 1 to 8
      if board(c, d) = 1 then 
        if d + 1 < 9 then
          control_board(c, d, c, d + 1, 1)
          if board(c, d + 1) = 0 and bcb(wkf, wkr) = 0 then 'move one square forward
            if d + 1 = 8 then
              pml$(m + 1) = ntof(c) + "7" + ntof(c) + "8q"
              pml$(m + 2) = ntof(c) + "7" + ntof(c) + "8r"
              pml$(m + 3) = ntof(c) + "7" + ntof(c) + "8b"
              pml$(m + 4) = ntof(c) + "7" + ntof(c) + "8n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c) + str$(d + 1)
            endif
            if d + 2 < 9 then
              control_board(c, d, c, d + 2, 1)
              if d = 2 and board(c, d + 2) = 0 and bcb(wkf, wkr) = 0 then 'move two squares forward
                m = m + 1
                pml$(m) = ntof(c) + "2" + ntof(c) + str$(d + 2) 
              endif
            endif
          endif
        endif
        if c - 1 > 0 and d + 1 < 9 then
          control_board(c, d, c - 1, d + 1, 1)
          if board(c - 1, d + 1) < 0 and bcb(wkf, wkr) = 0 then 'capture to the left
            if d + 1 = 8 then
              pml$(m + 1) = ntof(c) + "7" + ntof(c - 1) + "8q"
              pml$(m + 2) = ntof(c) + "7" + ntof(c - 1) + "8r"
              pml$(m + 3) = ntof(c) + "7" + ntof(c - 1) + "8b"
              pml$(m + 4) = ntof(c) + "7" + ntof(c - 1) + "8n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - 1) + str$(d + 1)
            endif
          endif
        endif
        if c + 1 < 9 and d + 1 < 9 then
          control_board(c, d, c + 1, d + 1, 1)
          if board(c + 1, d + 1) < 0 and bcb(wkf, wkr) = 0 then 'capture to the right
            if d + 1 = 8 then
              pml$(m + 1) = ntof(c) + "7" + ntof(c + 1) + "8q"
              pml$(m + 2) = ntof(c) + "7" + ntof(c + 1) + "8r"
              pml$(m + 3) = ntof(c) + "7" + ntof(c + 1) + "8b"
              pml$(m + 4) = ntof(c) + "7" + ntof(c + 1) + "8n"       
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + 1) + str$(d + 1)
            endif
          endif
        endif        
        if half_moves > 2 and c - 1 > 0 then
          if d = 5 and board(c - 1, 5) = -1 then
            control_board(c, d, c - 1, d + 1, 1)
            if bcb(wkf, wkr) = 0 and move_history$(half_moves) = ntof(c - 1) + "7" + ntof(c - 1) + "5" then 'en passant to the left
              m = m + 1
              pml$(m) = ntof(c) + "5" + ntof(c - 1) + "6"  
            endif
          endif
        endif
        if half_moves > 2 and c + 1 < 9 then
          if d = 5 and board(c + 1, 5) = -1 then
            control_board(c, d, c + 1, d + 1, 1)
            if bcb(wkf, wkr) = 0 and move_history$(half_moves) = ntof(c + 1) + "7" + ntof(c + 1) + "5" then 'en passant to the right
              m = m + 1
              pml$(m) = ntof(c) + "5" + ntof(c + 1) + "6"
            endif
          endif
        endif
      endif
    next d
  next c
end sub

sub find_bpawn_moves
  for c = 1 to 8
    for d = 1 to 8
      if board(c, d) = -1 then 
        if d - 1 > 0 then
          control_board(c, d, c, d - 1, -1) 'changed last parameter from 1 to -1 and other places below.
          if board(c, d - 1) = 0 and wcb(bkf, bkr) = 0 then 'move one square forward
            if d - 1 = 1 then
              pml$(m + 1) = ntof(c) + "2" + ntof(d) + "1q"
              pml$(m + 2) = ntof(c) + "2" + ntof(d) + "1r"
              pml$(m + 3) = ntof(c) + "2" + ntof(d) + "1b"
              pml$(m + 4) = ntof(c) + "2" + ntof(d) + "1n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c) + str$(d - 1)
            endif
            control_board(c, d, c, d - 2, -1)
            if d - 2 > 0 then 'fixed then if, split apart
              if d = 7 and board(c, d - 2) = 0 and wcb(bkf, bkr) = 0 then 'move two squares forward
                m = m + 1
                pml$(m) = ntof(c) + "7" + ntof(c) + str$(d - 2) 
              endif
            endif
          endif
        endif
        if board(c, d) = -1 and c - 1 > 0 and d - 1 > 0 then
          control_board(c, d, c - 1, d - 1, -1)
          if board(c - 1, d - 1) > 0 and wcb(bkf, bkr) = 0 then 'capture to the left
            if d - 1 = 1 then
              pml$(m + 1) = ntof(c) + "2" + ntof(c - 1) + "1q"
              pml$(m + 2) = ntof(c) + "2" + ntof(c - 1) + "1r"
              pml$(m + 3) = ntof(c) + "2" + ntof(c - 1) + "1b"
              pml$(m + 4) = ntof(c) + "2" + ntof(c - 1) + "1n"
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - 1) + str$(d - 1)
            endif
          endif
        endif
        if board(c, d) = -1 and c + 1 < 9 and d - 1 > 0 then
          control_board(c, d, c + 1, d - 1, -1)
          if board(c + 1, d - 1) > 0 and wcb(bkf, bkr) = 0 then 'capture to the right
            if d - 1 = 1 then
              pml$(m + 1) = ntof(c) + "2" + ntof(c + 1) + "1q"
              pml$(m + 2) = ntof(c) + "2" + ntof(c + 1) + "1r"
              pml$(m + 3) = ntof(c) + "2" + ntof(c + 1) + "1b"
              pml$(m + 4) = ntof(c) + "2" + ntof(c + 1) + "1n"       
              m = m + 4
            else
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + 1) + str$(d - 1) 
            endif
          endif
        endif
        if half_moves > 2 and c - 1 > 0 then
          if d = 4 and board(c - 1, 4) = 1 then
            control_board(c, d, c - 1, d - 1, -1)
            if wcb(bkf, bkr) = 0 and move_history$(half_moves) = ntof(c - 1) + "2" + ntof(c - 1) + "4" then 'en passant to the left
              m = m + 1
              pml$(m) = ntof(c) + "4" + ntof(c - 1) + "3"  
            endif
          endif
        endif
        if half_moves > 2 and c + 1 < 9 then
          if d = 4 and board(c + 1, 4) = 1 then
            control_board(c, d, c + 1, d - 1, -1)
            if wcb(bkf, bkr) = 0 and move_history$(half_moves) = ntof(c + 1) + "2" + ntof(c + 1) + "4" then 'en passant to the right
              m = m + 1
              pml$(m) = ntof(c) + "4" + ntof(c + 1) + "3"
            endif
          endif
        endif
      endif 
    next d
  next c
end sub

sub find_knight_moves(pc)
  for c = 1 to 8
    for d = 1 to 8
      if pc = 2 and board(c, d) = 2 then 'wknight
        for ii = 1 to 8 
          knight_directions()
          if e > 0 and e < 9 and f > 0 and f < 9 then
            control_board(c, d, e, f, 2)
            if board(e, f) <= 0 and bcb(wkf, wkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(e) + str$(f)
            endif
          endif
        next ii
      elseif pc = -2 and board(c, d) = -2 then 'bknight 
        for ii = 1 to 8 
          knight_directions()
          if e > 0 and e < 9 and f > 0 and f < 9 then
            control_board(c, d, e, f, -2)
            if board(e, f) >= 0 and wcb(bkf, bkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(e) + str$(f)
            endif
          endif
        next ii
      endif
    next d
  next c
end sub

sub knight_directions
  select case ii
    case 1 : e = c - 1 : f = d + 2
    case 2 : e = c + 1 : f = d + 2
    case 3 : e = c - 1 : f = d - 2
    case 4 : e = c + 1 : f = d - 2
    case 5 : e = c - 2 : f = d + 1
    case 6 : e = c - 2 : f = d - 1
    case 7 : e = c + 2 : f = d + 1
    case 8 : e = c + 2 : f = d - 1
  end select
end sub

sub find_bishop_moves(pc)
  for c = 1 to 8
    for d = 1 to 8
      if (pc = 3 and board(c, d) = 3) or (pc = 5 and board(c, d) = 5) then 'wbishop or wqueen
        for e = 1 to 7
          if c + e < 9 and d + e < 9 then
            control_board(c, d, c + e, d + e, pc)
            if board(c + e, d + e) <= 0 and bcb(wkf, wkr) = 0 then 
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + e) + str$(d + e)
            endif
          endif
          if c + e < 9 and d + e < 9 then
            if board(c + e, d + e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c + e < 9 and d - e > 0 then
            control_board(c, d, c + e, d - e, pc)
            if board(c + e, d - e) <= 0 and bcb(wkf, wkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + e) + str$(d - e)          
            endif
          endif
          if c + e < 9 and d - e > 0 then
            if board(c + e, d - e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c - e > 0 and d + e < 9 then
            control_board(c, d, c - e, d + e, pc)
            if board(c - e, d + e) <= 0 and bcb(wkf, wkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - e) + str$(d + e)
            endif
          endif
          if c - e > 0 and d + e < 9 then
            if board(c - e, d + e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c - e > 0 and d - e > 0 then
            control_board(c, d, c - e, d - e, pc)
            if board(c - e, d - e) <= 0 and bcb(wkf, wkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - e) + str$(d - e)
            endif
          endif
          if c - e > 0 and d - e > 0 then
            if board(c - e, d - e) <> 0 then exit for
          endif
        next e
      elseif (pc = -3 and board(c, d) = -3) or (pc = -5 and board(c, d) = -5) then 'bbishop or bqueen
        for e = 1 to 7
          if c + e < 9 and d + e < 9 then
            control_board(c, d, c + e, d + e, pc)
            if board(c + e, d + e) >= 0 and wcb(bkf, bkr) = 0 then 
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + e) + str$(d + e)
            endif
          endif
          if c + e < 9 and d + e < 9 then
            if board(c + e, d + e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c + e < 9 and d - e > 0 then
            control_board(c, d, c + e, d - e, pc)
            if board(c + e, d - e) >= 0 and wcb(bkf, bkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + e) + str$(d - e)          
            endif
          endif
          if c + e < 9 and d - e > 0 then
            if board(c + e, d - e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c - e > 0 and d + e < 9 then
            control_board(c, d, c - e, d + e, pc)
            if board(c - e, d + e) >= 0 and wcb(bkf, bkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - e) + str$(d + e)
            endif
          endif
          if c - e > 0 and d + e < 9 then
            if board(c - e, d + e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c - e > 0 and d - e > 0 then
            control_board(c, d, c - e, d - e, pc)
            if board(c - e, d - e) >= 0 and wcb(bkf, bkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - e) + str$(d - e)
            endif
          endif
          if c - e > 0 and d - e > 0 then
            if board(c - e, d - e) <> 0 then exit for
          endif
        next e
      endif
    next d
  next c
end sub

sub find_rook_moves(pc)
  for c = 1 to 8
    for d = 1 to 8
      if (pc = 4 and board(c, d) = 4) or (pc = 5 and board(c, d) = 5) then 'wrook or wqueen
        for e = 1 to 7
          if d + e < 9 then
            control_board(c, d, c, d + e, pc)
            if board(c, d + e) <= 0 and bcb(wkf, wkr) = 0 then  
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c) + str$(d + e)
            endif
          endif
          if d + e < 9 then
            if board(c, d + e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if d - e > 0 then
            control_board(c, d, c, d - e, pc)
            if board(c, d - e) <= 0 and bcb(wkf, wkr) = 0 then 
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c) + str$(d - e)
            endif
          endif
          if d - e > 0 then
            if board(c, d - e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c + e < 9 then
            control_board(c, d, c + e, d, pc)
            if board(c + e, d) <= 0 and bcb(wkf, wkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + e) + str$(d)
            endif
          endif
          if c + e < 9 then
            if board(c + e, d) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c - e > 0 then
            control_board(c, d, c - e, d, pc)
            if board(c - e, d) <= 0 and bcb(wkf, wkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - e) + str$(d)
            endif
          endif
          if c - e > 0 then
            if board(c - e, d) <> 0 then exit for
          endif
        next e
      elseif (pc = -4 and board(c, d) = -4) or (pc = -5 and board(c, d) = -5) then 'brook or bqueen
        for e = 1 to 7
          if d + e < 9 then
            control_board(c, d, c, d + e, pc)
            if board(c, d + e) >= 0 and wcb(bkf, bkr) = 0 then  
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c) + str$(d + e)
            endif
          endif
          if d + e < 9 then
            if board(c, d + e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if d - e > 0 then
            control_board(c, d, c, d - e, pc)
            if board(c, d - e) >= 0 and wcb(bkf, bkr) = 0 then 
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c) + str$(d - e)
            endif
          endif
          if d - e > 0 then
            if board(c, d - e) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c + e < 9 then
            control_board(c, d, c + e, d, pc)
            if board(c + e, d) >= 0 and wcb(bkf, bkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c + e) + str$(d)
            endif
          endif
          if c + e < 9 then
            if board(c + e, d) <> 0 then exit for
          endif
        next e
        for e = 1 to 7
          if c - e > 0 then
            control_board(c, d, c - e, d, pc)
            if board(c - e, d) >= 0 and wcb(bkf, bkr) = 0 then
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(c - e) + str$(d)
            endif
          endif
          if c - e > 0 then
            if board(c - e, d) <> 0 then exit for
          endif
        next e
      endif        
    next d
  next c
end sub

sub find_king_moves(pc)
  for c = 1 to 8
    for d = 1 to 8
      if pc = 6 and board(c, d) = 6 then 'wking
        for ii = 1 to 8
          king_directions()
          if e > 0 and e < 9 and f > 0 and f < 9 then
            control_board(c, d, e, f, 6)
            if board(e, f) <= 0 and bcb(e, f) = 0 then 
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(e) + str$(f)
            endif
          endif
        next ii
        if c = 5 and d = 1 and wkm = 0 and h1m = 0 and wc = 0 and board(6, 1) = 0 then
          control_board(c, d, c + 2, d, 6)
          if board(7, 1) = 0 and bcb(6, 1) = 0 and bcb(7, 1) = 0 then
            m = m + 1
            pml$(m) = ntof(c) + str$(d) + ntof(c + 2) + str$(d)
          endif
        endif
        if c = 5 and d = 1 and wkm = 0 and a1m = 0 and wc = 0 and board(4, 1) = 0 then
          control_board(c, d, c - 2, d, 6)
          if board(3, 1) = 0 and board(2, 1) = 0 and bcb(4, 1) = 0 and bcb(3, 1) = 0 then
            m = m + 1
            pml$(m) = ntof(c) + str$(d) + ntof(c - 2) + str$(d)
          endif
        endif
      elseif pc = -6 and board(c, d) = -6 then 'bking
        for ii = 1 to 8
          king_directions()
          if e > 0 and e < 9 and f > 0 and f < 9 then
            control_board(c, d, e, f, -6)
            if board(e, f) >= 0 and wcb(e, f) = 0 then 
              m = m + 1
              pml$(m) = ntof(c) + str$(d) + ntof(e) + str$(f)
            endif
          endif
        next ii
        if c = 5 and d = 8 and bkm = 0 and h8m = 0 and bc = 0 and board(6, 8) = 0 then
          control_board(c, d, c + 2, d, -6)
          if board(7, 8) = 0 and wcb(6, 8) = 0 and wcb(7, 8) = 0 then
            m = m + 1
            pml$(m) = ntof(c) + str$(d) + ntof(c + 2) + str$(d)
          endif
        endif
        if c = 5 and d = 8 and bkm = 0 and a8m = 0 and bc = 0 and board(4, 8) = 0 then
          control_board(c, d, c - 2, d, -6) 
          if board(3, 8) = 0 and board(2, 8) = 0 and wcb(4, 8) = 0 and wcb(3, 8) = 0 then
            m = m + 1
            pml$(m) = ntof(c) + str$(d) + ntof(c - 2) + str$(d)
          endif
        endif
      endif
    next d
  next c
end sub

sub king_directions
  select case ii
    case 1 : e = c + 1 : f = d + 1
    case 2 : e = c + 1 : f = d - 1
    case 3 : e = c - 1 : f = d + 1
    case 4 : e = c - 1 : f = d - 1
    case 5 : e = c : f = d + 1
    case 6 : e = c : f = d - 1
    case 7 : e = c + 1 : f = d
    case 8 : e = c - 1 : f = d
  end select
end sub

sub control_board(t1, t2, t3, t4, t5) 
  wkf = 0 : wkr = 0 : bkf = 0 : bkr = 0 : tsm$ = ""
  for i = 1 to 8
    for j = 1 to 8
      wcb(i, j) = 0 : bcb(i, j) = 0
      tboard(i, j) = board(i, j)
      if board(i, j) = 6 then wkf = i : wkr = j
      if board(i, j) = -6 then bkf = i : bkr = j
    next j
  next i

  if t1 = 5 and t2 = 1 and t3 = 7 and t4 = 1 then tsm$ = "WCK"  
  if t1 = 5 and t2 = 8 and t3 = 7 and t4 = 8 then tsm$ = "BCK"
  if t1 = 5 and t2 = 1 and t3 = 3 and t4 = 1 then tsm$ = "WCQ"
  if t1 = 5 and t2 = 8 and t3 = 3 and t4 = 8 then tsm$ = "BCQ"

  if t1 > 1 then
    if t2 = 5 and tboard(t1 - 1, 5) = -1 and t3 = t1 - 1 and t4 = 6 then
      if bhistory(t3, 7, half_moves - 1) = -1 then
        tsm$ = "WEPL"
      endif
    endif
  endif
  if t1 < 8 then 
    if t2 = 5 and tboard(t1 + 1, 5) = -1 and t3 = t1 + 1 and t4 = 6 then
      if bhistory(t3, 7, half_moves - 1) = -1 then
        tsm$ = "WEPR"
      endif
    endif
  endif
  if t1 > 1 then
    if t2 = 4 and tboard(t1 - 1, 5) = 1 and t3 = t1 - 1 and t4 = 3 then
      if bhistory(t3, 2, half_moves - 1) = 1 then
        tsm$ = "BEPL"
      endif
    endif
  endif
  if t1 < 8 then
    if t2 = 4 and tboard(t1 + 1, 5) = 1 and t3 = t1 + 1 and t4 = 3 then
      if bhistory(t3, 2, half_moves - 1) = 1 then 
        tsm$ = "BEPR"
      endif
    endif
  endif

  if t5 = 5 then tsm$ = "WPQ"
  if t5 = 4 then tsm$ = "WPR"
  if t5 = 3 then tsm$ = "WPB"
  if t5 = 2 then tsm$ = "WPN"
  if t5 = -5 then tsm$ = "BPQ" 
  if t5 = -4 then tsm$ = "BPR"
  if t5 = -3 then tsm$ = "BPB"
  if t5 = -2 then tsm$ = "BPN"

  select case sm$
    case ""
      tboard(t3, t4) = t5 'Will this fix the error below?
      'tboard(t3, t4) = tboard(t1, t2) 'error dimensions, possibly due to having a pawn one square away from queening square
      tboard(t1, t2) = 0
      'board(m3, m4) = board(m1, m2) 
      'board(m1, m2) = 0 
    case "WCK" : tboard(5, 1) = 0 : tboard(7, 1) = 6 : tboard(8, 1) = 0 : tboard(6, 1) = 4    
    case "WCQ" : tboard(5, 1) = 0 : tboard(3, 1) = 6 : tboard(1, 1) = 0 : tboard(4, 1) = 4
    case "BCK" : tboard(5, 8) = 0 : tboard(7, 8) = -6 : tboard(8, 8) = 0 : tboard(6, 8) = -4
    case "BCQ" : tboard(5, 8) = 0 : tboard(3, 8) = -6 : tboard(1, 8) = 0 : tboard(4, 8) = -4
    case "WEPL" : tboard(t1, t2) = 0 : tboard(t1 - 1, t2) = 0 : tboard(t1 - 1, t2 + 1) = 1
    case "WEPR" : tboard(t1, t2) = 0 : tboard(t1 + 1, t2) = 0 : tboard(t1 + 1, t2 + 1) = 1
    case "BEPL" : tboard(t1, t2) = 0 : tboard(t1 - 1, t2) = 0 : tboard(t1 - 1, t2 - 1) = -1
    case "BEPR" : tboard(t1, t2) = 0 : tboard(t1 + 1, t2) = 0 : tboard(t1 + 1, t2 - 1) = -1
    case "WPQ" : tboard(t3, 8) = 5 : tboard(t1, t2) = 0
    case "WPR" : tboard(t3, 8) = 4 : tboard(t1, t2) = 0
    case "WPB" : tboard(t3, 8) = 3 : tboard(t1, t2) = 0
    case "WPN" : tboard(t3, 8) = 2 : tboard(t1, t2) = 0
    case "BPQ" : tboard(t3, 1) = -5 : tboard(t1, t2) = 0
    case "BPR" : tboard(t3, 1) = -4 : tboard(t1, t2) = 0
    case "BPB" : tboard(t3, 1) = -3 : tboard(t1, t2) = 0
    case "BPN" : tboard(t3, 1) = -2 : tboard(t1, t2) = 0
  end select

  'tboard(t1, t2) = 0   'this was here before
  'tboard(t3, t4) = t5  'this was here before

  for i = 1 to 8
   for j = 1 to 8
    select case tboard(i, j)
     case 1 'wpawn
      if i - 1 > 0 and i - 1 < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i - 1, j + 1) = 1
      if i + 1 > 0 and i + 1 < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i + 1, j + 1) = 1
     case -1 'bpawn
      if i - 1 > 0 and i - 1 < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i - 1, j - 1) = 1
      if i + 1 > 0 and i + 1 < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i + 1, j - 1) = 1
     case 2 'wknight
      if i - 1 > 0 and i - 1 < 9 and j - 2 > 0 and j - 2 < 9 then wcb(i - 1, j - 2) = 1
      if i - 1 > 0 and i - 1 < 9 and j + 2 > 0 and j + 2 < 9 then wcb(i - 1, j + 2) = 1
      if i - 2 > 0 and i - 2 < 9 and j - 1 > 0 and j - 1 < 9 then wcb(i - 2, j - 1) = 1
      if i - 2 > 0 and i - 2 < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i - 2, j + 1) = 1
      if i + 1 > 0 and i + 1 < 9 and j - 2 > 0 and j - 2 < 9 then wcb(i + 1, j - 2) = 1
      if i + 1 > 0 and i + 1 < 9 and j + 2 > 0 and j + 2 < 9 then wcb(i + 1, j + 2) = 1
      if i + 2 > 0 and i + 2 < 9 and j - 1 > 0 and j - 1 < 9 then wcb(i + 2, j - 1) = 1
      if i + 2 > 0 and i + 2 < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i + 2, j + 1) = 1   
     case -2 'bknight
       if i - 1 > 0 and i - 1 < 9 and j - 2 > 0 and j - 2 < 9 then bcb(i - 1, j - 2) = 1
       if i - 1 > 0 and i - 1 < 9 and j + 2 > 0 and j + 2 < 9 then bcb(i - 1, j + 2) = 1
       if i - 2 > 0 and i - 2 < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i - 2, j - 1) = 1
       if i - 2 > 0 and i - 2 < 9 and j + 1 > 0 and j + 1 < 9 then bcb(i - 2, j + 1) = 1
       if i + 1 > 0 and i + 1 < 9 and j - 2 > 0 and j - 2 < 9 then bcb(i + 1, j - 2) = 1
       if i + 1 > 0 and i + 1 < 9 and j + 2 > 0 and j + 2 < 9 then bcb(i + 1, j + 2) = 1
       if i + 2 > 0 and i + 2 < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i + 2, j - 1) = 1
       if i + 2 > 0 and i + 2 < 9 and j + 1 > 0 and j + 1 < 9 then bcb(i + 2, j + 1) = 1   
      case 3 'wbishop
       for k = 1 to 7
        if i - k > 0 and j - k > 0 then
         wcb(i - k, j - k) = 1
         if tboard(i - k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 and j + k < 9 then
         wcb(i - k, j + k) = 1
         if tboard(i - k, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j - k > 0 then
         wcb(i + k, j - k) = 1
         if tboard(i + k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j + k < 9 then
         wcb(i + k, j + k) = 1
         if tboard(i + k, j + k) <> 0 then exit for
        endif
       next k
      case -3 'bbishop
       for k = 1 to 7
        if i - k > 0 and j - k > 0 then
         bcb(i - k, j - k) = 1
         if tboard(i - k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 and j + k < 9 then
         bcb(i - k, j + k) = 1
         if tboard(i - k, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j - k > 0 then
         bcb(i + k, j - k) = 1
         if tboard(i + k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j + k < 9 then
         bcb(i + k, j + k) = 1
         if tboard(i + k, j + k) <> 0 then exit for
        endif
       next k
      case 4 'wrook
       for k = 1 to 7
        if j - k > 0 then
         wcb(i, j - k) = 1 
         if tboard(i, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if j + k < 9 then
         wcb(i, j + k) = 1
         if tboard(i, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 then
         wcb(i - k, j) = 1
         if tboard(i - k, j) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 then
         wcb(i + k, j) = 1
         if tboard(i + k, j) <> 0 then exit for
        endif
       next k
      case -4 'brook
       for k = 1 to 7
        if j - k > 0 then
         bcb(i, j - k) = 1 
         if tboard(i, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if j + k < 9 then
         bcb(i, j + k) = 1
         if tboard(i, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 then
         bcb(i - k, j) = 1
         if tboard(i - k, j) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 then
         bcb(i + k, j) = 1
         if tboard(i + k, j) <> 0 then exit for
        endif
       next k
      case 5 'wqueen
       for k = 1 to 7
        if j - k > 0 then
         wcb(i, j - k) = 1 
         if tboard(i, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if j + k < 9 then
         wcb(i, j + k) = 1
         if tboard(i, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 then
         wcb(i - k, j) = 1
         if tboard(i - k, j) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 then
         wcb(i + k, j) = 1
         if tboard(i + k, j) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 and j - k > 0 then
         wcb(i - k, j - k) = 1
         if tboard(i - k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 and j + k < 9 then
         wcb(i - k, j + k) = 1
         if tboard(i - k, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j - k > 0 then
         wcb(i + k, j - k) = 1
         if tboard(i + k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j + k < 9 then
         wcb(i + k, j + k) = 1
         if tboard(i + k, j + k) <> 0 then exit for
        endif
       next k
      case -5 'bqueen
       for k = 1 to 7
        if j - k > 0 then
         bcb(i, j - k) = 1 
         if tboard(i, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if j + k < 9 then
         bcb(i, j + k) = 1
         if tboard(i, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 then
         bcb(i - k, j) = 1
         if tboard(i - k, j) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 then
         bcb(i + k, j) = 1
         if tboard(i + k, j) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 and j - k > 0 then
         bcb(i - k, j - k) = 1
         if tboard(i - k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i - k > 0 and j + k < 9 then
         bcb(i - k, j + k) = 1
         if tboard(i - k, j + k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j - k > 0 then
         bcb(i + k, j - k) = 1
         if tboard(i + k, j - k) <> 0 then exit for
        endif
       next k
       for k = 1 to 7
        if i + k < 9 and j + k < 9 then
         bcb(i + k, j + k) = 1
         if tboard(i + k, j + k) <> 0 then exit for
        endif
       next k
      case 6 'wking
       if i - 1 > 0 and i - 1 < 9 and j - 1 > 0 and j - 1 < 9 then wcb(i - 1, j - 1) = 1
       if i - 1 > 0 and i - 1 < 9 and j > 0 and j < 9 then wcb(i - 1, j) = 1
       if i - 1 > 0 and i - 1 < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i - 1, j + 1) = 1
       if i > 0 and i < 9 and j - 1 > 0 and j - 1 < 9 then wcb(i, j - 1) = 1
       if i > 0 and i < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i, j + 1) = 1
       if i + 1 > 0 and i + 1 < 9 and j - 1 > 0 and j - 1 < 9 then wcb(i + 1, j - 1) = 1
       if i + 1 > 0 and i + 1 < 9 and j > 0 and j < 9 then wcb(i + 1, j) = 1
       if i + 1 > 0 and i + 1 < 9 and j + 1 > 0 and j + 1 < 9 then wcb(i + 1, j + 1) = 1
      case -6 'bking
       if i - 1 > 0 and i - 1 < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i - 1, j - 1) = 1
       if i - 1 > 0 and i - 1 < 9 and j > 0 and j < 9 then bcb(i - 1, j) = 1
       if i - 1 > 0 and i - 1 < 9 and j + 1 > 0 and j + 1 < 9 then bcb(i - 1, j + 1) = 1
       if i > 0 and i < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i, j - 1) = 1
       if i > 0 and i < 9 and j + 1 > 0 and j + 1 < 9 then bcb(i, j + 1) = 1
       if i + 1 > 0 and i + 1 < 9 and j - 1 > 0 and j - 1 < 9 then bcb(i + 1, j - 1) = 1
       if i + 1 > 0 and i + 1 < 9 and j > 0 and j < 9 then bcb(i + 1, j) = 1
       if i + 1 > 0 and i + 1 < 9 and j + 1 > 0 and j + 1 < 9 then bcb(i + 1, j + 1) = 1
      end select
     next j
    next i  
end sub

sub check_for_check
  if whos_move = "W" then
    control_board(wkf, wkr, wkf, wkr, 6)
    if bcb(wkf, wkr) = 1 then
      check = 1
    else
      check = 0
    endif
  else
    control_board(bkf, bkr, bkf, bkr, -6)
    if wcb(bkf, bkr) = 1 then
      check = 1
    else
      check = 0
    endif
  endif
end sub

sub determine_result
  num_moves = 0 : im = 0 : tfr = 0 : fmr = 0 : ctr = 0 : repctr = 0 'added last statement
  tot_wpawns = 0 : tot_wknights = 0 : tot_wbishops = 0 : tot_wrooks = 0 : tot_wqueens = 0
  tot_bpawns = 0 : tot_bknights = 0 : tot_bbishops = 0 : tot_brooks = 0 : tot_bqueens = 0 
  generate_posmovelist() 

  if num_moves = 0 then check_for_check()

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
  if repctr > 3 then tfr = 1 'was > 2

  font 1 : color rgb(green), rgb(black)
  if whos_move$ = "B" and check = 1 and num_moves = 0 then
    checkmate = 1 : print @(0, 12) "Checkmate!"
    print @(0, 24) "White won" : another()
  endif
  if whos_move$ = "W" and check = 1 and num_moves = 0 then
    checkmate = -1 : print @(0, 12) "Checkmate!"
    print @(0, 24) "Black won" : another()
  endif
  if check = 0 and num_moves = 0 then
    draw = 1 : print @(0, 12) "Draw by"
    print @(0, 24) "Stalemate" : another()
  endif
  if im = 1 then
    draw = 1 : print @(0, 12) "Draw by" : print @(0, 24) "Insufficient"
    print @(0, 36) "Material" : another()
  endif
  if tfr = 1 then 'Need to test this
    draw = 1 : print @(0, 12) "Draw by" : print @(0, 24) "Three fold"
    print @(0, 36) "repetition" : another()
  endif
  if fmr_ctr > 99 then
    draw = 1 : print @(0, 12) "Draw by"
    print @(0, 24) "Fifty Moves" : another()
  endif
end sub

sub another
  pause 4000 : print @(0, 60) "New game?" : input a$
  if a$ = "y" or a$ = "Y" or a$ = "yes" or a$ = "YES" then
    goto newg:
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
  
  if level = 1 then
    z = int(rnd * num_moves) + 1  
    move$ = pml$(z) 
  elseif level = 2 then
    level2()
  endif

  if whos_move$ = "W" then
    print @(0, 12) "White's move"
  else 
    print @(0, 12) "Black's move"
  endif
  print @(0, 24) "is ";move$;"   ";
end sub

sub level2
  score = 0 : hscore = 0 : hpml = 1
  for z = 1 to num_moves
    m1 = fton(lcase$(left$(pml$(z), 1))) 
    m2 = val(mid$(pml$(z), 2, 1))
    m3 = fton(lcase$(mid$(pml$(z), 3, 1)))
    m4 = val(mid$(pml$(z), 4, 1))
    m5$ = lcase$(mid$(pml$(z), 5, 1))
    select case abs(board(m3, m4))
      case 1 : score = 1
      case 2 : score = 3
      case 3 : score = 3.25
      case 4 : score = 5
      case 5 : score = 9         
    end select
    if m5$ = "q" then score = score + 8 
    if score > hscore then hscore = score : hpml = z
    score = 0 : m5$ = ""
  next z
  if hscore > 0 then  
    move$ = pml$(hpml)
  else
    z = int(rnd * num_moves) + 1
    move$ = pml$(z)
  endif   
end sub

