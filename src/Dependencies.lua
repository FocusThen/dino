_G.push = require("lib/push")
Class = require("lib/class")
_G.Serialize = require("lib/knife/serialize")

require("src/constants")
require("src/StateMachine")
require("src/Animation")
require("src/Save")
require("src/Util")

require("src/entities/Background")
require("src/entities/Dino")
require("src/entities/Rock")
require("src/entities/Bird")

require("src/states/BaseState")
require("src/states/StartState")
require("src/states/PlayState")
require("src/states/ScoreState")
