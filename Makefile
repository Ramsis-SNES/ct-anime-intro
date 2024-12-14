# This requires the WLA DX cross assembler v10.7, and Floating IPS (flips).

AS=wla-65816
ASFLAGS=-o
LD=wlalink
LDFLAGS=-r -s
P=flips
PFLAGS=--create --bps-delta

# name of ROMs and associated files
source=ct.sfc
target=ct_msu1

bps=$(target).bps
lnk=$(target).lnk
obj=$(target).obj
sfc=$(target).sfc
src=$(target).asm
sym=$(target).sym

.PHONY: all clean

all: $(bps)

$(bps): $(sfc)
	$(P) $(PFLAGS) $(source) $< $@

$(obj): $(src)
	$(AS) $(ASFLAGS) $@ $<

$(sfc): $(obj)
	echo '[objects]\n$<' > $(lnk)
	$(LD) $(LDFLAGS) $(lnk) $@

clean:
	-rm -f $(bps) $(lnk) $(obj) $(sfc) $(sym)
