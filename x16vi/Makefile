run: x16vi.prg
	x16emu -scale 1 -quality best -ram 2048 -keymap en-gb -prg x16vi.prg -run

x16vi.prg: x16vi.asm
	64tass -o x16vi.prg -I./include --no-monitor --line-numbers --tab-size=1 --list=x16vi.lst x16vi.asm

clean:
	rm *prg *lst
