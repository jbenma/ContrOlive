; Firstly all the agents are created...
breed [olives olive] ; for each agents type, both the group (plural) and individuals (singular) must be created
breed [flies fly]
breed [web-females spider]
breed [ground-spiders spider2]
breed [flowers flower]
breed [stones stone]
breed [web-males webmale]
breed [parasitoids parasitoid]

; ...and attributes for agents are assigned
flies-own [energy]
web-females-own [energy]
web-males-own [energy]
ground-spiders-own [energy]

; The "Clear" block carries the code controlled by the button "Clear" in the Interface
to Clear
  clear-all ; cleans the previous results and restart the situation
  ask patches [ set pcolor 62 ] ; setting color to the ground

  set-default-shape flowers "flower" ; setting shape to agents "flower"
  create-flowers initial-number-flowers
  [
    set color yellow  ; setting color...
    set size 3.5   ; ...and size
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
    set energy 50 ; setting attribute energy for flies
    setxy random-xcor random-ycor ; flies are randomly positioned along the scenario
  ]

  set-default-shape web-females "web-female" ; setting shape to agents "spider"
  create-web-females initial-number-web-females
  [
    set color black
    set size 3
    set energy 50
    setxy random-xcor random-ycor ; spiders are randomly positioned along the scenario
  ]

  set-default-shape web-males "web-male" ; setting shape to agents "spider"
  create-web-males initial-number-web-males
  [
    set color black
    set size 2
    set energy 50
    setxy random-xcor random-ycor ; spiders are randomly positioned along the scenario
  ]

   set-default-shape ground-spiders "ground-spider" ; setting shape to agents "spider2"
  create-ground-spiders initial-number-ground-spiders
  [
    set color brown
    set size 3
    set energy 50
    setxy random-xcor random-ycor ; spiders are randomly positioned along the scenario
  ]

  set-default-shape stones "stone" ; setting shape to agents "stone"
  create-stones initial-number-stones
  [
    set color brown  ; setting color...
    set size 4   ; ...and size
    setxy random-xcor random-ycor ; flowers are randomly positioned along the scenario
  ]

  reset-ticks ; resetting ticks to zero
end

; The "Go" block carries the code controlled by the button "Go" in the Interface
to Go
 if not any? flies [stop] ; if more than "x" flies are counted within the crop, the system will stop and show the message
 if count flies > 2000 [user-message "Your crop have been invaded!" stop]
 if count web-females > 1000 [stop]
 if count web-males > 1000 [stop]
 if count ground-spiders > 1000 [stop]
 ask flies [move fed reproduce death set energy energy - 1 ] ; setting behaviours for flies
 ask web-females [fed-a reproduce-a death set energy energy - 1 ] ; setting behaviours for spiders
 ask web-males [move fed-b reproduce-b maintain-b death set energy energy - 1 ]
 ask ground-spiders [move-b fed-c reproduce-c maintain-c death set energy energy - 1 ]
 tick ; advancing one step in time
 end


to maintain-b
  if count web-males <= 15 [hatch 10 [setxy random-xcor random-ycor]]
end

to maintain-c
  if count ground-spiders <= 15 [hatch 10 [setxy random-xcor random-ycor]]
end

to move
 right random 20 left random 20 forward 1 ; flies will move around the crop
 end

to move-b
 right random 50 left random 50 forward 1 ; flies will move around the crop
end


to fed
  if any? flowers-on patch-ahead 1 [set energy energy + 15] ; flies will feed if a flower is found and its energy will increase in "x" units
end

to fed-a
if any? flies-on patch-ahead 1 [set energy energy + 15]
ask flies-on patch-ahead 1 [die]
end

to fed-b
if any? flies-on patch-ahead 1 [set energy energy + 15]
ask flies-on patch-ahead 1 [die]
end

to fed-c
if any? flies-on patch-ahead 1 [set energy energy + 15]
ask flies-on patch-ahead 1 [die]

if any? web-males-on patch-here [set energy energy + 15]
ask web-males-on patch-here [die]
end


to reproduce
  if any? olives-on patch-here [hatch-flies 2 [right random 20 left random 20 forward 10]] ; flies will reproduce if an olive is found hatching one more fly (that will move the same way than its parents)
end

to reproduce-a
  if any? web-males-on patch-here [hatch-web-females 1 [setxy random-xcor random-ycor]]
end

to reproduce-b
  if any? web-females-on patch-here [hatch-web-males 1 [setxy random-xcor random-ycor]]
end

to reproduce-c
  if any? stones-on patch-here [hatch-ground-spiders 1 [setxy random-xcor random-ycor]]
end


to death
if energy < 1 [die] ; flies will die if energy decreases to zero
  ;ask flies [if count flies > 2000 [user-message "Your crop have been invaded!" die]] ; if more than "x" flies are counted within the crop, the system will stop and show the message
  ;ask ground-spiders [if count ground-spiders > 5000 [user-message "Your crop have been invaded... by spiders!" die]]
  ;ask web-spiders [if count web-spiders > 5000 [user-message "Your crop have been invaded... by spiders!" die]]
end
@#$#@#$#@
GRAPHICS-WINDOW
530
25
1324
511
-1
-1
12.9
1
10
1
1
1
0
1
1
1
0
60
0
36
1
1
1
ticks
200.0

BUTTON
8
10
71
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
3
87
175
120
Initial-number-olives
Initial-number-olives
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
224
57
395
90
Initial-number-flies
Initial-number-flies
0
50
50.0
1
1
NIL
HORIZONTAL

SLIDER
224
92
395
125
Initial-number-web-females
Initial-number-web-females
0
20
0.0
1
1
NIL
HORIZONTAL

BUTTON
79
10
142
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
1

MONITOR
408
59
498
104
Flies
count flies
0
1
11

MONITOR
407
106
490
151
Web-Spiders
count web-females + count web-males
0
1
11

PLOT
47
203
491
523
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
"Web-spiders" 1.0 0 -13840069 true "" "plot count web-females + count web-males"
"Ground-spiders" 1.0 0 -955883 true "" "plot count ground-spiders"

SLIDER
3
125
175
158
Initial-number-flowers
Initial-number-flowers
0
50
50.0
1
1
NIL
HORIZONTAL

SLIDER
225
163
395
196
Initial-number-ground-spiders
Initial-number-ground-spiders
0
20
0.0
1
1
NIL
HORIZONTAL

MONITOR
407
154
504
199
ground-Spiders
count ground-spiders
0
1
11

SLIDER
3
163
175
196
Initial-number-stones
Initial-number-stones
0
50
50.0
1
1
NIL
HORIZONTAL

SLIDER
224
128
395
161
Initial-number-web-males
Initial-number-web-males
0
20
0.0
1
1
NIL
HORIZONTAL

TEXTBOX
275
24
367
49
Species
20
0.0
0

TEXTBOX
34
55
166
80
Environment
20
0.0
1

@#$#@#$#@
## WHAT IS IT?

EcoPred: an educational Individual Based Model to teach biological control within arable lands. It can be used for educational purposes to explain ecological concepts such as trophic level, species interactions and biological control in an interactive way simultaneously introducing students to biology oriented programming languages.

## HOW IT WORKS

EcoPred simulates a top-down trophic cascade controlled by the pressure exerted by two virtual predators (ground spiders and web-spiders) on an virtual pest (fly) within a hypothetical agricultural landscape (an olive crop). EcoPred reflects the changes on the fly population according to (1) its mortality rate caused by spider’s predation and energy loss, (2) the energy gain by feeding on flowers and (3) its reproduction rate in olives.

In the present release all turtles (spiders, flies, stones, flowers and olives) are placed randomly along the patches that composes the hypothetical crop when the cycle starts. Flies have an initial random amount of energy, move randomly within the grove and behaviors in four ways: (1) if a fly passes near a flower, its energy increases 50 units, (2) if the fly passes next to a patch occupied by a spider it is killed by the spider, (3) if the fly passes near an olive it reproduces and more flies hatch, and (4) if the fly loss all its energy units then it dies. Ground spiders reproduce if they found a stone, loose and gain energy according to the number of eaten flies and flowers and olives are static and deathless. 

Since the fly population will tend to increase due to reproduction, the objective is to play with the initial number of each turtle to control on the fly population along time to recreate an imaginary threshold on what the pest they represent could be considered controlled.


## THINGS TO NOTICE

If the flies population exceed a maximum number, the message "Your crop have been invaded!" and the system will stop.


## THINGS TO TRY

Move sliders, switches and see the population evolution within the plot.


## EXTENDING THE MODEL

The initial parameters of each turtle such as the initial amount of flies´ energy, the amount of energy provided by flowers, the amount of patches moved in each tick or the behavior of spiders (e.g. allow spiders to move, reproduce and die) can be easily changed along the code by the observer. Also, try to include more agents into the trophic network such as parasitoids, more predator species (e.g. different spider species allowed and not allowed to move simulating intra-guild predation) and different food and reproductive resources for each trophic level.



## CITATION
 
Benhadi-Marín, J., 2017. EcoPred: an educational Individual Based Model to explain biological control, a case study within an arable land. DOI:10.5281/zenodo.1030140
Available at: https://github.com/jbenma/EcoPred/. Version of access() Date()

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

ground-spider
true
0
Polygon -2674135 true false 150 240 120 225 120 180 135 165 165 165 180 180 180 225 150 240
Line -6459832 false 135 150 90 150
Line -6459832 false 135 150 105 105
Line -6459832 false 150 150 90 180
Line -6459832 false 135 150 90 120
Line -6459832 false 150 150 210 180
Line -6459832 false 165 150 195 105
Line -6459832 false 165 150 210 150
Line -6459832 false 165 150 210 120
Circle -2674135 true false 129 129 42

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

stone
true
0
Polygon -6459832 true false 120 45 75 75 60 105 45 150 60 165 90 180 165 195 255 180 285 135 285 105 255 75 210 60 150 45
Polygon -16777216 false false 45 150 60 105 75 75 120 45 150 45 210 60 255 75 285 105 285 135 255 180 165 195 90 180 60 165

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

web-female
true
0
Line -16777216 false 135 120 105 120
Line -16777216 false 105 60 105 120
Line -16777216 false 120 90 120 120
Line -16777216 false 135 135 90 135
Line -16777216 false 90 135 90 180
Line -16777216 false 105 135 105 150
Line -16777216 false 165 120 195 120
Line -16777216 false 195 60 195 120
Line -16777216 false 180 90 180 120
Line -16777216 false 165 135 210 135
Line -16777216 false 210 135 210 180
Line -16777216 false 195 135 195 150
Line -7500403 true 105 15 195 15
Line -7500403 true 30 90 105 15
Line -7500403 true 195 15 270 90
Line -7500403 true 30 90 30 225
Line -7500403 true 195 285 270 225
Line -7500403 true 270 90 270 225
Line -7500403 true 105 285 30 225
Line -7500403 true 105 285 195 285
Line -7500403 true 30 225 270 90
Line -7500403 true 150 15 150 285
Line -7500403 true 30 150 270 150
Line -7500403 true 30 90 270 225
Line -7500403 true 195 285 105 15
Line -7500403 true 105 285 195 15
Line -7500403 true 45 105 120 30
Line -7500403 true 180 270 240 225
Line -7500403 true 240 225 240 105
Line -7500403 true 255 210 255 105
Line -7500403 true 105 270 180 270
Line -7500403 true 45 225 45 105
Line -7500403 true 105 270 45 225
Line -7500403 true 120 30 195 30
Line -7500403 true 255 105 195 30
Line -7500403 true 240 105 180 60
Line -7500403 true 180 60 120 60
Line -7500403 true 120 60 75 120
Line -7500403 true 75 120 75 210
Line -7500403 true 75 210 120 240
Line -7500403 true 120 240 180 240
Line -7500403 true 180 240 225 195
Line -7500403 true 225 120 225 195
Line -7500403 true 225 120 165 90
Line -7500403 true 165 90 135 90
Line -7500403 true 135 90 105 135
Circle -16777216 true false 105 135 90
Circle -16777216 true false 125 105 50

web-male
true
0
Polygon -16777216 true false 150 240 120 225 120 180 135 165 165 165 180 180 180 225 150 240
Circle -16777216 true false 129 129 42
Line -955883 false 135 150 90 150
Line -955883 false 135 150 105 105
Line -955883 false 150 150 90 180
Line -955883 false 135 150 90 120
Line -955883 false 150 150 210 180
Line -955883 false 165 150 195 105
Line -955883 false 165 150 210 150
Line -955883 false 165 150 210 120

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
NetLogo 6.0.3
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
