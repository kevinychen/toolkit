set debuginfod enabled off
set $base = 0x7ffff7ffc000

source ~/repos/pwndbg/gdbinit.py

#######################
#               #     #
# regs          # bt  #
#               #######
#################     #
#               # asm #
# stack         #     #
#######################
#                     #
# cmd                 #
#                     #
#######################
tui new-layout kyc { { -horizontal { pwndbg_regs 2 pwndbg_stack 1 } 2 { pwndbg_legend 1 pwndbg_backtrace 6 pwndbg_disasm 9 } 1 } 4 cmd 3 } 1 status 1
focus cmd
layout kyc

set style address foreground cyan

