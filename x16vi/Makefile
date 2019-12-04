run: sprite.prg
	x16emu -scale 1 -quality best -ram 2048 -keymap en-gb -prg sprite.prg -run

sprite.prg: start.asm
	64tass -o sprite.prg -I../include --no-monitor --line-numbers --tab-size=1 --list=sprite.lst start.asm

clean:
	rm *prg *lst
