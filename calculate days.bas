' Example program to calculate the number of days between two dates

option explicit
option default none

dim string s
dim float d1, d2

do
  print : print "Enter the date as dd mmm yyyy"
  print "First date";
  input s
  d1 = GetDays(s) 
  if d1 = 0 then print "Invalid date!" : continue do 
  print "Second date";
  input s
  d2 = GetDays(s)   
  if d2 = 0 then print "Invalid date!" : continue do
  print "Difference is" abs(d2 - d1) " days"
loop

' Calculate the number of days since 1/1/1900
function GetDays(d$) as float
  local string month(11) = ("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec")
  local float Days(11) = (0,31,59,90,120,151,181,212,243,273,304,334)
  local float day, mth, yr, s1, s2

  ' Find the separating space character within a date
  s1 = instr(d$, " ")
  if s1 = 0 then exit function
  s2 = instr(s1 + 1, d$, " ")
  if s2 = 0 then exit function

  ' Get the day, month, and year as numbers
  day = val( mid$(d$, 1, s2 - 1)) - 1
  if day < 0 or day > 30 then exit function
  for mth = 0 to 11
    if lcase$(mid$ (d$, s1 + 1, 3)) = Month(mth) then exit for
  next mth
  if mth > 11 then exit function
  yr = val(mid$(d$, s2 + 1 )) - 1900
  if yr < 1  or yr >= 200 then exit function
  
  ' Calculate the number of days including adjustment for leap years
  GetDays = (yr * 365) + fix((yr - 1 ) / 4)
  if yr MOD 4 = 0 and mth >= 2 then GetDays = GetDays + 1
  GetDays = GetDays + Days(mth) + day 
end function






























  
