set debuginfod enabled off

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
tui disable

set style address foreground cyan

set auto-load safe-path /

#set disable-randomization off

