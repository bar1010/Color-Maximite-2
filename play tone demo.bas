'PLAY TONE left, right [,duration] [,interrupt]
'PLAY SOUND soundno, channelno, type [,frequency] [,volume]
'soundno can be from 1 to 4 allowing for up to four simultaneous sounds on each channel
'channelno can be L, R, or B for left speaker, right speaker, and both speakers
'type is the kind of waveform.  It can be S, Q, T, W, N, P, or O.
'S = Sine wave, Q = Square wave, T = Triangle wave, W = Rising Sawtooth
'N = Noise, P = Periodic noise, O = turn off sound
'Volume must be between 1 and 25.  The default is 25.
'PLAY TTS [PHOENETIC] "text" [,speed] [,pitch] [,mouth] [,throat] [,interrupt]
'PLAY MOD SAMPLE sampleno, channelno [,volume] [,samplerate]
'PLAY PAUSE
'PLAY RESUME
'PLAY STOP
'PLAY VOLUME left, right

cls
mode 1, 8
'play tone 1200, 1850, 3000
'play tts "Hello world, I am SAM for your Color Maximite 2."
'play sound 1, B, S, 1200, 25
'play sound 1, B, Q, 1600, 25
'play sound 1, B, T, 2000, 25
'play sound 1, B, W, 900, 25
'play sound 1, B, N, 750, 25
play sound 1, B, P, 1400, 25


