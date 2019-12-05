INCLUDE_SRCS=include/*.inc

run: x16ed.prg
	x16emu -scale 1 -quality best -ram 2048 -keymap en-gb -prg x16ed.prg -run

x16ed.prg: x16ed.asm ${INCLUDE_SRCS}
	64tass -o x16ed.prg -I./include --no-monitor --line-numbers --tab-size=1 --list=x16ed.lst x16ed.asm

clean:
	rm *prg *lst
