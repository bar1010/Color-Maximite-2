'Fast calculate pi to many digits
option explicit
dim integer words, big, Digits, DigitsperWord, x, i, quotient
dim integer ctime, stime

cls
color rgb(green)
DigitsperWord = 10
big = 1
for i = 1 to DigitsperWord
  big = big * 10
next

input "How many digits? ", Digits
words = Digits / DigitsperWord + 2
dim integer sum(words + 2), sum1(words + 2), sum2(words + 2)
stime = TIMER
print "Started at " + time$
x = atan239()
print str$(TIMER - stime) + "mS so far"
x = atan51()
print str$(TIMER - stime) + "mS so far"
x = atan52()
print str$(TIMER - stime) + "mS so far"
sum1(2) = sum1(2) - big / 5
for x = 2 to words
  sum(x) = sum(x) + sum1(x) + sum2(x)
next

for x = words to 2 step -1
  if sum(x) < 0 then 
    quotient = sum(x) \ big
    sum(x) = sum(x) - (quotient - 1) * big
    sum(x - 1) = sum(x - 1) + quotient - 1
  endif
  if sum(x) >= big then
    quotient = sum(x) \ big
    sum(x) = sum(x) - quotient * big
    sum(x - 1) = sum(x - 1) + quotient
  endif
next
ctime = TIMER - stime
x = PrintOut()
END

FUNCTION atan239()
  local integer mainder, mainder1, mainder2, dividend, denom, temp, firstword, x
  local integer term(words + 2), lastword
  mainder = 4
  for x = 2 to words
    dividend = mainder * big
    term(x) = dividend \ 239
    mainder = dividend - term(x) * 239
    sum2(x) = sum2(x) - term(x)
  next x

  denom = 3 : firstword = 2
  do
    mainder1 = 0
    mainder2 = 0
    for x = firstword to words
      temp = term(x)
      dividend = mainder1 * big + temp
      temp = dividend \ 57121
      mainder1 = dividend - temp * 57121
      term(x) = temp
      dividend = mainder2 * big + temp
      temp = dividend \ denom
      mainder2 = dividend - temp * denom
      sum2(x) = sum2(x) + temp
    next

    if term(firstword) = 0 then
      firstword = firstword + 1
    endif
    denom = denom + 2
    mainder1 = 0 : mainder2 = 0

    for x = firstword to words
      temp = term(x)
      dividend = mainder1 * big + temp
      temp = dividend \ 57121
      mainder1 = dividend - temp * 57121
      term(x) = temp

      dividend = mainder2 * big + temp
      temp = dividend \ denom
      mainder2 = dividend - temp * denom
      sum2(x) = sum2(x) - temp
    next x

    if term(firstword) = 0 then
      firstword = firstword + 1
    endif
    denom = denom + 2
  loop until firstword >= words
END FUNCTION

FUNCTION atan51()
  local integer mainder, mainder1, mainder2, dividend, denom, temp, firstword, x
  local integer term(words + 2), lastword
  denom = 5 : firstword = 1 : lastword = 3
  sum(1) = 3 : term(1) = 3 : sum(2) = big / 5 : term(2) = sum(2)
  do
    mainder1 = 0
    mainder2 = 0
    for x = firstword to lastword + 1
      temp = term(x)
      dividend = mainder1 * big + temp 
      temp = dividend \ 625
      mainder1 = dividend - temp * 625
      term(x) = temp

      dividend = mainder2 * big + temp 
      temp = dividend \ denom
      mainder2 = dividend - temp * denom
      sum(x) = sum(x) + temp
    next

    for x = lastword + 2 to words
      dividend = mainder2 * big
      temp = dividend \ denom 
      mainder2 = dividend - temp * denom
      sum(x) = sum(x) + temp
    next
    if term(lastword + 1) > 0 and lastword < words then
      lastword = lastword + 1
    endif
    if term(firstword) = 0 then
      firstword = firstword + 1
    endif

    denom = denom + 4
  loop until firstword >= words
END FUNCTION

FUNCTION atan52()
  local integer mainder, mainder1, mainder2, dividend, denom, temp, firstword, x
  local integer term(words + 2), lastword
  denom = 3 : firstword = 1 : lastword = 3
  sum1(1) = 3 : term(1) = 3 : sum1(2) = big / 5 : term(2) = sum1(2)
  print "starting atan52()"
  mainder1 = 0
  mainder2 = 0
  for x = firstword to lastword + 1
    temp = term(x)
    dividend = mainder1 * big + temp
    temp = dividend \ 25
    mainder1 = dividend - temp * 25
    term(x) = temp

    dividend = mainder2 * big + temp
    temp = dividend \ denom
    mainder2 = dividend - temp * denom
    sum1(x) = sum1(x) - temp
  next
  print "atan52() step 2"
  for x = lastword + 2 to words
    dividend = mainder2 * big
    temp = dividend \ denom
    mainder2 = dividend - temp * denom
    sum1(x) = sum1(x) - temp
  next
  if term(lastword + 1) > 0 and lastword < words then
    lastword = lastword + 1
  endif
  if term(firstword) = 0 then
    firstword = firstword + 1
  endif
  denom = denom + 4
  print "atan52() step3"
  do
    if firstword mod 100 = 0 then print firstword 
    mainder1 = 0 : mainder2 = 0
    for x = firstword to lastword + 1
      temp = term(x)
      dividend = mainder1 * big + temp
      temp = dividend \ 625
      mainder1 = dividend - temp * 625
      term(x) = temp

      dividend = mainder2 * big + temp
      temp = dividend \ denom
      mainder2 = dividend - temp * denom
      sum1(x) = sum1(x) - temp
    next x
  
    for x = lastword + 2 to words
      dividend = mainder2 * big
      temp = dividend \ denom
      mainder2 = dividend - temp * denom
      sum1(x) = sum1(x) - temp
    next x

    if term(lastword + 1) > 0 and lastword < words then
      lastword = lastword + 1
    endif
    if term(firstword) = 0 then
      firstword = firstword + 1
    endif
    denom = denom + 4
  loop until firstword >= words
END FUNCTION

FUNCTION PrintOut()
  'local p$, i as integer, j as integer, ptime as integer
  local string p$
  local integer i, j, ptime 
  print ""
  p$ = "pi = 3."
  i = 2
  do
    for j = i to i + 4
      if j > words then
        p$ = p$ + space$(11)
      else
        p$ = p$ + str$(sum(j), 10, 0, "0") + " "
      endif
    next
    p$ = p$ + str$(10 * i + 30, 7)
    print p$
    p$ = "       "
    i = i + 5
  loop until i >= words
  ptime = TIMER - stime - ctime
  print ""

  print " Total computation time:   " + str$(ctime) + " mS"
  print " Time to format and print: " + str$(ptime) + " mS at " + time$
END FUNCTION



































































































































































































































































































  


































































































