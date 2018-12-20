This was built to fulfil a need I had for an in-car music player.

It had to meet the following requirements:

-   No modifications to the car, use only existing connections
-   Small, easy to hide
-   Low power
-   Connect to the factory head unit’s AUX in
-   Start playing when powered
-   Play tracks randomly from all installed music
-   Support at least .mp3 format
-   Avoid driver distraction:
    -   No display
    -   No additional controls
-   Survive in a hostile power environment with minimal chance of data
    corruption
-   Easy to add/remove music and update any playlist/database

The solution I decided on was a Raspberry Pi Zero, a Pimoroni pHAT DAC,
a large capacity uSD card, raspbian stretch lite, mpd, and mpc. All
running with a read only filesystem.

Music installation is handled by running the pi zero as a USB mass
storage gadget.
