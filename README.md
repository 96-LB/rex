<div align="center"><image src="/Icon.png" alt="REX logo. Yellow armadillo holding lollipop and wearing dinosaur hat" width=96></image></div>

# REX
**REX** is a mod for the Rift of the NecroDancer chart editor which adds additional monster types and extends vanilla enemies with additional variants.

The current version is <ins>**v0.1.1**</ins>. Downloads for the latest version can be found [here](https://github.com/96-LB/rex/releases/latest). The changelog can be found [here](Changelog.md).

> [!IMPORTANT]
> In order to use REX **to create a chart**, you must opt in to the public beta version of **the editor** by switching to the `testing` branch on Steam. Then, you must turn on the "choreomap" toggle in your chart settings.
>
> In order **to play a chart** which uses REX, you must opt in to the public beta version of **the game** by switching to the `publicbetatesting` branch on Steam.
>
> Choreomaps are still in beta, so expect bugs!



# Installation

1. Navigate to the latest release of REX [here](https://github.com/96-LB/rex/releases/latest).

> [!CAUTION]
> Do NOT download the source code using the button at the top of this page. If you're downloading a `.zip` file, you are at the wrong place.

2. Expand the "Assets" tab at the bottom and download `rex-0.1.1.necromod`.

3. Install the latest release of [KatieLib](https://codeberg.org/rawstberry/rift-klib/releases/latest). REX requires version 1.0.5 or newer in order to generate enemy animations.

> [!IMPORTANT]
> Do not forget to install KatieLib! REX will appear to work fine in the editor without it, but your enemies will be invisible in-game.

5. Open your chart editor, press Ctrl-M to open the mod menu, and click on the little folder icon to open your mod directory.

6. Copy `KatieLib-1.0.5.necromod` (or newer) and `rex-0.1.1.necromod` into your mod directory.

7. Activate the mods in your mod menu. If everything is properly installed, new enemies should appear in the sidebar on the right! You may need to restart the editor for your mods to be fully loaded.



# Enemy Guide

REX builds off of the vanilla enemy design, using colours in a consistent way across monster types to indicate how an enemy behaves. The colour scheme used by REX is:

- **White/Green**: The most basic version of the enemy. Takes a single hit to defeat.
- **Blue** - Takes two hits to defeat.
- **Yellow** - Takes three hits to defeat.
- **Pink** *(new!)* - Takes four hits to defeat.
- **Red** - Tricky! These enemies put a twist on their usual behaviour. They might move in a unique way, or have different timings than usual.

Not all vanilla enemies use all of the available colours, so REX adds some missing variants.


## Slimes

### Pink Slime
Takes **4** hits to defeat, each **1** beat apart.

<image src="/assets/slime_pink/00.png" alt="Pink slime" width=96></image>

### Red Slime 
Takes **2** hits to beat, each **1.5** beats apart. It slows down after the first hit, so watch out!

<image src="/assets/slime_red/00.png" alt="Red slime" width=96></image>


## Harpies

### Yellow Harpy
Moves every two beats, but jumps two spaces at a time. Flies over traps. Takes **3** hits to defeat, each two beats apart.

<image src="/assets/harpy_yellow/15.png" alt="Yellow harpy" width=96></image>

### Pink Harpy
Moves every two beats, but jumps two spaces at a time. Flies over traps. Takes **4** hits to defeat, each two beats apart.

<image src="/assets/harpy_pink/15.png" alt="Pink harpy" width=96></image>


## Devils

Devils (devilled eggs) are similar to armadillos, but their timings are slightly different. Armadillos are hit three times per beat (triplets), but devils are hit four times per beat. While armadillos are useful in songs with triplet swing, devils should instead be used for fast rhythms in songs with lots of sixteenth notes.

### Green Devil
Takes **1** hit to beat. Identical to a green slime.

<image src="/assets/devil_green/00.png" alt="Green Devil inside egg" width=96></image>

### Blue Devil
Takes **2** hits to beat, each **0.25** beats apart.

<image src="/assets/devil_blue/00.png" alt="Blue Devil inside egg" width=96></image> <image src="/assets/devil_blue/h00.png" alt="Blue Devil" width=96></image>

### Yellow Devil
Takes **3** hits to beat, each **0.25** beats apart.

<image src="/assets/devil_yellow/00.png" alt="Yellow Devil inside egg" width=96></image> <image src="/assets/devil_yellow/h00.png" alt="Yellow Devil" width=96></image>

### Pink Devil
Takes **4** hits to beat, each **0.25** beats apart.

<image src="/assets/devil_pink/00.png" alt="Pink Devil inside egg" width=96></image> <image src="/assets/devil_pink/h00.png" alt="Pink Devil" width=96></image>

### Red Devil
Takes **2** hits to beat, each **0.75** beats apart. Like a red armadillo, but slightly slower.

<image src="/assets/devil_red/00.png" alt="Red Devil inside egg" width=96></image> <image src="/assets/devil_red/h00.png" alt="Red Devil" width=96></image>


## Spiders

Spiders are similar to zombies, but they jump back and forth between two lanes instead of moving across all three. Multi-hit spiders keep switching between lanes after being hit, similar to red bats.

### Green Spider
Switches between two lanes every beat. Takes **1** hit to beat.

<image src="/assets/spider_green/00.png" alt="Green Spider" width=96></image>

### Blue Spider
Switches between two lanes every beat, even after getting hit. Takes **2** hits to beat.

<image src="/assets/spider_blue/00.png" alt="Blue Spider" width=96></image>

### Yellow Spider
Switches between two lanes every beat, even after getting hit. Takes **3** hits to beat.

<image src="/assets/spider_yellow/00.png" alt="Yellow Spider" width=96></image>

### Pink Spider
Switches between two lanes every beat, even after getting hit. Takes **4** hits to beat.

<image src="/assets/spider_pink/00.png" alt="Green Pink" width=96></image>



# Art Credits
**Devilled Eggs** - Tyrantin
