/// @description Demo stuff


winputStep();

if winputCheckPressed(ACTION_ATTACK){
	attackTimer=10
}

if attackTimer>0{
	attackTimer--;
}