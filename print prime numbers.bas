dim integer a, x, Divs 
dim float r
a = 2
cls
color rgb(green)
do
  Divs = 0 
  for x = 2 to sqr( a ) 
    r = a/x   
    if r = fix(r) then Divs = Divs + 1  
  next x 
 
  if Divs <= 0 then ? a; ","; 
  a = a + 1
  pause 0
loop

