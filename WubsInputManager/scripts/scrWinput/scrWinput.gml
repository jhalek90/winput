// Script: 
#macro gp_left_up 30001
#macro gp_left_down 30002
#macro gp_left_right 30003
#macro gp_left_left 30004
#macro gp_right_up 30005
#macro gp_right_down 30006
#macro gp_right_right 30007
#macro gp_right_left 30008

function winputInit(){
	global.winputActionList=ds_list_create()
}

function winputStep(){
	for(var i=0; i<ds_list_size(global.winputActionList); i++){
		_this=global.winputActionList[| i]
		_this.step();
	}
}

function winputCleanup(){
	ds_list_destroy(global.winputActionList)
}

function winputAction(_actionString,_keyArray,_buffer) constructor{
	actionString=_actionString;
	keyBindList=ds_list_create();
	if !is_undefined(_keyArray) and is_array(_keyArray){
		for(var i=0; i<array_length(_keyArray); i++){
			ds_list_add(keyBindList,_keyArray[i]);
		}
	}
	
	held=false;
	pressed=false;
	buffer=0
	
	if is_undefined(_buffer){
		bufferMax=0;
	}else{
		bufferMax=_buffer;
	}
	
	function step(){
		if buffer>0{
			buffer--;
		}	
	}
}

function winputAddAction(_actionString,_keyArray,_buffer){
	ds_list_add(global.winputActionList,new winputAction(_actionString,_keyArray,_buffer));
	return global.winputActionList[| ds_list_size(global.winputActionList)-1];
}

function winputBindKey(_key,_actionString){
	var _success=false;
	for(var i=0; i<ds_list_size(global.winputActionList); i++){
		var _this=global.winputActionList[| i];
		if _this.actionString=_actionString{
			ds_list_add(_this.keyBindList,_key)
			_success=true;
		}
	}
	return _success;
}

function winputUnbindKey(_key,_actionString){
	var _success=false;
	for(var i=0; i<ds_list_size(global.winputActionList); i++){
		var _this=global.winputActionList[| i];
		if _this.actionString=_actionString{
			var _pos=ds_list_find_index(_this.keyBindList,_key);
			if _pos>-1{
				ds_list_delete(_this.keyBindList,_pos);
				_success=true;
			}
		}
	}
	return _success;
}

function winputUnbindAll(_actionString){
	var _success=false;
	for(var i=0; i<ds_list_size(global.winputActionList); i++){
		var _this=global.winputActionList[| i];
		if _this.actionString=_actionString{
			ds_list_clear(_this.keyBindList);
			_success=true;
		}
	}
	return _success;
}
	
function winputCheck(_actionString,_gpNumber){
	var _check=false;
	for(var i=0; i<ds_list_size(global.winputActionList); i++){
		var _this=global.winputActionList[| i];
		if _this.actionString=_actionString{
			for(var j=0; j<ds_list_size(_this.keyBindList); j++){
				if __winputCheckWrapper(_this.keyBindList[| j],_gpNumber){
					_check=true;
					_this.buffer=_this.bufferMax;
				}
				if _this.buffer>0{
					_check=true;
				}
			}
		}
	}
	return _check
}
	
function winputCheckPressed(_actionString,_gpNumber){
	var _check=false;
	for(var i=0; i<ds_list_size(global.winputActionList); i++){
		var _this=global.winputActionList[| i];
		if _this.actionString=_actionString{
			for(var j=0; j<ds_list_size(_this.keyBindList); j++){
				if __winputCheckPressedWrapper(_this.keyBindList[| j],_gpNumber){
					_check=true;
					_this.buffer=_this.bufferMax;
				}
				
				if _this.buffer>0{
					_check=true;
				}
			}
		}
	}
	return _check
}

function __winputCheckWrapper(_key,_gpNumber){
	if _key>30000{//gamepad
		if is_undefined(_gpNumber){
			_gpNumber=0;
		}
		
		if (_key == gp_left_up){
			return gamepad_axis_value(_gpNumber,gp_axislv)<-0.5 ? true : false;
		}
		
		if (_key == gp_left_down){
			return gamepad_axis_value(_gpNumber,gp_axislv)>0.5 ? true : false;
		}
		
		if (_key == gp_left_left){
			return gamepad_axis_value(_gpNumber,gp_axislh)<-0.5 ? true : false;
		}
		
		if (_key == gp_left_right){
			return gamepad_axis_value(_gpNumber,gp_axislh)>0.5 ? true : false;
		}
		
		if (_key == gp_right_up){
			return gamepad_axis_value(_gpNumber,gp_axisrv)<-0.5 ? true : false;
		}
		
		if (_key == gp_right_down){
			return gamepad_axis_value(_gpNumber,gp_axisrv)>0.5 ? true : false;
		}
		
		if (_key == gp_right_left){
			return gamepad_axis_value(_gpNumber,gp_axisrh)<-0.5 ? true : false;
		}
		
		if (_key == gp_right_right){
			return gamepad_axis_value(_gpNumber,gp_axisrh)>0.5 ? true : false;
		}
		
		return gamepad_button_check(_gpNumber,_key);
	}
	return keyboard_check(_key);
}
	
function __winputCheckPressedWrapper(_key,_gpNumber){
	if _key>30000{//gamepad
		if is_undefined(_gpNumber){
			_gpNumber=0;
		}
		return gamepad_button_check_pressed(_gpNumber,_key);
	}
	return keyboard_check_pressed(_key);
}