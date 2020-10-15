'Adventure --> retrieve the goblet and take it to the yellow castle to win
'Use the wall character with a new font 20x50 size
'Just need wall, portculis, barrier black line, barrier/wall (c) characters
'Make their chr$() values equal to w, p, b, and c
dim integer i, r, start = 1
#include "colors.inc"
mode 1, 8 : cls : load font "BAR 20x50.fnt" : font 8

do
  if start = 1 then
    'r = 1
    'draw(1, Yellow, LightGray, Black)
    r = 31
    draw(31, Yellow, LightGray, Black)
    start = 0
  endif

  if keydown(1) = 128 and keydown(1) = 130 then 'cursor up and left
    pause 50
  elseif keydown(1) = 128 and keydown(1) = 131 then 'cursor up and right
    pause 50
  elseif keydown(1) = 129 and keydown(1) = 130 then 'cursor down and left
    pause 50
  elseif keydown(1) = 129 and keydown(1) = 131 then 'cursor down and right
    pause 50
  elseif keydown(1) = 32 then 'space bar, drop object
    pause 50
  elseif keydown(1) = 128 then 'cursor up
    select case r
      case 1 'Yellow castle 
        r = 8
        draw(8, Yellow, LightGray) 
      case 2 'White castle
        r = 21
        draw(21, OrangeRed, LightGray) 'Southeast White castle 
      case 3 'Black castle
        r = 10
        draw(10, Red, LightGray) 'Inside Black castle  
      case 5 'East of catacombs
        r = 9
        draw(9, Purple, LightGray) 'Northeast of catacombs
      case 6 'Southeast of catacombs
        r = 5
        draw(5, Blue, LightGray, Black) 'East of catacombs
      case 7 'Southwest of catacombs
        r = 14
        draw(14, Aquamarine, LightGray, Black) 'South of White castle
      case 10 'Inside Black castle
        r = 30
        draw(30, Orange, Black) 'Southeast Black castle
      case 11 'South of Yellow castle
        r = 1
        draw(1, Yellow, LightGray, Black) 'Yellow castle
      case 13 'South of Blue maze
        r = 25
        draw(25, Blue, LightGray) 'Southeast Blue maze
      case 14 'South of White castle
        r = 2
        draw(2, White, LightGray, Black) 'White castle
      case 15 'North catacombs
        r = 4
        draw(4, Olive, LightGray, Black) 'North of catacombs
      case 16 'Central catacombs
        r = 15
        draw(15, Orange, Black) 'North catacombs
      case 17 'South catacombs
        r = 16
        draw(16, Orange, Black) 'Central catacombs
      case 20 'Southwest White castle
        r = 18
        draw(18, OrangeRed, LightGray) 'Northwest White castle
      case 21 'Southeast White castle
        r = 19
        draw(19, OrangeRed, LightGray) 'Northeast White castle
      case 23 'Northeast Blue Maze
        r = 24
        draw(24, Blue, LightGray) 'Southwest Blue maze
      case 24 'Southwest Blue maze
        r = 26
        draw(26, Blue, LightGray) 'North Blue maze
      case 25 'Southeast Blue maze
        r = 22
        draw(22, Blue, LightGray) 'Northeast Blue maze
      case 26 'North Blue maze
        r = 3
        draw(3, Black, LightGray, Black) 'Black castle
      case 27 'Northwest Black castle
        r = 29
        draw(29, Orange, Black) 'Southwest black castle
      case 29 'Southwest Black castle
        r = 27
        draw(27, Orange, Black) 'Northwest Black castle
      case 30 'Southeast Black castle
        r = 28
        draw(28, Orange, Black) 'Northeast Black castle
      case 31 'Yellow castle 2
        r = 32
        draw(32, Yellow, LightGray)
      'case 32 'Inside yc2
      '  pause 50
      case 33 'S of yc2
        r = 31
        draw(31, Yellow, LightGray, Black)
      case 34 '2S of yc2
        r = 33
        draw(33, Yellow, LightGray)
      case 35 'W of yc2
        r = 38
        draw(38, Cyan, LightGray)
      case 36 'SW of yc2
        r = 35
        draw(35, Cyan, LightGray)
      case 37 '1W, 2S of yc2
        r = 36
        draw(36, Yellow, LightGray)
      case 38 '2W, 2S of yc2
        r = 39
        draw(39, Yellow, LightGray)
      case 39 '2W, 1S of yc2
        r = 40
        draw(40, Yellow, LightGray)
      case 40 '2W of yc2
        r = 41
        draw(41, Yellow, LightGray)
      case 41 '2W, 1N of yc2
        r = 42
        draw(42, Green, LightGray)
      case 42 '2W, 2N of yc2
        r = 43
        draw(43, Green, LightGray)
      case 43 '2W, 3N of yc2
        r = 44
        draw(44, Green, LightGray)
      case 45 '1W, 3N of yc2
        r = 46
        draw(46, Green, LightGray)
      case 46 '1W, 4N of yc2
        r = 66
        draw(66, Green, LightGray)
      case 47 '1W, 5N of yc2
        r = 48
        draw(48, Orange, Black)
      case 48 '1W, 6N of yc2
        r = 49
        draw(49, Yellow, LightGray)
      case 50 '1W, 9N of yc2
        r = 51
        draw(51, Orange, Black)
      case 51 '1W, 10N of yc2
        r = 52
        draw(52, Red, LightGray)
      case 55 'Red Castle 2
        r = 54
        draw(54, Red, LightGray)
      case 56 '1S of rc2
        r = 55
        draw(55, Red, LightGray, Black)
      case 57 '2S of rc2
        r = 56
        draw(56, Red, LightGray)
      case 58 '3S of rc2
        r = 57
        draw(57, Red, LightGray)
      case 61 '5N of gc2
        r = 62
        draw(62, Orange, Black)
      case 62 '6N of gc2
        r = 50
        draw(50, Orange, Black)
      case 63 '2N of gc2
        r = 60
        draw(60, White, LightGray)
      case 64 'N of gc2
        r = 62
        draw(62, Orange, Black)
      case 65 'Green Castle 2
        r = 64
        draw(64, Orange, Black)
      case 66 'S of gc2
        r = 65
        draw(65, Green, LightGray, Black)
      case 68 'N of bc2
        r = 67
        draw(67, White, LightGray)
      case 69 'Blue Castle 2
        r = 68
        draw(68, White, LightGray)
      case 70 'S of bc2
        r = 69
        draw(69, Blue, LightGray, Black)
      case 71 'SW of bc2
        r = 70
        draw(70, Blue, LightGray)
      case 72 '2S, 1W of bc2
        r = 71
        draw(71, Blue, LightGray)
      case 73 '2S, 2W of bc2
        r = 74
        draw(74, Blue, LightGray)
      case 74 '1S, 2W of bc2
        r = 73
        draw(73, Blue, LightGray)
      case 75 'NE of bc2
        r = 76
        draw(76, White, LightGray)
    end select        
  elseif keydown(1) = 129 then 'cursor down
    select case r 'room number
      case 1 'Yellow castle
        r = 11 
        draw(11, Green, LightGray)  
      case 2 'White castle
        r = 14
        draw(14, Aquamarine, LightGray, Black) 
      case 3 'Black castle
        r = 26
        draw(26, Blue, LightGray)
      case 4 'North of catacombs
        r = 15
        draw(15, Orange, Black) 
      case 5 'East of catacombs
        r = 6
        draw(6, LightBlue, LightGray)
      case 8 'Inside Yellow castle
        r = 1
        draw(1, Yellow, LightGray, Black)
      case 9 'Northeast of catacombs
        r = 5
        draw(5, Blue, LightGray, Black)
      case 10 'Inside Black castle
        r = 3
        draw(3, Black, LightGray, Black)
      case 14 'South of White castle
        r = 7
        draw(7, LightBlue, LightGray)
      case 15 'North catacombs
        r = 16
        draw(16, Orange, Black)
      case 16 'Central catacombs
        r = 17
        draw(17, Orange, Black)
      case 18 'Northwest White castle
        r = 20
        draw(20, OrangeRed, LightGray)
      case 19 'Northeast White castle
        r = 21
        draw(21, OrangeRed, LightGray)
      case 21 'Southeast White castle
        r = 2
        draw(2, White, LightGray, Black)
      case 22 'Northwest Blue maze
        r = 24
        draw(24, Blue, LightGray)
      case 23 'Northeast Blue maze
        r = 25
        draw(25, Blue, LightGray)
      case 24 'Southwest Blue maze
        r = 23
        draw(23, Blue, LightGray)
      case 25 'Southeast Blue maze
        r = 13
        draw(13, LightGreen, LightGray, Black)
      case 26 'North Blue maze
        r = 24
        draw(24, Blue, LightGray)
      case 27 'Northwest Black castle
        r = 29
        draw(29, Orange, Black)
      case 28 'Northeast Black castle
        r = 30
        draw(30, Orange, Black)
      case 29 'Southwest Black castle
        r = 29
        draw(29, Orange, Black)
      case 30 'Southeast Black castle
        r = 10
        draw(10, Red, LightGray)
      case 31 'Yellow castle 2
        r = 33
        draw(10, Yellow, LightGray)
      case 32 'Inside yc2
        r = 31
        draw(31, Yellow, LightGray, Black)
      case 33 'S of yc2
        r = 34
        draw(34, Yellow, LightGray)
      case 35 'W of yc2
        r = 36
        draw(36, Yellow, LightGray)
      case 36 'SW of yc2
        r = 37
        draw(37, Yellow, LightGray)
      case 38 '2W, 2S of yc2
        r = 35
        draw(35, Cyan, LightGray)
      case 39 '2W, 1S of yc2
        r = 38
        draw(38, Cyan, LightGray)
      case 40 '2W of yc2
        r = 39
        draw(39, Yellow, LightGray)
      case 41 '2W, 1N of yc2
        r = 40
        draw(40, Yellow, LightGray)
      case 42 '2W, 2N of yc2
        r = 41
        draw(41, Yellow, LightGray)
      case 43 '2W, 3N of yc2
        r = 42
        draw(42, Green, LightGray)
      case 44 '2W, 4N of yc2 
        r = 43
        draw(43, Green, LightGray)
      case 46 '1W, 4N of yc2
        r = 45
        draw(45, Green, LightGray)
      case 47 '1W, 5N of yc2
        r = 46
        draw(46, Green, LightGray)
      case 48 '1W, 6N of yc2
        r = 47
        draw(47, Orange, Black)
      case 49 '1W, 7N of yc2
        r =48
        draw(48, Orange, Black)
      case 50 '1W, 9N of yc2
        r = 62
        draw(62, Orange, Black)
      case 51 '1W, 10N of yc2
        r = 50
        draw(50, Orange, Black)
      case 52 '1W, 11N of yc2
        r = 51
        draw(51, Orange, Black)
      case 54 '3W, 11N of yc2
        r = 55
        draw(55, Red, LightGray, Black)
      case 55 'Red Castle 2
        r = 56
        draw(56, Red, LightGray)
      case 56 '1S of rc2
        r = 57
        draw(57, Red, LightGray)
      case 57 '2S of rc2
        r = 58
        draw(58, Red, LightGray)
      case 60 '3N of gc2
        r = 63
        draw(63, Orange, Black)
      case 63 '2N of gc2
        r = 64
        draw(64, Orange, Black)
      case 64 'N of gc2
        r = 65
        draw(65, Green, LightGray)
      case 65 'Green Castle 2
        r = 66
        draw(66, Green, LightGray)
      case 66 'S of gc2
        r = 46
        draw(46, Green, LightGray)
      case 67 '2N of bc2
        r = 68
        draw(68, White, LightGray, Black)
      case 68 'N of bc2
        r = 69
        draw(69, Blue, LightGray, Black)
      case 69 'Blue Castle 2
        r = 70
        draw(70, Blue, LightGray)
      case 70 'S of bc2
        r = 71
        draw(71, Blue, LightGray)
      case 71 'SW of bc2
        r = 72
        draw(72, Blue, LightGray)
      case 73 '2S, 2W of bc2
        r = 74
        draw(74, Blue, LightGray)
      case 74 '1S, 2W of bc2
        r = 73
        draw(73, Blue, LightGray)
    end select              
  elseif keydown(1) = 130 then 'cursor left
    select case r 'room number
      case 4 'North of catacombs
        r = 11
        draw(11, Green, LightGray) 
      case 5 'East of catacombs
        r = 17
        draw(17, Orange, Black)
      case 11 'South of Yellow castle
        r = 13
        draw(13, LightGreen, LightGray, Black)
      case 12 'Warren Room
        r = 4
        draw(4, Olive, LightGray, Black)
      case 15 'North catacombs
        r = 16
        draw(16, Orange, Black)
      case 16 'Central catacombs
        r = 15
        draw(15, Orange, Black)
      case 17 'South catacombs
        r = 14
        draw(14, Aquamarine, LightGray, Black)
      case 18 'Northwest White castle
        r = 19
        draw(19, OrangeRed, LightGray)
      case 19 'Northeast White castle
        r = 18
        draw(18, OrangeRed, LightGray)
      case 20 'Southwest White castle
        r = 21
        draw(21, OrangeRed, LightGray)
      case 21 'Southeast White castle
        r = 20
        draw(20, OrangeRed, LightGray)
      case 22 'Northwest Blue maze
        r = 23
        draw(23, Blue, LightGray)
      case 23 'Northeast Blue maze
        r = 22
        draw(22, Blue, LightGray)
      case 24 'Southwest Blue maze
        r = 25
        draw(25, Blue, LightGray)
      case 25 'Southeast Blue maze
        r = 24
        draw(24, Blue, LightGray)
      case 26 'North Blue maze
        r = 22
        draw(22, Blue, LightGray)
      case 27 'Northwest Black castle
        r = 30
        draw(30, Orange, Black)
      case 28 'Northeast Black castle
        r = 29
        draw(29, Orange, Black)
      case 29 'Southwest Black castle
        r = 30
        draw(30, Orange, Black)
      case 30 'Southeast Black castle
        r = 29
        draw(29, Orange, Black)
      case 33 'S of yc2
        r = 36
        draw(36, Yellow, LightGray)
      case 34 '2S of yc2
        r = 37
        draw(37, Yellow, LightGray)
      case 35 'W of yc2
        r = 40
        draw(40, Yellow, LightGray)
      case 36 'SW of yc2
        r = 39
        draw(39, Yellow, LightGray)
      case 37 '1W, 2S of yc2
        r = 38
        draw(38, Cyan, LightGray)
      case 40 '2W of yc2
        r = 33
        draw(33, Yellow, LightGray)
      case 43 '2W, 3N of yc2
        r = 44
        draw(44, Green, LightGray)
      case 45 '1W, 3N of yc2
        r = 43
        draw(43, Green, LightGray)
      case 47 '1W, 5N of yc2
        r = 63
        draw(63, Orange, Black)
      case 49 '1W, 7N of yc2
        r = 59
        draw(59, Red, LightGray)
      case 50 '1W, 9N of yc2
        r = 62
        draw(62, Orange, Black)
      case 52 '1W, 11N of yc2
        r = 53
        draw(53, Red, LightGray)
      case 53 '2W, 11N of yc2
        r = 54
        draw(54, Red, LightGray)
      case 56 '1S of rc2
        r = 57
        draw(57, Red, LightGray)
      case 58 '3S of rc2
        r = 56
        draw(56, Red, LightGray)
      case 59 '3S, 1E of rc2
        r = 58
        draw(58, Red, LightGray)
      case 60 '3N of gc2
        r = 49
        draw(49, Yellow, LightGray)
      case 61 '5N of gc2
        r = 50
        draw(50, Orange, Black)
      case 62 '6N of gc2
        r = 51
        draw(51, Orange, Black)
      case 63 '2N of gc2
        r = 48
        draw(48, Orange, Black)
      case 64 'N of gc2
        r = 47
        draw(47, Orange, Black)
      case 65 'Green Castle 2
        r = 46
        draw(46, Green, LightGray)
      case 66 'S of gc2
        r = 45
        draw(45, Green, LightGray)
      case 70 'S of bc2
        r = 71
        draw(71, Blue, LightGray)
      case 71 'SW of bc2
        r = 74
        draw(74, Blue, LightGray)
      case 72 '2S, 1W of bc2
        r = 73
        draw(73, Blue, LightGray)
      case 73 '2S, 2W of bc2
        r = 60
        draw(60, White, LightGray)
      case 74 '1S, 2W of bc2
        r = 72
        draw(72, Blue, LightGray)
      case 75 'NE of bc2
        r = 68
        draw(68, White, LightGray, Black)
      case 76 '2N, 1E of bc2
        r = 67
        draw(67, White, LightGray)
      case 77 '2N, 2E of bc2
        r = 76
        draw(76, White, LightGray)
    end select          
  elseif keydown(1) = 131 then 'cursor right
    select case r 'room number
      case 4 'North of catacombs
        r = 12
        draw(12, Purple, LightGray) 
      case 11 'South of Yellow castle
        r = 4
        draw(4, Olive, LightGray, Black)
      case 12 'Warren Room
        r = 13
        draw(13, LightGreen, LightGray, Black)
      case 13 'South of Blue maze
        r = 11
        draw(11, Green, LightGray)
      case 14 'South of White castle
        r = 17
        draw(17, Orange, Black)
      case 15 'North catacombs
        r = 16
        draw(16, Orange, Black)
      case 16 'Central catacombs
        r = 15
        draw(15, Orange, Black)
      case 17 'South catacombs
        r = 5
        draw(5, Blue, LightGray, Black)
      case 18 'Northwest White castle
        r = 19
        draw(19, OrangeRed, LightGray)
      case 19 'Northeast White castle
        r = 18
        draw(18, OrangeRed, LightGray)
      case 20 'Southwest White castle
        r = 21
        draw(21, OrangeRed, LightGray)
      case 21 'Southeast White castle
        r = 20
        draw(20, OrangeRed, LightGray)
      case 22 'Northwest Blue maze
        r = 23
        draw(23, Blue, LightGray)
      case 23 'Northeast Blue maze
        r = 22
        draw(22, Blue, LightGray)
      case 24 'Southwest Blue maze
        r = 25
        draw(25, Blue, LightGray)
      case 25 'Southeast Blue maze
        r = 24
        draw(24, Blue, LightGray)
      case 26 'North Blue maze
        r = 19
        draw(19, Blue, LightGray)
      case 27 'Northwest Black castle
        r = 28
        draw(28, Orange, Black)
      case 28 'Northeast Black castle
        r = 29
        draw(29, Orange, Black)
      case 29 'Southwest Black castle
        r = 30
        draw(30, Orange, Black)
      case 30 'Southeast Black castle
        r = 27
        draw(27, Orange, Black)
      case 33 'S of yc2
        r = 40
        draw(40, Yellow, LightGray)
      case 35 'W of yc2
        r = 31
        draw(31, Yellow, LightGray, Black)
      case 36 'SW of yc2
        r = 33
        draw(33, Yellow, LightGray)
      case 37 '1W, 2S of yc2
        r = 34
        draw(34, Yellow, LightGray)
      case 38 '2W, 2S of yc2
        r = 37
        draw(37, Yellow, LightGray)
      case 39 '2W, 1S of yc2
        r = 36
        draw(36, Yellow, LightGray)
      case 40 '2W of yc2
        r = 35
        draw(35, Cyan, LightGray)
      case 43 '2W, 3N of yc2
        r = 45
        draw(45, Green, LightGray)
      case 44 '2W, 4N of yc2 
        r = 43
        draw(43, Green, LightGray)
      case 45 '1W, 3N of yc2
        r = 66
        draw(66, Green, LightGray)
      case 46 '1W, 4N of yc2
        r = 65
        draw(65, Green, LightGray, Black)
      case 47 '1W, 5N of yc2
        r = 64
        draw(64, Orange, Black)
      case 48 '1W, 6N of yc2
        r = 63
        draw(63, Orange, Black)
      case 49 '1W, 7N of yc2
        r = 60
        draw(60, White, LightGray)
      case 50 '1W, 9N of yc2
        r = 61
        draw(61, Red, LightGray)
      case 51 '1W, 10N of yc2
        r = 62
        draw(62, Orange, Black)
      case 53 '2W, 11N of yc2
        r = 52
        draw(52, Red, LightGray)
      case 54 '3W, 11N of yc2
        r = 53
        draw(53, Red, LightGray)
      case 56 '1S of rc2
        r = 58
        draw(58, Red, LightGray)
      case 57 '2S of rc2
        r = 56
        draw(56, Red, LightGray)
      case 58 '3S of rc2
        r = 59
        draw(59, Red, LightGray)
      case 59 '3S, 1E of rc2
        r = 49
        draw(49, Green, LightGray)
      case 60 '3N of gc2
        r = 73
        draw(73, Blue, LightGray)
      case 62 '6N of gc2
        r = 50
        draw(50, Orange, Black)
      case 63 '2N of gc2
        r = 47
        draw(47, Orange, Black)
      case 67 '2N of bc2
        r = 76
        draw(76, White, LightGray)
      case 68 'N of bc2
        r = 75
        draw(75, White, LightGray)
      case 71 'SW of bc2
        r = 70
        draw(70, Blue, LightGray)
      case 72 '2S, 1W of bc2
        r = 74
        draw(74, Blue, LightGray)
      case 73 '2S, 2W of bc2
        r = 72
        draw(72, Blue, LightGray)
      case 74 '1S, 2W of bc2
        r = 71
        draw(71, Blue, LightGray)
      case 76 '2N, 1E of bc2
        r = 77
        draw(77, White, LightGray)
    end select
  endif
loop
                        
sub draw(room, c1, c2, c3)
  cls : color c1, c2
  select case room
    case 1, 2, 3, 31, 55, 65, 69 'Castle  
      ? @(0,   0) "wwwwwwwwwww w w w      w w w wwwwwwwwwww"; 
      ? @(0,  50) "ww        wwwwwww      wwwwwww        ww"; 
      ? @(0, 100) "ww        wwwwwww      wwwwwww        ww"; 
      ? @(0, 150) "ww        wwwwwwwwwwwwwwwwwwww        ww"; 
      ? @(0, 200) "ww        wwwwwwwwwwwwwwwwwwww        ww"; 
      ? @(0, 250) "ww          wwwwwwwwwwwwwwww          ww"; 
      ? @(0, 300) "ww          wwwwwwwwwwwwwwww          ww"; 
      ? @(0, 350) "ww          wwwwww";
      color c3 : ? @(360, 350) " rry";
      color c1 : ? @(440, 350) "wwwwww          ww"; 
      ? @(0, 400) "ww          wwwwww";
      color c3 : ? @(360, 400) " rry";
      color c1 : ? @(440, 400) "wwwwww          ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 4 'North of catacombs
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
      color c3, c1
      ? @(740, 0) "b";
      color c1, c2
      ? @(760, 0) "ww";
      color c3
      for i = 1 to 10
        ? @(0, 50 * i) "                                     b  "; 
      next i 
      color c1
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwww";
      color c3, c1
      ? @(740, 550) "b";
      color c1, c2
      ? @(760, 550) "ww"; 
    case 5 'East of catacombs      
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwww";
      color c3, c1
      ? @(740, 0) "b";
      color c1, c2
      ? @(760, 0) "ww"; '0-49
      color c3
      for i = 1 to 10
        ? @(0, 50 * i) "                                     b  ";
      next i
      color c1
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwww";
      color c3, c1
      ? @(740, 550) "b";
      color c1, c2
      ? @(760, 550) "ww";
    case 6, 7 'Southeast/Southwest of catacombs
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; '0-49
      for i = 1 to 10
        ? @(0, 50 * i) "w                                      w";
      next i
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; '550-599
    case 8, 9 'Inside Yellow castle/Northeast of catacombs
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; '0-49
      for i = 1 to 10 
        ? @(0, 50 * i) "w                                      w";
      next i
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; '550-599  
    case 10 'Inside Black castle 
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; '0-49
      for i = 1 to 10
        ? @(0, 50 * i) "w                                      w";
      next i
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; '550-599
    case 11, 12 'South of Yellow castle/Warren room
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; '0-49
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; '550-599
    case 13 'South of blue maze  
      ? @(0,   0) "ww";
      color c3, c1
      ? @(40,   0) "b";
      color c1, c2
      ? @(60,   0) "wwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      color c3
      for i = 1 to 10
        ? @(0, 50 * i) "  b"; 
      next i
      color c1
      ? @(0, 550) "ww";
      color c3, c1
      ? @(40, 550) "b";
      color c1, c2
      ? @(60, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
    case 14 'South of White castle
      ? @(0,   0) "ww";
      color c3, c1
      ? @(40,  0) "b";
      color c1, c2
      ? @(60,  0) "wwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      color c3
      for i = 1 to 10
        ? @(0, 50 * i) "  b";
      next i
      color c1
      ? @(0,  550) "ww";
      color c3, c1
      ? @(40, 550) "b";
      color c1, c2
      ? @(60, 550) "wwwwwwwwwwwww        wwwwwwwwwwwwwwww"; '550-599
    case 15 'North catacombs
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "      ww                        ww";
      ? @(0, 100) "      ww                        ww";
      ? @(0, 150) "wwww  ww    wwwwwwwwwwwwwwww    ww  wwww";
      ? @(0, 200) "wwww  ww    wwwwwwwwwwwwwwww    ww  wwww";
      ? @(0, 250) "      ww          wwww          ww";
      ? @(0, 300) "      ww          wwww          ww";
      ? @(0, 350) "wwwwwwww  ww      wwww      ww  wwwwwwww";
      ? @(0, 400) "wwwwwwww  ww      wwww      ww  wwwwwwww";
      ? @(0, 450) "          ww      wwww      ww";
      ? @(0, 500) "          ww      wwww      ww";
      ? @(0, 550) "wwwwwwwwwwww  ww  wwww  ww  wwwwwwwwwwww";
    case 16 'Central catacombs
      ? @(0,   0) "wwwwwwwwwwww  ww  wwww  ww  wwwwwwwwwwww"; 
      ? @(0,  50) "              ww  wwww  ww              "; 
      ? @(0, 100) "              ww  wwww  ww              "; 
      ? @(0, 150) "wwww      wwwwww  wwww  wwwwww      wwww"; 
      ? @(0, 200) "wwww      wwwwww  wwww  wwwwww      wwww"; 
      ? @(0, 250) "          ww                ww          "; 
      ? @(0, 300) "          ww                ww          "; 
      ? @(0, 350) "wwwwwwww  ww  wwwwwwwwwwww  ww  wwwwwwww"; 
      ? @(0, 400) "wwwwwwww  ww  wwwwwwwwwwww  ww  wwwwwwww"; 
      ? @(0, 450) "      ww  ww  ww        ww  ww  ww      "; 
      ? @(0, 500) "      ww  ww  ww        ww  ww  ww      "; 
      ? @(0, 550) "wwww  ww  ww  ww  wwww  ww  ww  ww  wwww"; 
    case 17 'South catacombs
      ? @(0,   0) "wwww  ww  ww  ww  wwww  ww  ww  ww  wwww"; 
      ? @(0,  50) "      ww      ww  wwww  ww      ww"; 
      ? @(0, 100) "      ww      ww  wwww  ww      ww"; 
      ? @(0, 150) "      wwwwww  ww  wwww  ww  wwwwww"; 
      ? @(0, 200) "      wwwwww  ww  wwww  ww  wwwwww"; 
      ? @(0, 250) "                  wwww"; 
      ? @(0, 300) "                  wwww"; 
      ? @(0, 350) "      wwwwwwww    wwww    wwwwwwww"; 
      ? @(0, 400) "      wwwwwwww    wwww    wwwwwwww"; 
      ? @(0, 450) "      ww          wwww          ww"; 
      ? @(0, 500) "      ww          wwww          ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww";
      color Orange, LightGray 'to fix bug 
    case 18 'Nothwest White castle
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) " "; 
      ? @(0, 100) " "; 
      ? @(0, 150) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 250) "              ww        ww"; 
      ? @(0, 300) "              ww        ww"; 
      ? @(0, 350) "wwwwwwwwwwww  ww        ww  wwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwww  ww        ww  wwwwwwwwwwww"; 
      ? @(0, 450) "wwww      ww  ww  wwww  ww  ww      wwww"; 
      ? @(0, 500) "wwww      ww  ww  wwww  ww  ww      wwww"; 
      ? @(0, 550) "wwww  ww  wwwwww  wwww  wwwwww  ww  wwww"; 
    case 19 'Northeast White castle
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "                  wwww"; 
      ? @(0, 100) "                  wwww"; 
      ? @(0, 150) "wwwwwwwwwwwwwwww  wwww  wwwwwwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwww  wwww  wwwwwwwwwwwwwwww"; 
      ? @(0, 250) "              ww  wwww  ww"; 
      ? @(0, 300) "              ww  wwww  ww"; 
      ? @(0, 350) "wwww  ww  wwwwwwwwwwwwwwwwwwww  ww  wwww"; 
      ? @(0, 400) "wwww  ww  wwwwwwwwwwwwwwwwwwww  ww  wwww"; 
      ? @(0, 450) "wwww  ww  ww                ww  ww  wwww"; 
      ? @(0, 500) "wwww  ww  ww                ww  ww  wwww"; 
      ? @(0, 550) "wwww  wwwwww  ww        ww  wwwwww  wwww"; 
    case 20 'Southwest White castle
      ? @(0,   0) "wwww  ww  wwwwww  wwww  wwwwww  ww  wwww"; 
      ? @(0,  50) "wwww  ww                        ww  wwww"; 
      ? @(0, 100) "wwww  ww                        ww  wwww"; 
      ? @(0, 150) "wwww  ww  wwwwwwwwwwwwwwwwwwww  ww  wwww"; 
      ? @(0, 200) "wwww  ww  wwwwwwwwwwwwwwwwwwww  ww  wwww"; 
      ? @(0, 250) "      ww  ww                ww  ww"; 
      ? @(0, 300) "      ww  ww                ww  ww";
      ? @(0, 350) "wwwwwwwwwwww                wwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwww                wwwwwwwwwwww"; 
      ? @(0, 450) " "; 
      ? @(0, 500) " "; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 21 'Southeast White castle
      ? @(0,   0) "wwww  wwwwww  ww        ww  wwwwww  wwww"; 
      ? @(0,  50) "wwww          ww        ww          wwww"; 
      ? @(0, 100) "wwww          ww        ww          wwww"; 
      ? @(0, 150) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 250) "      ww                        ww"; 
      ? @(0, 300) "      ww                        ww"; 
      ? @(0, 350) "wwww  ww                        ww  wwww"; 
      ? @(0, 400) "wwww  ww                        ww  wwww";
      ? @(0, 450) "      ww                        ww";
      ? @(0, 500) "      ww                        ww";
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww";
    case 22 'Northwest Blue maze  
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) " "; 
      ? @(0, 100) " "; 
      ? @(0, 150) "wwwwwwwwww  wwwwwwwwwwwwwwww  wwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwww  wwwwwwwwwwwwwwww  wwwwwwwwww"; 
      ? @(0, 250) "wwww              wwww              wwww"; 
      ? @(0, 300) "wwww              wwww              wwww"; 
      ? @(0, 350) "wwww  wwwwwwwwww  wwww  wwwwwwwwww  wwww"; 
      ? @(0, 400) "wwww  wwwwwwwwww  wwww  wwwwwwwwww  wwww"; 
      ? @(0, 450) "      ww      ww  wwww  ww      ww"; 
      ? @(0, 500) "      ww      ww  wwww  ww      ww"; 
      ? @(0, 550) "wwwwwwww  ww  ww  wwww  ww  ww  wwwwwwww"; 
    case 23 'Northeast Blue maze
      ? @(0,   0) "wwwwwwww  ww  ww        ww  ww  wwwwwwww"; 
      ? @(0,  50) "      ww      ww        ww      ww"; 
      ? @(0, 100) "      ww      ww        ww      ww"; 
      ? @(0, 150) "wwww  wwwwwwwwww        wwwwwwwwww  wwww"; 
      ? @(0, 200) "wwww  wwwwwwwwww        wwwwwwwwww  wwww"; 
      ? @(0, 250) "wwww                                wwww"; 
      ? @(0, 300) "wwww                                wwww"; 
      ? @(0, 350) "wwwwwwww                        wwwwwwww"; 
      ? @(0, 400) "wwwwwwww                        wwwwwwww"; 
      ? @(0, 450) "      ww                        ww"; 
      ? @(0, 500) "      ww                        ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 24 'Southwest Blue maze
      ? @(0,   0) "wwww  ww  wwwwwwww    wwwwwwww  ww  wwww"; 
      ? @(0,  50) "      ww      wwww    wwww      ww"; 
      ? @(0, 100) "      ww      wwww    wwww      ww"; 
      ? @(0, 150) "wwwwwwwwwwww  wwww    wwww  wwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwww  wwww    wwww  wwwwwwwwwwww"; 
      ? @(0, 250) "          ww  wwww    wwww  ww"; 
      ? @(0, 300) "          ww  wwww    wwww  ww"; 
      ? @(0, 350) "wwww  ww  ww  wwww    wwww  ww  ww  wwww"; 
      ? @(0, 400) "wwww  ww  ww  wwww    wwww  ww  ww  wwww"; 
      ? @(0, 450) "      ww  ww  ww        ww  ww  ww"; 
      ? @(0, 500) "      ww  ww  ww        ww  ww  ww"; 
      ? @(0, 550) "wwwwwwww  ww  ww        ww  ww  wwwwwwww"; 
    case 25 'Southeast Blue maze
      ? @(0,   0) "wwwwwwww  ww  ww  wwww  ww  ww  wwwwwwww"; 
      ? @(0,  50) "      ww  ww  ww        ww  ww  ww"; 
      ? @(0, 100) "      ww  ww  ww        ww  ww  ww"; 
      ? @(0, 150) "wwww  ww  ww  wwwwwwwwwwww  ww  ww  wwww"; 
      ? @(0, 200) "wwww  ww  ww  wwwwwwwwwwww  ww  ww  wwww"; 
      ? @(0, 250) "      ww  ww                ww  ww"; 
      ? @(0, 300) "      ww  ww                ww  ww"; 
      ? @(0, 350) "wwwwwwww  wwwwwwwwwwwwwwwwwwww  wwwwwwww"; 
      ? @(0, 400) "wwwwwwww  wwwwwwwwwwwwwwwwwwww  wwwwwwww"; 
      ? @(0, 450) " "; 
      ? @(0, 500) " "; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 26 'North Blue maze  
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "        ww    ww        ww    ww"; 
      ? @(0, 100) "        ww    ww        ww    ww"; 
      ? @(0, 150) "wwww    ww    wwww    wwww    ww    wwww"; 
      ? @(0, 200) "wwww    ww    wwww    wwww    ww    wwww"; 
      ? @(0, 250) "wwww    ww                    ww    wwww";
      ? @(0, 300) "wwww    ww                    ww    wwww";
      ? @(0, 350) "wwwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwww";
      ? @(0, 400) "wwwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwww";
      ? @(0, 450) "      ww        ww    ww        ww";
      ? @(0, 500) "      ww        ww    ww        ww";
      ? @(0, 550) "wwww  ww  wwwwwwww    wwwwwwww  ww  wwww";
    case 27 'Northwest Black castle
      ? @(0,   0) "wwwwwwww    wwwwwwwwwwwwwwww    wwwwwwww";
      ? @(0,  50) "            ww            ww";
      ? @(0, 100) "            ww            ww";
      ? @(0, 150) "wwwwwwwwwwwwww            wwwwwwwwwwwwww";
      ? @(0, 200) "wwwwwwwwwwwwww            wwwwwwwwwwwwww";
      ? @(0, 250) " ";
      ? @(0, 300) " ";
      ? @(0, 350) "ww    wwwwwwwwwwwwwwwwwwwwwwwwwwww    ww";
      ? @(0, 400) "ww    wwwwwwwwwwwwwwwwwwwwwwwwwwww    ww";
      ? @(0, 450) "      ww                        ww";
      ? @(0, 500) "      ww                        ww";
      ? @(0, 550) "wwwwwwww    wwwwwwwwwwwwwwww    wwwwwwww";
    case 28 'Northeast Black castle
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "                  ww                  ww"; 
      ? @(0, 100) "                  ww                  ww"; 
      ? @(0, 150) "wwwwwwwwwwwwwwww  wwwwwwwwwwwwwwwwww  ww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwww  wwwwwwwwwwwwwwwwww  ww"; 
      ? @(0, 250) "              ww                  ww"; 
      ? @(0, 300) "              ww                  ww"; 
      ? @(0, 350) "wwww    wwwwwwwwwwwwwwww    wwwwwwwwwwww"; 
      ? @(0, 400) "wwww    wwwwwwwwwwwwwwww    wwwwwwwwwwww"; 
      ? @(0, 450) "        wwww      ww        wwww      ww"; 
      ? @(0, 500) "        wwww      ww        wwww      ww"; 
      ? @(0, 550) "ww  ww  wwww  ww  wwww  ww  wwww  ww  ww"; 
    case 29 'Southwest Black castle
      ? @(0,   0) "wwwwwwww    wwwwwwwwwwwwwwww    wwwwwwww"; 
      ? @(0,  50) "ww                  ww"; 
      ? @(0, 100) "ww                  ww"; 
      ? @(0, 150) "ww    wwwwwwwwwwwwwwww    wwwwwwwwwwwwww"; 
      ? @(0, 200) "ww    wwwwwwwwwwwwwwww    wwwwwwwwwwwwww"; 
      ? @(0, 250) "      ww                  ww"; 
      ? @(0, 300) "      ww                  ww"; 
      ? @(0, 350) "wwwwwwww    wwwwwwwwwwwwwwww    wwwwwwww"; 
      ? @(0, 400) "wwwwwwww    wwwwwwwwwwwwwwww    wwwwwwww"; 
      ? @(0, 450) "ww          ww      ww          ww"; 
      ? @(0, 500) "ww          ww      ww          ww";
      ? @(0, 550) "wwwwwwww    wwwwwwwwwwwwwwww    wwwwwwww";
    case 30 'Southwest Black castle
      ? @(0,   0) "ww  ww  wwww  ww  wwww  ww  wwww  ww  ww"; 
      ? @(0,  50) "    ww        ww  wwww  ww        ww"; 
      ? @(0, 100) "    ww        ww  wwww  ww        ww"; 
      ? @(0, 150) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 250) " "; 
      ? @(0, 300) " "; 
      ? @(0, 350) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 450) " "; 
      ? @(0, 500) " "; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    '31 is yellow castle 2
    case 32 'Inside yellow castle 2
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "wwww    wwwwwwwwww    wwwwwwwwww    wwww"; 
      ? @(0, 100) "wwwww  wwwwwwwwwwww  wwwwwwwwwwww  wwwww"; 
      ? @(0, 150) "wwwww  wwwwwwwwwwww  wwwwwwwwwwww  wwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "ww                                    ww"; 
      ? @(0, 300) "ww                                    ww"; 
      ? @(0, 350) "ww                                    ww"; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 33 'South of yc2
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww                                    ww"; 
      ? @(0, 100) "ww                                    ww"; 
      ? @(0, 150) "ww                                    ww"; 
      ? @(0, 200) "        wwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "        wwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 300) "                  wwww"; 
      ? @(0, 350) "                  wwww"; 
      ? @(0, 400) "                  wwww"; 
      ? @(0, 450) "                  wwww"; 
      ? @(0, 500) "wwwwwwww          wwww          wwwwwwww"; 
      ? @(0, 550) "ww    wwwwww      wwww      wwwwww    ww"; 
    case 34 '2 South of yc2 
      ? @(0,   0) "wwwwwwwwwwww      wwww      wwwwwwwwwwww"; 
      ? @(0,  50) "                  wwww                ww"; 
      ? @(0, 100) "                  wwww                ww"; 
      ? @(0, 150) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "                                      ww"; 
      ? @(0, 300) "                                      ww"; 
      ? @(0, 350) "  wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww  ww"; 
      ? @(0, 400) "                                      ww"; 
      ? @(0, 450) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 500) "                  wwww                ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 35 'West of yc2
      ? @(0,   0) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0,  50) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0, 100) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0, 150) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0, 200) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0, 250) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0, 300) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 350) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 450) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 500) "wwwwwwwwwww                  wwwwwwwwwww"; 
      ? @(0, 550) "wwwwwwwwwww                  wwwwwwwwwww"; 
    case 36 'Southwest of yc2 
      ? @(0,   0) "wwwwwwwwwwww                wwwwwwwwwwww"; 
      ? @(0,  50) "ww     ww                      ww     ww"; 
      ? @(0, 100) "ww     ww                      ww     ww"; 
      ? @(0, 150) "wwwwwwwww                      wwwwwwwww"; 
      ? @(0, 200) "              wwwwwwwwwwww"; 
      ? @(0, 250) "              ww        ww"; 
      ? @(0, 300) "              ww        ww"; 
      ? @(0, 350) "              wwwwwwwwwwww"; 
      ? @(0, 400) " "; 
      ? @(0, 450) " "; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 37 '1 West, 2 South of yc2 
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww"; 
      ? @(0, 100) "ww"; 
      ? @(0, 150) "wwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "ww"; 
      ? @(0, 300) "ww"; 
      ? @(0, 350) "ww  wwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 400) "ww"; 
      ? @(0, 450) "wwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwwww"; 
      ? @(0, 500) "ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 38 '2 West, 2 South of yc2
      ? @(0,   0) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0,  50) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0, 100) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0, 150) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 300) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0, 350) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0, 400) "wwwwww        wwwwwwwwwwww        wwwwww"; 
      ? @(0, 450) "ww        wwwwwwwwwwwwwwwwwwww        ww"; 
      ? @(0, 500) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
      ? @(0, 550) "ww      wwwwwwwwwwwwwwwwwwwwwwww      ww"; 
    case 39 '2 West, 1 South of yc2
      ? @(0,   0) "wwwwwwwwwwww                wwwwwwwwwwww"; 
      ? @(0,  50) "ww        ww                ww        ww"; 
      ? @(0, 100) "ww        ww                ww        ww"; 
      ? @(0, 150) "wwwwwwwwwwww                wwwwwwwwwwww"; 
      ? @(0, 200) "ww"; 
      ? @(0, 250) "ww"; 
      ? @(0, 300) "ww"; 
      ? @(0, 350) "ww"; 
      ? @(0, 400) "ww"; 
      ? @(0, 450) "ww            wwwwwwwwwwww"; 
      ? @(0, 500) "ww            www      www            ww"; 
      ? @(0, 550) "wwwwww        wwwwwwwwwwww        wwwwww"; 
    case 40 '2 West of yc2
      ? @(0,   0) "wwwwwwwwwwww                wwwwwwwwwwww"; 
      ? @(0,  50) "ww        ww                ww        ww"; 
      ? @(0, 100) "ww        ww     wwwwww     ww        ww"; 
      ? @(0, 150) "          ww                ww        ww"; 
      ? @(0, 200) "          ww                ww        ww"; 
      ? @(0, 250) "          ww                ww        ww"; 
      ? @(0, 300) "          wwwwwwww    wwwwwwww        ww"; 
      ? @(0, 350) "          ww                ww        ww"; 
      ? @(0, 400) "          ww                ww        ww"; 
      ? @(0, 450) "ww        ww     wwwwww     ww        ww"; 
      ? @(0, 500) "ww        ww                ww        ww"; 
      ? @(0, 550) "wwwwwwwwwwww                wwwwwwwwwwww"; 
    case 41 '2 West, 1 North of yc2 
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww    wwwwwww              wwwwwww    ww"; 
      ? @(0, 100) "ww         ww              ww         ww"; 
      ? @(0, 150) "ww         ww              ww         ww"; 
      ? @(0, 200) "ww         wwwwwww    wwwwwww         ww"; 
      ? @(0, 250) "ww                                    ww"; 
      ? @(0, 300) "ww    ww                          ww  ww"; 
      ? @(0, 350) "ww    ww                          ww  ww"; 
      ? @(0, 400) "ww    wwwwwwwwwwwwwwwwwwwwwwwwwwwwww  ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwww                wwwwwwwwwwww"; 
    case 42
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww                                    ww"; 
      ? @(0, 100) "ww                                    ww"; 
      ? @(0, 150) "ww                                    ww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 250) "wwwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwww"; 
      ? @(0, 300) "wwwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwww"; 
      ? @(0, 350) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 43
      ? @(0,   0) "wwwwwwwww    www        www     wwwwwwww"; 
      ? @(0,  50) "wwwwwwwww    www        www     wwwwwwww"; 
      ? @(0, 100) "www          www        www          www"; 
      ? @(0, 150) "www          www        www          www"; 
      ? @(0, 200) "www          www        www          www"; 
      ? @(0, 250) "www          www        www          www"; 
      ? @(0, 300) "wwwwwwwwww   www        www    wwwwwwwww"; 
      ? @(0, 350) "             www        www"; 
      ? @(0, 400) "             www        www"; 
      ? @(0, 450) "             www        www"; 
      ? @(0, 500) "ww           www        www           ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 44 
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 100) "ww              wwwwwwww              ww"; 
      ? @(0, 150) "ww              wwwwwwww              ww"; 
      ? @(0, 200) "ww        www   wwwwwwww   www        ww"; 
      ? @(0, 250) "ww        www   wwwwwwww   www        ww"; 
      ? @(0, 300) "ww        www              www        ww"; 
      ? @(0, 350) "ww        www              www        ww"; 
      ? @(0, 400) "ww        wwwwww        wwwwww"; 
      ? @(0, 450) "ww           www        www"; 
      ? @(0, 500) "ww           www        www           ww"; 
      ? @(0, 550) "wwwwwwwww    www        www    wwwwwwwww"; 
    case 45
      ? @(0,   0) "www    wwww       wwww      wwww     www"; 
      ? @(0,  50) "www    wwww       wwww      wwww     www"; 
      ? @(0, 100) "ww     wwww       wwww      wwww      ww"; 
      ? @(0, 150) "ww     wwww       wwww      wwww      ww"; 
      ? @(0, 200) "ww     wwww       wwww      wwww      ww"; 
      ? @(0, 250) "ww     wwww       wwww      wwww      ww"; 
      ? @(0, 300) "ww     wwww                 wwww      ww"; 
      ? @(0, 350) "       wwww                 wwww"; 
      ? @(0, 400) "       wwww                 wwww"; 
      ? @(0, 450) "       wwww                 wwww"; 
      ? @(0, 500) "ww     wwww                 wwww      ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 46 
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 100) "www      www                www      www"; 
      ? @(0, 150) "www      www                www      www"; 
      ? @(0, 200) "www      wwwwwwwwwwwwwwwwwwwwww      www"; 
      ? @(0, 250) "www               wwww               www"; 
      ? @(0, 300) "www               wwww               www"; 
      ? @(0, 350) "www               wwww               www"; 
      ? @(0, 400) "www     www       wwww       www     www"; 
      ? @(0, 450) "www     www       wwww       www     www"; 
      ? @(0, 500) "www     www       wwww       www     www"; 
      ? @(0, 550) "wwwww   www       wwww       www   wwwww"; 
    case 47
      ? @(0,   0) "wwwwwwwwwwww    ww    ww     wwwwwwwwwww"; 
      ? @(0,  50) "ww        ww    ww    ww     ww       ww"; 
      ? @(0, 100) "ww              ww    ww              ww"; 
      ? @(0, 150) "ww      wwwww   ww    ww    wwwww     ww"; 
      ? @(0, 200) "wwwwwwwwwwwww               wwwwwwwwwwww"; 
      ? @(0, 250) "ww      wwwww               wwwww     ww"; 
      ? @(0, 300) "        wwwww               wwwww"; 
      ? @(0, 350) "        wwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 400) " "; 
      ? @(0, 450) " "; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 48 
      ? @(0,   0) "wwwwwwwwwwwwwwwwww    wwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww              ww    ww"; 
      ? @(0, 100) "ww              ww    ww"; 
      ? @(0, 150) "ww              ww    ww"; 
      ? @(0, 200) "ww              ww    ww"; 
      ? @(0, 250) "wwwwwwwwwwwww   ww    ww   wwwwwwwwwwwww"; 
      ? @(0, 300) "wwwww   wwwww   ww    ww   wwwww   wwwww"; 
      ? @(0, 350) "wwwww   wwwww   ww    ww   wwwww   wwwww"; 
      ? @(0, 400) "ww      www     ww    ww     www      ww"; 
      ? @(0, 450) "ww              ww    ww              ww"; 
      ? @(0, 500) "ww              ww    ww              ww"; 
      ? @(0, 550) "wwwwwwwwwwww    ww    ww    wwwwwwwwwwww"; 
    case 49 
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww       www      wwww      www       ww"; 
      ? @(0, 100) "ww       www      wwww      www       ww"; 
      ? @(0, 150) "ww        w        ww        w        ww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) " "; 
      ? @(0, 300) " "; 
      ? @(0, 350) " "; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwww      wwwwwwwwwwwwwwwww"; 
    case 50 
      ? @(0,   0) "ww                wwww                ww"; 
      ? @(0,  50) "ww                wwww                ww"; 
      ? @(0, 100) "ww                wwww                ww"; 
      ? @(0, 150) "ww                wwww                ww"; 
      ? @(0, 200) "                  wwww"; 
      ? @(0, 250) "                  wwww"; 
      ? @(0, 300) "                  wwww"; 
      ? @(0, 350) "ww           ww   wwww   ww           ww"; 
      ? @(0, 400) "ww           ww   wwww   ww           ww"; 
      ? @(0, 450) "ww           ww   wwww   ww           ww"; 
      ? @(0, 500) "ww           ww   wwww   ww           ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwww   wwww   wwwwwwwwwwwwwww"; 
    case 51 
      ? @(0,   0) "wwwwwwwwwwwww              wwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwww              wwwwwwwwwwwww"; 
      ? @(0, 100) "wwwwwwwwwwwww              wwwwwwwwwwwww"; 
      ? @(0, 150) "wwwwwwwwwwwww              wwwwwwwwwwwww"; 
      ? @(0, 200) "ww   www  www              www  www"; 
      ? @(0, 250) "ww   wwwwwwww              wwwwwwww"; 
      ? @(0, 300) "ww"; 
      ? @(0, 350) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 450) "ww                wwww                ww"; 
      ? @(0, 500) "ww                wwww                ww"; 
      ? @(0, 550) "ww                wwww                ww"; 
    case 52 
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww       www      wwww      www       ww"; 
      ? @(0, 100) "ww       www      wwww      www       ww"; 
      ? @(0, 150) "ww        w        ww        w        ww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "                                      ww"; 
      ? @(0, 300) "                                      ww"; 
      ? @(0, 350) "                                      ww"; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwww              wwwwwwwwwwwww"; 
    case 53, 59, 60, 76
      ? @(0,   0) "  wwww  ww                    ww  wwww  "; 
      ? @(0,  50) "  wwww  ww                    ww  wwww  "; 
      ? @(0, 100) "wwwwwwwwww                    wwwwwwwwww"; 
      ? @(0, 150) "wwwwwwwwww                    wwwwwwwwww"; 
      ? @(0, 200) "wwwww   ww w w w w ww w w w w ww   wwwww"; 
      ? @(0, 250) "wwwww   wwwwwwwwwwwwwwwwwwwwwwww   wwwww"; 
      ? @(0, 300) "wwwww                              wwwww"; 
      ? @(0, 350) "wwwww    ww w w w w  w w w w ww    wwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 450) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 500) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 54, 67 
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww       www      wwww      www       ww"; 
      ? @(0, 100) "ww       www      wwww      www       ww"; 
      ? @(0, 150) "ww        w        ww        w        ww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "ww"; 
      ? @(0, 300) "ww"; 
      ? @(0, 350) "ww"; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwww      wwwwwwwwwwwwwwwww"; 
    '55 is Red castle
    case 56
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 100) "             www        www"; 
      ? @(0, 150) "             www        www"; 
      ? @(0, 200) "             www        www"; 
      ? @(0, 250) "wwwwww       www        www       wwwwww"; 
      ? @(0, 300) "             www        www"; 
      ? @(0, 350) "             www        www"; 
      ? @(0, 400) "             www        www"; 
      ? @(0, 450) "             www        www"; 
      ? @(0, 500) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    case 57
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww           www        www"; 
      ? @(0, 100) "ww"; 
      ? @(0, 150) "ww"; 
      ? @(0, 200) "ww"; 
      ? @(0, 250) "ww                wwww"; 
      ? @(0, 300) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 350) "ww"; 
      ? @(0, 400) "ww"; 
      ? @(0, 450) "ww"; 
      ? @(0, 500) "ww"; 
      ? @(0, 550) "wwwwwwwwwwwwww            wwwwwwwwwwwwww"; 
    case 58
      ? @(0,   0) "wwwwwwwwwwwwww            wwwwwwwwwwwwww"; 
      ? @(0,  50) "                                      ww"; 
      ? @(0, 100) "                                      ww"; 
      ? @(0, 150) "                                      ww"; 
      ? @(0, 200) "                              wwwwwwwwww"; 
      ? @(0, 250) "                              ww"; 
      ? @(0, 300) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 350) " "; 
      ? @(0, 400) "                                      ww"; 
      ? @(0, 450) "                                      ww"; 
      ? @(0, 500) "                                      ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    '59 and 60 are repeats
    case 61, 77
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww       www      wwww      www       ww"; 
      ? @(0, 100) "ww       www      wwww      www       ww"; 
      ? @(0, 150) "ww        w        ww        w        ww"; 
      ? @(0, 200) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 250) "                                      ww"; 
      ? @(0, 300) "                                      ww"; 
      ? @(0, 350) "                                      ww"; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 62
      ? @(0,   0) "wwwwwwwwwwwwww    wwww    wwwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwwww    wwww    wwwwwwwwwwwwww"; 
      ? @(0, 100) "wwwwwwwwwwwwww    wwww    wwwwwwwwwwwwww"; 
      ? @(0, 150) "wwwwwwwwwwwwww    wwww    wwwwwwwwwwwwww"; 
      ? @(0, 200) "            ww            ww"; 
      ? @(0, 250) "            wwwwwwwwwwwwwwww"; 
      ? @(0, 300) " "; 
      ? @(0, 350) " "; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 63
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "                 wwwwww               ww"; 
      ? @(0, 100) "                 wwwwww               ww"; 
      ? @(0, 150) "                 wwwwww               ww"; 
      ? @(0, 200) "                 wwwwww               ww"; 
      ? @(0, 250) "                 wwwwww               ww"; 
      ? @(0, 300) "wwwwwwwwwwwwww   wwwwww   ww          ww"; 
      ? @(0, 350) "ww          ww   wwwwww   ww          ww"; 
      ? @(0, 400) "ww          ww   wwwwww   ww"; 
      ? @(0, 450) "ww          ww   wwwwww   ww"; 
      ? @(0, 500) "ww          ww   wwwwww   ww          ww"; 
      ? @(0, 550) "ww          ww   wwwwww   ww          ww"; 
    case 64
      ? @(0,   0) "ww          ww   wwwwww   ww          ww"; 
      ? @(0,  50) "ww          ww   wwwwww   ww          ww"; 
      ? @(0, 100) "ww          ww   wwwwww   ww          ww"; 
      ? @(0, 150) "ww          ww            ww          ww"; 
      ? @(0, 200) "ww          ww            ww          ww"; 
      ? @(0, 250) "ww          wwwwwwwwwwwwwwww          ww"; 
      ? @(0, 300) "                                      ww"; 
      ? @(0, 350) "                                      ww"; 
      ? @(0, 400) "                                      ww"; 
      ? @(0, 450) "                                      ww"; 
      ? @(0, 500) "ww            ww        ww            ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    '65 is Green castle
    case 66
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 100) "ww                                    ww"; 
      ? @(0, 150) "ww                                    ww"; 
      ? @(0, 200) "ww                                    ww"; 
      ? @(0, 250) "ww  www                          www  ww"; 
      ? @(0, 300) "ww  w wwwwwwww            wwwwwwww w  ww"; 
      ? @(0, 350) "ww  www    w w            w w    www  ww"; 
      ? @(0, 400) "                                      ww"; 
      ? @(0, 450) "                                      ww"; 
      ? @(0, 500) "                                      ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    '67 is a repeat
    case 68
      ? @(0,   0) "ww            ww        ww           bww"; 
      ? @(0,  50) "ww            ww        ww           bww"; 
      ? @(0, 100) "ww            ww        ww           bww"; 
      ? @(0, 150) "ww            ww        ww           bww"; 
      ? @(0, 200) "ww            ww        ww           b"; 
      ? @(0, 250) "ww            ww        ww           b"; 
      ? @(0, 300) "ww            ww        ww           b"; 
      ? @(0, 350) "ww            ww        ww           b"; 
      ? @(0, 400) "ww            ww        ww           bww"; 
      ? @(0, 450) "ww            ww        ww           bww"; 
      ? @(0, 500) "ww            ww        ww           bww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
    '69 is Blue castle
    case 70
      ? @(0,   0) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwwwwwww        wwwwwwwwwwwwwwww"; 
      ? @(0, 100) "              ww        ww            ww"; 
      ? @(0, 150) "              ww        ww            ww"; 
      ? @(0, 200) "                                      ww"; 
      ? @(0, 250) "                                      ww"; 
      ? @(0, 300) "                                      ww"; 
      ? @(0, 350) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 450) "                  wwww                ww"; 
      ? @(0, 500) "                  wwww                ww"; 
      ? @(0, 550) "wwwwwwwwwwww      wwww      wwwwwwwwwwww"; 
    case 71
      ? @(0,   0) "wwwwwwwwwwww      wwww      wwwwwwwwwwww"; 
      ? @(0,  50) "wwwwwwwwwwww      wwww      wwwwwwwwwwww"; 
      ? @(0, 100) "                 wwwwww"; 
      ? @(0, 150) "                 wwwwww"; 
      ? @(0, 200) "     ww           wwww           ww"; 
      ? @(0, 250) "     ww           wwww           ww"; 
      ? @(0, 300) "     wwww         wwww         wwww"; 
      ? @(0, 350) "wwwwwwwwwwwwwww   wwww   wwwwwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwww   wwww   wwwwwwwwwwwwwww"; 
      ? @(0, 450) "            www   wwww   www"; 
      ? @(0, 500) "            www   wwww   www"; 
      ? @(0, 550) "ww          www   wwww   www          ww"; 
    case 72
      ? @(0,   0) "ww          www   wwww   www          ww"; 
      ? @(0,  50) "ww          www   wwww   www          ww"; 
      ? @(0, 100) "            www   wwww   www"; 
      ? @(0, 150) "            www   wwww   www"; 
      ? @(0, 200) "            www   wwww   www"; 
      ? @(0, 250) "            www          www"; 
      ? @(0, 300) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 350) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 400) " "; 
      ? @(0, 450) " "; 
      ? @(0, 500) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    case 73
      ? @(0,   0) "wwww        wwwwwwwwwwwwwwww        wwww"; 
      ? @(0,  50) "wwww        wwwwwwwwwwwwwwww        wwww"; 
      ? @(0, 100) "  ww                                ww"; 
      ? @(0, 150) "  ww                                ww"; 
      ? @(0, 200) "  wwww            wwww            wwww"; 
      ? @(0, 250) "  wwww            wwww            wwww"; 
      ? @(0, 300) "                  wwww"; 
      ? @(0, 350) "ww                wwww                ww"; 
      ? @(0, 400) "ww    wwwwwwwwwwwwwwwwwwwwwwwwwwww    ww"; 
      ? @(0, 450) "      wwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0, 500) "                  wwww"; 
      ? @(0, 550) "www         wwwwwwwwwwwwwwww        wwww"; 
    case 74
      ? @(0,   0) "wwww        wwwwwwwwwwwwwwww        wwww"; 
      ? @(0,  50) "wwww        wwwwwwwwwwwwwwww        wwww"; 
      ? @(0, 100) "            www          www"; 
      ? @(0, 150) "            www          www"; 
      ? @(0, 200) "            www          www"; 
      ? @(0, 250) "            www          www"; 
      ? @(0, 300) "            www          www"; 
      ? @(0, 350) "wwwwwwwwwwwwwww          wwwwwwwwwwwwwww"; 
      ? @(0, 400) "wwwwwwwwwwwwwww          wwwwwwwwwwwwwww"; 
      ? @(0, 450) "            www          www"; 
      ? @(0, 500) "            www          www"; 
      ? @(0, 550) "wwww        wwwwwwwwwwwwwwww        wwww"; 
    case 75
      ? @(0,   0) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
      ? @(0,  50) "ww                                    ww"; 
      ? @(0, 100) "ww                                    ww"; 
      ? @(0, 150) "ww                                    ww"; 
      ? @(0, 200) "ww                                    ww"; 
      ? @(0, 250) "                   ww                 ww"; 
      ? @(0, 300) "                  wwww                ww"; 
      ? @(0, 350) "                   ww                 ww"; 
      ? @(0, 400) "ww                                    ww"; 
      ? @(0, 450) "ww                                    ww"; 
      ? @(0, 500) "ww                                    ww"; 
      ? @(0, 550) "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"; 
    '76 and 77 are repeats
  end select
  pause 170
end sub  
































































