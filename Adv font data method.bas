'Adventure --> retrieve the goblet and take it to the yellow castle to win
'Use the wall character with a new font 20x50 size
'Just need wall, portculis, barrier black line, barrier/wall (c) characters
'Make their chr$() values equal to w, p, b, and c
dim integer i w, x, y, room, nrc, src, wrc, erc, misc, c, con(100)
dim integer start$ length 4, type$ length 40
dim integer r(30,40,12)
#include "colors.inc"
mode 1, 16 : cls LightGray
load font "BAR 20x50.fnt"
font 8

'Idea: Possibly read the data into a three dimensional array (room, x, y)
'0 = Light, 1 = Dark, 2 = Left barrier, 3 = Right barrier, 4 = Castle gate down, 5 = gate up
'1 = Yellow, 2 = White, 3 = Black, 4 = Olive, 5 = Blue, 6 = OrangeRed, 7 = LightBlue,
'8 = Purple, 9 = Red, 10 = Green, 11 = LightGreen, 12 = Aquamarine, 13 = Orange
'DATA room, Ncr, Scr, Wcr, Ecr, darkbarriergate 0/1/2/3/4/5, color,
'     start with wall/empty, characters in a row, CIAR, CIAR, etc..., 0 (end of room) 

do while room <> 0
  for w = 1 to 31 'numbers of rooms + 1
    read room, nrc, src, wrc, erc, misc, c
    for y = 1 to 7 'number of vertical data statements per room
      read start$, con(1), con(2), con(3), con(4), con(5), con(6), con(7), con(8)
      for i = 1 to 100 'number of "consecutive numbers in data statement
        for j = 1 to con(i) 'conecutive characters numbered
          if something then        
            type$ = type$ + "e"
          else
            type$ = type$ + "w"
          endif
        next j
      next i
      for x = 1 to 40 'horizontal location within a room 
        if type$(x) = "e" then
          r(w, x, y) = 0 'empty space
        elseif type$(x) = "w" then
          r(w, x, y) = 1 'wall block
        elseif type$(x) = "be" then
          r(w, x, y) = 2 'barrier/empty space
        elseif type$(x) = "bw" then
          r(w, x, y) = 3 'barrier/wall
        elseif type$(x) = "wg" then
          r(w, x, y) = 4 'W castle gate 
        elseif type$(x) = "eg" then
          r(w, x, y) = 5 'E castle gate
        endif
      next x
    next y
  next w
loop
                                       
sub rooms
  'Yellow castle
  data 1,8,11,0,0,5,1
  data "w",11,1,1,1,1,1,1,6,1,1,1,1,1,1,11 '1 row
  data "w",2,8,7,6,7,8,2 '2 rows
  data "w",2,8,20,8,2 '2 rows
  data "w",2,10,16,10,2 '2 rows
  data "w",2,10,6,4,6,10,2 '2 rows
  data "w",2,36,2 '2 rows
  data "w",16,8,16 '1 row
  'White castle
  data 2,21,14,0,0,4,2,
  data "w",11,1,1,1,1,1,1,6,1,1,1,1,1,1,11
  data "w",2,8,7,6,7,8,2
  data "w",2,8,20,8,2
  data "w",2,10,16,10,2
  data "w",2,10,6,4,6,10,2
  data "w",2,36,2
  data "w",16,8,16
  'Black castle
  data 3,10,26,0,0,4,3
  data "w",11,1,1,1,1,1,1,6,1,1,1,1,1,1,11
  data "w",2,8,7,6,7,8,2
  data "w",2,8,20,8,2
  data "w",2,10,16,10,2
  data "w",2,10,6,4,6,10,2
  data "w",2,36,2
  data "w",16,8,16
  'North of catacombs
  data 4,0,15,11,12,3,4
  data "w",40
  data "e5",40
  data "w",16,8,13,1,2,0
  'East of catacombs
  data 5,8,6,17,0,3,5
  data "w",16,8,13,1,2
  data "e5",40
  data "w",16,8,13,1,2,0
  'Southeast of catacombs
  data 6,5,0,0,0,0,6,"w",16,8,16,"w5",1,38,1,"w",40,0
  'Southwest of catacombs
  data 7,14,0,0,0,0,7,"w",16,8,16,"w5",1,38,1,"w",40,0
  'Inside yellow castle
  data 8,0,1,0,0,0,1,"w",40,"w5",1,38,1,"w",16,8,16,0
  'Northeast of catacombs
  data 8,0,5,0,0,0,8,"w",40,"w5",1,38,1,"w",16,8,16,0
  'Inside black castle
  data 10,30,3,0,0,0,9,"w",16,8,16,"w5",1,38,1"w",16,8,16,0
  'South of yellow castle
  data 11,1,0,13,4,0,10,"w"16,8,16,"e5",40,"w",40,0
  'Warren room
  data 12,0,0,4,13,0,8,"w"16,8,16,"e5",40,"w",40,0
  'South of blue maze
  data 13,25,0,0,11,2,11,"w",16,8,16,"e5",40,"w",40,0
  'South of white castle
  data 14,2,7,0,17,2,12,"w",16,8,16,"e5",40,"w",16,8,16,0
  'North catacombs
  data 15,4,16,16,16,1,13,"w"16,8,16,"e",6,2,24,2,6,"w",4,2,2,4,16,4,2,2,4,"e",6,2,10,4,10,2,6,
       "w",8,2,2,6,4,6,2,2,8,"e",10,2,6,4,6,2,10,"w",12,2,2,2,4,2,2,2,12,0
  'Central catacombs
  data 16,15,17,15,15,1,13,"w",12,2,2,2,4,2,2,2,12,"e",14,2,2,4,2,2,14,"w",4,6,6,2,4,2,6,6,4,
       "e",10,2,16,2,10,"w",8,2,2,2,12,2,2,2,8,"e",6,2,2,2,2,2,8,2,2,2,2,2,6,
       "w",4,2,2,2,2,2,2,2,4,2,2,2,2,2,2,2,4,0
  'South catacombs
  data 17,16,0,14,5,1,13,"w",4,2,2,2,2,2,2,2,4,2,2,2,2,2,2,2,4,"e",6,2,6,2,2,4,2,2,6,2,6,
       "e",6,6,2,2,2,4,2,2,2,6,6,"e",18,4,18,"e",6,8,4,4,4,8,6,"e",6,2,10,4,10,2,6,"w",40,0
  'Northwest white castle
  data 18,0,20,19,19,0,6,"w",40,"e",40,"w",16,8,16,"e",14,2,8,2,14,"w",12,2,2,8,2,2,12,
       "w",4,6,2,2,2,2,4,2,2,2,2,6,4,"w",4,2,2,2,6,2,4,2,6,2,2,2,4,0
  'Northeast white castle
  data 19,0,21,18,18,0,6,"w",40,"e",18,4,18,"w",16,2,4,2,16,"e",14,2,2,4,2,2,14,
       "w",4,2,2,2,20,2,2,2,4,"w",4,2,2,2,2,16,2,2,2,2,4,"w",4,2,6,2,2,8,2,2,6,2,4,0
  'Southwest white castle
  data 20,18,0,21,21,0,6,"w",4,2,2,2,6,2,4,2,6,2,2,2,4,"w",4,2,2,24,2,2,4,"w",4,2,2,2,20,2,2,2,4,
       "e",6,2,2,2,16,2,2,2,6,"w",12,16,12,"e",40,"w",16,8,16,0
  'Southeast white castle
  data 21,19,2,20,20,0,6,"w",4,2,6,2,2,8,2,2,6,2,4,"w",4,10,2,8,2,10,4,"w",16,8,16,
       "e",6,2,24,2,6,"w",4,2,2,24,2,2,4,"e",6,2,24,2,6,"w",16,8,16,0
  'Northwest blue maze
  data 22,24,24,23,23,0,5,"w",40,"e",40,"w",10,2,16,2,10,"w",4,14,4,14,4,"w",4,2,10,2,4,2,10,2,4,
       "e",6,2,6,2,2,4,2,2,6,2,6,"w",8,2,2,2,2,2,4,2,2,2,2,2,8,0
  'Northeast blue maze
  data 23,0,25,22,22,0,5,"w",8,2,2,2,2,8,2,2,2,2,8,"e",6,2,6,2,8,2,6,2,6,"w",4,2,10,8,10,2,4,
       "w",4,32,4,"w",8,24,8,"e",6,2,24,2,6,"w",40,0
  'Southwest blue maze
  data 24,22,22,25,25,0,5,"w",4,2,2,2,8,4,8,2,2,2,4,"e",6,2,6,4,4,4,2,2,2,"w",12,2,4,4,4,2,12,
       "e",10,2,2,4,4,4,2,2,10,"w",4,2,2,2,2,2,4,4,4,2,2,2,2,2,4,
       "e",6,2,2,2,2,2,8,2,2,2,2,2,6,"w",8,2,2,2,2,8,2,2,2,2,8,0
  'Southeast blue maze
  data 25,22,13,24,24,0,5,"w"8,2,2,2,2,2,4,2,2,2,2,2,8,"e",6,2,2,2,2,2,8,2,2,2,2,2,6,
       "w",4,2,2,2,2,2,12,2,2,2,2,2,4,"e",6,2,2,2,16,2,2,2,6,"w",8,2,20,2,8,"e",40,"w",16,8,16,0
  'North blue maze
  data 26,3,23,24,24,0,5,"w",16,8,16,"e",8,2,4,2,8,2,4,2,8,"w",4,4,2,4,4,4,4,4,2,4,4,
       "w",4,4,2,20,2,4,4,"w",18,4,18,"e",6,2,8,2,4,2,8,2,6,"w",4,2,2,2,8,4,8,2,2,2,4,0
  'Northwest black castle
  data 27,0,29,30,28,1,13,"w",8,4,16,4,8,"e",12,2,12,2,12,"w",14,12,14,"e",40,"w",2,4,28,4,2,
       "e",6,2,24,2,6,"w",8,4,16,4,8,0
  'Northeast black castle
  data 28,0,30,27,29,1,13,"w",40,"e",18,2,18,2,"w",16,2,18,2,2,"e",14,2,18,2,4,"w",4,4,16,4,12,
       "e",8,4,6,2,8,4,6,2,"w",2,2,2,2,4,2,2,2,4,2,2,2,4,2,2,2,2,0
  'Southwest black castle
  data 29,27,27,28,30,1,13,"w",8,4,16,4,8,"w",2,18,2,18,"w",2,4,16,4,14,"e",6,2,18,2,12,
       "w",8,4,16,4,8,"w",2,10,2,6,2,10,2,6,"w",8,4,16,4,8,0
  'Southeast black castle
  data 30,28,10,29,29,1,13,"w",2,2,2,2,4,2,2,2,4,2,2,2,4,2,2,2,2,"e",4,2,8,2,2,4,2,2,8,2,4,
       "w",16,8,16,"e",40,"w",16,8,16,"e",40,"w",16,8,16,0
  data 0
end sub

do : loop while keydown(1) <> 32
















































































































