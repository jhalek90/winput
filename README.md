**Winput**

Wub's Input system.


**Overview:**
Winput is an input management system for Gamemaker Studio 2.3+ that makes use of *Actions* where each action can have multiple keys or gamepad features assigned to it.
This makes it easier to add gamepad support, and allow rebinding of keys in your games.


Example:  To setup an action, you would use the winputAddAction function.

    winputAddAction(ACTION_UP,[ord("W"),vk_up,gp_left_up]);
 This creates and action ACTION_UP (a macro in this case) and assigns a few keys/gamepad inputs to it. Later you can get the state of any of those keys with 

    winputCheck(ACTION_UP);
   This will check W, vk_up, and the gamepad's left axis, and return true if any of those are being pressed by the user.

This simple movement code, supports WASD, arrow keys, and gamepad all at once:

    var _speed=10
    if winputCheck(ACTION_LEFT){x-=_speed}
    if winputCheck(ACTION_RIGHT){x+=_speed}
    if winputCheck(ACTION_UP){y-=_speed}
    if winputCheck(ACTION_DOWN){y+=_speed}




**Useful functions:**

    winputInit(); //Initilize winput
    
    winputCleanup(); //Cleans up winput
    
    winputStep(); //Runs every step to track input buffers
    
    winputAddAction(_actionString,[_keyArray],[_buffer]);////sets up an action,with optional binds and buffer
    
    winputBindKey(_key,_actionString);//binds a key or gamepad feature to an action
    
    winputUnbindKey(_key,_actionString);//unbinds a key from an action
    
    winputUnbindAll(_actionString);//unbind everything from an action
    
    winputCheck(_actionString,_gpNumber);//functions like keyboard_check() but for all assgined keys on this action
    
    winputCheckPressed(_actionString,_gpNumber)//functions like keyboard_check_pressed()
