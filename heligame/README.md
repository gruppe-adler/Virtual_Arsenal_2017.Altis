# GRAD Heligame
Generates random LZs to practice your landing skills.

## Dependencies
* [SHK pos](https://forums.bistudio.com/forums/topic/153382-shk_pos/)
* [CBA_A3](https://github.com/CBATeam/CBA_A3)

## Installation
1. Copy heligame folder and contents to your mission
2. Include the `cfgFunctions.hpp` in the heligame folder in your `cfgFunctions`

Example:

```sqf
class CfgFunctions {
    #include "heligame\cfgFunctions.hpp"
};
```

## Usage
Get into any helicopter and execute the *Heligame!* mouse wheel action. Fly to the LZ (marked on map), land on the smoke, wait until the next LZ is generated. Repeat until you can land like a pro. Will end automatically when you stop completing your LZs.
