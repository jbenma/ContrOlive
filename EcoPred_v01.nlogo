; Firstly all the agents are created...
breed [olives olive] ; for each agents type, both the group (plural) and individuals (singular) must be created
breed [flies fly]
breed [spiders spider]
breed [flowers flower]

; ...and attributes for agents are assigned
flies-own [energy]

; The "Clear" block carries the code controlled by the button "Clear" in the Interface
to Clear
  clear-all ; cleans the previous results and restart the situation
  ask patches [ set pcolor 63 ] ; setting color to the ground

  set-default-shape flowers "flower" ; setting shape to agents "flower"
  create-flowers initial-number-flowers
  [
    set color yellow  ; setting color...
    set size 4   ; ...and size
    setxy random-xcor random-ycor ; flowers are randomly positioned along the scenario
  ]

  set-default-shape olives "olive" ; setting shape to agents "olive"
  create-olives initial-number-olives
  [
    set color violet
    set size 1.5
    setxy random-xcor random-ycor ; olives are randomly positioned along the scenario
  ]

  set-default-shape flies "fly" ; setting shape to agents "fly"
  create-flies initial-number-flies
  [
    set color white
    set size 2
    set energy  random 300 ; setting attribute energy for flies
    setxy random-xcor random-ycor ; flies are randomly positioned along the scenario
  ]

  set-default-shape spiders "spider" ; setting shape to agents "spider"
  create-spiders initial-number-spiders
  [
    set color black
    set size 3
    setxy random-xcor random-ycor ; spiders are randomly positioned along the scenario
  ]
  reset-ticks ; resetting ticks to zero
end

; The "Go" block carries the code controlled by the button "Go" in the Interface
to Go
 if not any? flies [stop] ; when the flies population decrease to zero, the system stops
 ask flies [move fed reproduce tire death] ; setting behaviours for flies
 ask spiders [eat-fly] ; setting behaviours for spiders
 display-energy ; allowing to show energy of flies in the Interface
 tick ; advancing one step in time
 end

to move
  ask flies [right random 20 left random 20 forward 2] ; flies will move around the crop

end

to fed
  ask flies [if any? flowers-on patch-ahead 1[set energy energy + 50]] ; flies will feed if a flower is found and its energy will increase in "x" units
end

to reproduce
  ask flies [if any? olives-on patch-ahead 1[hatch-flies 1 [right random 20 left random 20 forward 1]]] ; flies will reproduce if an olive is found hatching one more fly (that will move the same way than its parents)
end

to tire
  ask flies [set energy energy - 2] ; flies will lose "x" units of energy when moving around
end

to death
  ask flies [if energy < 0 [die]] ; flies will die if energy decreases to zero
  ask flies [if count flies > 50 [user-message "Your crop have been invaded!" die]] ; if more than "x" flies are counted within the crop, the system will stop and show the message
end

to eat-fly
  ask flies [if any? spiders-on patch-ahead 1 [die]] ; if a fly-spider encounter occurs, the spider will eat the fly
end

to display-energy
  if Display-energy? [ask flies[set label round energy]] ; if the button is turned "on", flies energy will be shown
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1283
574
-1
-1
15.0
1
10
1
1
1
0
1
1
1
-35
35
-18
18
0
0
1
ticks
30.0

BUTTON
11
10
74
43
Clear
Clear
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
11
53
183
86
Initial-number-olives
Initial-number-olives
0
50
16.0
1
1
NIL
HORIZONTAL

SLIDER
11
92
183
125
Initial-number-flies
Initial-number-flies
0
50
9.0
1
1
NIL
HORIZONTAL

SLIDER
11
132
183
165
Initial-number-spiders
Initial-number-spiders
0
20
18.0
1
1
NIL
HORIZONTAL

BUTTON
82
10
145
43
Go
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

MONITOR
12
252
62
297
Flies
count flies
17
1
11

MONITOR
66
252
153
297
Spiders
count spiders
17
1
11

PLOT
5
303
205
453
Populations
Time
Individuals
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Flies" 1.0 0 -2674135 true "" "plot count flies"
"Spiders" 1.0 0 -13840069 true "" "plot count spiders"

SLIDER
11
170
183
203
Initial-number-flowers
Initial-number-flowers
0
200
62.0
1
1
NIL
HORIZONTAL

SWITCH
12
210
156
243
Display-energy?
Display-energy?
1
1
-1000

@#$#@#$#@
## WHAT IS IT?

Equilibrium: an educational Individual Based Model to demonstrate biological control within arable lands. It can be used for educational purposes to explain ecological concepts such as trophic level, species interactions and biological control in an interactive way simultaneously introducing students to biology oriented programming languages.

## HOW IT WORKS

Equilibrium simulates a top-down trophic cascade controlled by the pressure exerted by an ideal predator (spider) on an ideal pest (fly) within a hypothetical agricultural landscape (an olive crop). Equilibrium reflects the changes on the fly population according to (1) its mortality rate caused by spider’s predation and energy loss, (2) the energy gain by feeding on flowers and (3) its reproduction rate in olives.


## HOW TO USE IT

In the present release (v01) all turtles (spiders, flies, flowers and olives) are placed randomly along the patches that composes the hypothetical crop when the cycle starts (Fig. 2). Flies have an initial random amount of energy (ranging from 1 to 300 units) and move randomly within the grove and behaviors in four ways: (1) if a fly passes near a flower, its energy increases 50 units, (2) if the fly passes next to a patch occupied by a spider it is killed by the spider, (3) if the fly passes near an olive it reproduces and one more fly hatches, and (4) if the fly loss all its energy units then it dies. Spiders, flowers and olives are static and deathless. 

Since the fly population will tend to increase due to reproduction, the objective is to play with the initial number of each turtle to reach equilibrium on the fly population along time to recreate an imaginary threshold on what the pest they represent could be considered controlled.


## THINGS TO NOTICE

If the flies population exceed a maximum number, the message "Your crop have been invaded!" and the system will stop.


## THINGS TO TRY

Move sliders, switches and see the population evolution within the plot.


## EXTENDING THE MODEL

The initial parameters of each turtle such as the initial amount of flies´ energy, the amount of energy provided by flowers, the amount of patches moved in each tick or the behavior of spiders (e.g. allow spiders to move, reproduce and die) can be easily changed along the code by the observer. Also, try to include more agents into the trophic network such as parasitoids, more predator species (e.g. different spider species allowed and not allowed to move simulating intra-guild predation) and different food and reproductive resources for each trophic level.



## CITATION
 
Benhadi-Marín, J., 2017. EcoPred: an educational Individual Based Model to demonstrate biological control within arable lands. DOI:10.5281/zenodo.1030140
Available at: https://github.com/jbenma/Equilibrium/. Version of access() Date()

## CREDITS AND REFERENCES

EcoPred version 1.0 (2-10-2017)
Copyright (C) 2017 Jacinto Benhadi Marín
  
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
 
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details at http://www.gnu.org/licenses/.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

fly
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30
Polygon -7500403 true true 105 165 90 180 45 195 15 180 15 150 60 135 90 135 120 165 105 165
Polygon -7500403 true true 195 165 210 180 255 195 285 180 285 150 240 135 210 135 180 165 195 165

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

olive
true
0
Polygon -7500403 true true 180 225 120 225 75 165 75 90 120 30 180 30 180 225
Polygon -7500403 true true 120 225 180 225 225 165 225 90 180 30 120 30 120 225

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

spider
true
0
Circle -7500403 true true 120 55 60
Circle -7500403 true true 90 105 120
Line -7500403 true 120 90 90 90
Line -7500403 true 90 30 90 90
Line -7500403 true 105 60 105 90
Line -7500403 true 120 105 75 105
Line -7500403 true 75 105 75 150
Line -7500403 true 90 105 90 120
Line -7500403 true 180 90 210 90
Line -7500403 true 210 30 210 90
Line -7500403 true 195 60 195 90
Line -7500403 true 180 105 225 105
Line -7500403 true 225 105 225 150
Line -7500403 true 210 105 210 120

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
