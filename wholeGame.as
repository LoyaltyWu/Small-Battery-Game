
var middleX: Number = stage.stageWidth / 2;
var middleY: Number = stage.stageHeight / 2;
thisCanon1.x=0;
thisCanon1.y=0;
addEventListener(Event.ENTER_FRAME,onEnterFrame);
var bigArray:Array = new Array();//����Rocket����
var greenPlaneArray:Array = new Array();// �ɴ�ɻ�����
var theRandomAngleAdd:Number = 0;
function onEnterFrame(event:Event):void {
	if (alive){
		var dx:Number=mouseX - thisCanon1.x;
		var dy:Number=mouseY - thisCanon1.y;
		var radians:Number=Math.atan2(dy,dx);
		thisCanon1.rotation=radians * 180 / Math.PI;


		planeHitRocket();
		planeHadHitCastle();

		checkAndDelete();


		greenPlaneArray.forEach(everyNaziPlaneLaunching);
		//	anotherRocketLaunch();
		bigArray.forEach(everyRocketLaunching);
	}
}


stage.addEventListener(KeyboardEvent.KEY_DOWN, Stage_DOWN);
//��̨�������̰��£��ͷţ�KEY_UP��
function Stage_DOWN(E:KeyboardEvent){ //���̰��º���
	if (E.keyCode == 32) { //���¿ո��
		if (alive){
			help.text = "";
			anotherRocketLaunch();
			newNaziPlane();
		}
	}
};

var alive:Boolean = true;
var scoreboard:TextField = new TextField();
scoreboard.text = "score: 0";
var score:Number = 0;
addChild(scoreboard);
scoreboard.x = -middleX + 60;
scoreboard.y = -middleY + 30;



// ��ʼ3��
var help:TextField = new TextField();
help.text = "�ػ���̨\n�����ɴ�л�!\n���ո�����������������̨����\n���ô���Խ�࣬��\n�����ɳ�����л�\n���¿ո񼴿ɿ�ʼ"
help.y = -middleY + 30;
help.x = -15;
addChild(help);
// ��ʼ3��

stage.addEventListener(MouseEvent.CLICK,onPress_Handler); // ���˵Ļ������¿�ʼ
function onPress_Handler(e:MouseEvent):void {
	if (alive == false){
		help.text = "�ػ���̨\n�����ɴ�л�!\n���ո�����������������̨����\n���ô���Խ�࣬�з����ɳ�����л�\n���¿ո񼴿ɿ�ʼ"
		score = 0;
		scoreboard.text = "score: 0";
		var i = 0;
		var lenRocket = bigArray.length;
		for (i = lenRocket;i>=0;i--){
			if (bigArray[i] != undefined){
				removeChild(bigArray[i]);
			}
		}
		for (i = lenRocket;i>=0;i--){
			bigArray.splice(i,1);
		}
		var lenPlane = greenPlaneArray.length;
		for (i = lenPlane;i>=0;i--){
			if (greenPlaneArray[i] != undefined){
				removeChild(greenPlaneArray[i]);
			}
		}
		for (i = lenPlane;i>=0;i--){
			greenPlaneArray.splice(i,1);
		}
		// play();
		alive = true;
		//��play();
	}
}

//

// Nazi Plane

function planeHadHitCastle(){
	var j = 0;
	var len = greenPlaneArray.length;
	for (j = 0;j<greenPlaneArray.length;j++){
		var p:GreenNaziPlane = greenPlaneArray[j];
		var distance:Number = Math.sqrt((p.x)*(p.x)+(p.y)*(p.y));
		if (distance < 40){
			stop();
			alive = false;
			// score = 0;
			help.text = "���ķ�����:"+score.toString()+"\n�������������";
			break;
		}
	}
}
function planeHitRocket(){
	var i = 0;
	var j = 0;
	var delPArr = new Array();
	var delRArr = new Array();
	for (i = 0;i<bigArray.length;i++){
		delRArr[i] = 0;
	}
	for (j = 0;j<greenPlaneArray.length;j++){
		delPArr[i] = 0;
	}
	for (i = 0;i<bigArray.length;i++){
		for (j = 0;j<greenPlaneArray.length;j++){
			var r:Rocket = bigArray[i];
			var p:GreenNaziPlane = greenPlaneArray[j];
			var distance:Number = Math.sqrt((r.x-p.x)*(r.x-p.x)+(r.y-p.y)*(r.y-p.y));
			if (distance < 20){
				delRArr[i] = 1;
				delPArr[j] = 1;
			}
		}
	}
	var rocketLength:Number = delRArr.length;
	for (i = rocketLength - 1;i >= 0;i--){
		if (delRArr[i] == 1){
			trace("stop rocket"+i);
			removeChild(bigArray[i]);
			bigArray.splice(i,1);
		}
	}
	var planeLength:Number = delPArr.length;
	for (i = planeLength - 1;i >= 0;i--){
		if (delPArr[i] == 1){
			removeChild(greenPlaneArray[i]);
			trace("one plane down");
			trace(i);
			score++;
			trace("one plane down");
			greenPlaneArray.splice(i,1);
			var tmpScoreStr:String = score.toString();
			scoreboard.text = "score: " + tmpScoreStr;
		}
	}
}

function everyNaziPlaneLaunching(newOne:*, index:int, arr:Array):void {
	var angle:Number = newOne.rotation;
	var speed:Number = 5;
	var ySpeed:Number = Math.sin(angle*Math.PI/180) * speed;
	var xSpeed:Number = Math.cos(angle*Math.PI/180) * speed;
	newOne.x = newOne.x + xSpeed;
	newOne.y = newOne.y + ySpeed;
}
function newNaziPlane(){
	var newPlane:GreenNaziPlane = new GreenNaziPlane();

	addChild(newPlane);
	var nowAngle:Number = theRandomAngleAdd;
	theRandomAngleAdd += 97;
	theRandomAngleAdd %= 360;
	var maxLength = Math.sqrt(stage.stageHeight * stage.stageHeight + stage.stageWidth * stage.stageWidth)-200;
	var yMax:Number = Math.sin(nowAngle*Math.PI/180) * maxLength;
	var xMax:Number = Math.cos(nowAngle*Math.PI/180) * maxLength;
	newPlane.rotation = nowAngle + 180;
	newPlane.x = xMax;
	newPlane.y = yMax;
	// transform
	/*
	������ֻ��������б�ɫ�ģ��������ڿ�ʼ���ķɻ�����ɫ����ɫͨ��һû�о�ʲô��û���ˣ�ֱ�Ӿͳʰ�ɫ�ˡ�
	var oneRandom:Number = (Math.random() * 1000);
	var hR:Number = 1;
	var tR:Number = 1;
	var oR:Number = 1;
	oneRandom = (Math.random() * 1000);
	if (oneRandom <= 500){
		hR = -1;
	}
	oneRandom = (Math.random() * 1000);
	if (oneRandom <= 500){
		tR = -1;
	}
	oneRandom = (Math.random() * 1000);
	if (oneRandom <= 500){
		oR = -1;
	}
	if (tR == -1){
		oneRandom = (Math.random() * 1000);
		if (oneRandom <= 500){
			hR *= 0.3;
			oR *= 0.7;
		}
		else {
			hR *= 0.7;
			oR *= 0.3;
		}
	}
	newPlane.transform.colorTransform=new ColorTransform(hR,tR,oR,1, 255,255,255,0);
	*/
	// transform
	greenPlaneArray.push(newPlane);
}
// Rocket
function everyRocketLaunching(newOne:*, index:int, arr:Array):void {
	var angle:Number = newOne.rotation;
	var speed:Number = 10;
	var ySpeed:Number = Math.sin(angle*Math.PI/180) * speed;
	var xSpeed:Number = Math.cos(angle*Math.PI/180) * speed;
	newOne.x = newOne.x + xSpeed;
	newOne.y = newOne.y + ySpeed;
}

function firstJump(one:Rocket){
	var angle:Number = one.rotation;
	var speed:Number = 40;
	var ySpeed:Number = Math.sin(angle*Math.PI/180) * speed;
	var xSpeed:Number = Math.cos(angle*Math.PI/180) * speed;
	one.x = one.x + xSpeed;
	one.y = one.y + ySpeed;
}

var rocketNum:Number = 0;
function anotherRocketLaunch(){
	trace("rocket"+bigArray.length);
	var newOne:Rocket = new Rocket();
	var dx:Number=mouseX - thisCanon1.x;
	var dy:Number=mouseY - thisCanon1.y;
	var radians:Number=Math.atan2(dy,dx);
	newOne.rotation=radians * 180 / Math.PI;
	firstJump(newOne);
	addChild(newOne);
	bigArray.push(newOne);
}

function checkAndDelete(){
	var i:Number = 0;
	var len:Number = bigArray.length;
	for (i = len - 1;i >= 0;i--){
		if (checkShouldDelete(bigArray[i])){
			removeChild(bigArray[i]);
			bigArray.splice(i,1);
		}
	}
}
function checkShouldDelete(element:Rocket):Boolean {
	var maxLength = Math.sqrt(stage.stageHeight * stage.stageHeight + stage.stageWidth * stage.stageWidth) + 40;
	var nowDistance = Math.sqrt(element.x*element.x + element.y * element.y) - 40;
	return (maxLength < nowDistance);
}