/// @description WinputDemo
#macro ACTION_UP		0
#macro ACTION_DOWN		1
#macro ACTION_LEFT		2
#macro ACTION_RIGHT		3
#macro ACTION_ATTACK	4

winputInit();//initilize Winput
winputAddAction(ACTION_UP,[ord("W"),vk_up,gp_left_up])//creating an action with optional keybind array
winputBindKey(gp_right_up,ACTION_UP)//example of binding a gamepad axis

winputBindKey(ord("J"),ACTION_UP)//example of binding a single key to an action
winputUnbindKey(ord("J"),ACTION_UP)//example of unbinding a key from an action

//lets bind the rest of our demo controls
winputAddAction(ACTION_DOWN,[ord("S"),vk_down, gp_left_down,gp_right_down])
winputAddAction(ACTION_LEFT,[ord("A"),vk_left, gp_left_left,gp_right_left])
winputAddAction(ACTION_RIGHT,[ord("D"),vk_right, gp_left_right,gp_right_right])

//example of an action with a 10 frame input buffer
winputAddAction(ACTION_ATTACK,[vk_space,vk_enter,gp_face1],10)

//random demo stuff
attackTimer=0
