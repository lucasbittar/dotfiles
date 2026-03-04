# FaceTime HD Camera Fix (MacBook Pro on Linux)

## Current Status (2026-03-04) — ABANDONED

After exhausting all software fixes, the built-in FaceTime HD camera does not
produce frames on this hardware/kernel combination. **Using a USB webcam instead.**

Cold boot resolved the original PLL lock failure, but the PLL then enters bypass
mode — a different failure state with no known fix.

## What We Know

- **Device**: Apple Facetime HD on PCI bus (`/dev/video0`), device id: 1570
- **Driver**: `facetimehd` (patjak/facetimehd, loaded, module status: Live)
- **Firmware**: `/lib/firmware/facetimehd/firmware.bin` — re-extracted v1.43.0, installed
- **Kernel**: 6.17.9-76061709-generic
- **Permissions**: `/dev/video0` is `crw-rw----+ root:video`, user is in `video` group
- **USB**: Camera is PCI-based, not USB — `lsusb` shows nothing (expected)

### dmesg after warm reboot

```
S2 PCIe link init succeeded
Waiting for S2 PLL to lock at 450 MHz
Failed to lock S2 PLL: 0xc902c902
DDR40 PHY PLL locked on safe settings
Loaded firmware, size: 1392kb
ISP woke up after 0ms
Enabling interrupts
```

### dmesg after cold boot (power-off, wait 20s, power-on)

```
Waiting for S2 PLL to lock at 450 MHz
S2 PLL is locked after 10 us
S2 PLL is in bypass mode                 <-- NEW FAILURE
```

Cold boot fixed the PLL lock, but the PLL then falls into bypass mode — the sensor
clock still doesn't stabilize. No frames produced.

## What We Tried

1. **Checked device exists** — `/dev/video0` is present
2. **Checked driver info** — `modinfo facetimehd` shows module loaded for kernel 6.17.9
3. **Checked permissions** — device is accessible, user in `video` group
4. **Attempted frame capture** — `v4l2-ctl --stream-mmap --stream-count=1` hangs (no frames)
5. **Reloaded module** — `sudo modprobe -r facetimehd && sudo modprobe facetimehd` — no change
6. **Tested with Cheese** — black screen (before reboot), error message (after reboot)
7. **Tested with Teams** — black screen
8. **Re-extracted firmware** — cloned patjak/facetimehd-firmware, `make && sudo make install` (v1.43.0)
9. **Rebooted** — S2 PLL still fails to lock (see dmesg above)
10. **Tried linux-on-mac/bcwc_pcie fork** — fails to compile on kernel 6.17.x (uses
    removed `videobuf-dma-sg.h` API; only patjak/facetimehd supports `videobuf2`)

## Conclusion

The FaceTime HD camera on the 2015 MacBook Pro (device 1570) has multiple failure
modes in the reverse-engineered facetimehd driver on modern kernels (6.17.x):
PLL lock failure on warm boot, PLL bypass mode on cold boot. No reliable software
fix exists. **Use a USB webcam.**

## References

- [patjak/facetimehd](https://github.com/patjak/facetimehd) — main driver repo
- [linux-on-mac/bcwc_pcie](https://github.com/linux-on-mac/bcwc_pcie) — fork (doesn't build on kernel 6.x)
- [Issue #44](https://github.com/patjak/facetimehd/issues/44) — S2 PLL discussion (fixed by kernel upgrade, old kernels)
- [Issue #87](https://github.com/patjak/facetimehd/issues/87) — S2 PLL on Xen (unresolved)
- [Issue #165](https://github.com/patjak/facetimehd/issues/165) — S2 PLL on Fedora (unresolved)
