High level performance controller for AMD Vega 64 card
======================================================

Some usefull scripts to control the video card performance (clock/fun speed).

Run the script to read the help:

```bash
./schedule.sh
```

**Note**: In my case I have a integrated card `/sys/class/drm/card0` and
 the Vega 64 card `/sys/class/drm/card1`.
If you have a different configuration should update the scripts to read/write
in the right file.

