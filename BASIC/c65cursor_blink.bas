1000 poke204,0:ifpeek(198)=0then1000
1010 poke204,1:ifpeek(207)=0then1040
1020 poke207,0:poke(peek(210)*256+peek(209)+peek(211)),peek(206)
1030 poke(peek(244)*256+peek(243)+peek(211)),peek(647)
1040 geta$:printa$;:goto1000
