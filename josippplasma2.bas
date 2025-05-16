!-Poor-mans-plasma v0.1 by Eyvind Ebsen 2025
!-
!-Inspired by Josip Retro Bits - Big thanks Josip! :)
!-Josips plasma https://github.com/josipk/Commodore64/blob/main/plasma_effect.txt
!-Youtube: https://www.youtube.com/watch?v=eaOxvuQfq28
!-
!-This will save 48 frames of "plasma"-data to disk...will take a while.
!-"plasma", some weird math. Technically waves in waves...
!-Load this data in the displayer program colcopy.asm
!-
!-
1 sq=1.7:cx=11:cy=9
2 dimc(31):forx=.to15:readc(x):c(31-x)=c(x):next:data 1,7,13,3,15,5,10,12,14,4,8,2,11,6,9,0
7 input"disk ready";a$
8 open 3,8,3,"@:coldata,s,w":rem save data to disk
9 print"{home}{reverse on}";:forx=.to43:a$=a$+" ":printa$;:next:printleft$(a$,9);:poke2023,160
10 print"{home}{down*24}frame:"fr;:q=sq
15 for y=1to25
20 for x=1to40
35 a=sin(x/cy)+cos(y/cx)+log(abs(cx*cy)):rem the "plasma"
45 p=(x-1)+(y-1)*40:poke55296+p,c(abs(a*6)and31):rem show on screen
47 print#3,chr$(c(abs(a*6)and31));:rem save to disk
50 next:next
55 forx=.to23:print#3,chr$(0);:next:rem waste 24 bytes so we fill a page
60 fr=fr+1:sq=sq*1.1:cx=cx-sin(fr/3):cy=cy-cos(fr/3):if fr<48 then goto 10
70 close3
80 print:print"all frames done!"