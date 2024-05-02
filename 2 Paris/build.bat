del "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2packed.prg"
D:\OneDrive\C64\Assemblers\64tass\64tass.exe -a "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2.asm" -o "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2compiled.prg"
D:\OneDrive\C64\Tools\exomizer.exe sfx $43e4 -x 1 "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2compiled.prg" -o "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2packed.prg" -p 1
del "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2compiled.prg"
D:\OneDrive\C64\Emulators\RetroDebugger.exe -wait 2500 -autojmp -prg "D:\OneDrive\C64\Disassembly\AVTAK\2 Paris\Level2packed.prg"
