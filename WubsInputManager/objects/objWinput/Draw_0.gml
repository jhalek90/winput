/// @description Draw on screen
var _space=16
draw_text(10,10,"walk up: "+string(winputCheck(ACTION_UP)))
draw_text(10,10+(_space*1),"walk down: "+string(winputCheck(ACTION_DOWN)))
draw_text(10,10+(_space*2),"walk left: "+string(winputCheck(ACTION_LEFT)))
draw_text(10,10+(_space*3),"walk right: "+string(winputCheck(ACTION_RIGHT)))

var _atk = winputCheckPressed(ACTION_ATTACK) ? "true" : "false"
draw_text(10,10+(_space*5),"attack: "+_atk)

