//all sounds courteosy of freesound.org
import processing.sound.*;
SoundFile dingFile;
SoundFile DoorClosingFile;
SoundFile DoorOpeningFile;
SoundFile ElevatorHumFile;
SoundFile ElectricHumFile;
boolean handiPressed = false;
boolean circleOver = false;
boolean rectOver1 = false;
boolean rectOver2 = false;
boolean rectOver3 = false;
boolean rectOverCont = false;
boolean onFirstFloor = true;
boolean onSecondFloor = false;
boolean onThirdFloor = false;
boolean onDoorCont = false;
boolean DoorOpen = true;
boolean TimerStart = false;
boolean TimerFinish = true;
boolean FirstFloorButt = false;
boolean SecFloorButt = false;
boolean ThirdFloorButt = false;

int ButtonX = 975;
int ButtonSize = 50;
int Button1Y = 300;
int FloorNum = 1;
int NewFloorNum = 1;

int DoorLeftOrig = 50;
int DoorLeft = 50;
int DoorRight = 375;

int curMillis = millis();


void setup() {
  size(1280, 720);
  frameRate(60);
  dingFile = new SoundFile(this, "ding.wav");
  DoorClosingFile = new SoundFile(this, "DoorClosing.wav");
  DoorOpeningFile = new SoundFile(this, "DoorOpening.wav");
  ElevatorHumFile = new SoundFile(this, "ElevatorHum.wav");
  ElectricHumFile = new SoundFile(this, "ElectricHum.wav");
  DoorOpeningFile.play();
}

void draw() {
  background(255);
  update(mouseX, mouseY);
  int timer = 0;
  
  Door();
  //Elevator Outline
  fill(75);
  stroke(75);
  rect(0,0,50,720);
  rect(0,0,1280,50);
  rect(700, 0, 1280, 720);
  //end Elevator Outline
  Speaker();
  fill(0);
  rect(988, 170, 25, 300);
  ButtonPanel(Button1Y);
  if(!onDoorCont) ButtonNums();
  else DoorControls();
  
  HandicapButton();
  if(FloorNum != NewFloorNum) {
    if(TimerFinish) {
      DoorClosingFile.play();
      TimerStart = true;
      TimerFinish = false;
      frameCount = 0;
      timer = frameCount;
      ElevatorHumFile.play();
    }
  }
  if(TimerStart && DoorLeft == DoorLeftOrig){
    
    if(frameCount > timer+300) {
      DoorOpeningFile.play();
      TimerStart = false;
      TimerFinish = true;
      FloorNum = NewFloorNum;
      frameCount = 0;
      timer = 0;
      DoorOpen = true;
      dingFile.play();
      FirstFloorButt = false;
      SecFloorButt = false;
      ThirdFloorButt = false;
    }
  }
  FloorNumber(FloorNum);
  if(handiPressed){
    if(Button1Y < 400) Button1Y++;
  }
  if(!handiPressed){
    if(Button1Y > 300) Button1Y--;
  }
  if(DoorOpen) {
    if(DoorLeft < 700) DoorLeft+=6;
    if(DoorRight < 700) DoorRight+=3; 
  }
  if(!DoorOpen) {
    if(DoorLeft > 50) DoorLeft-=6;
    if(DoorRight > 375) DoorRight-=3;
  }
}

void Door() {
  fill(50);
  stroke(0);
  rect(DoorLeft,50,325,669);
  rect(DoorRight,50,325,669);
}

void Speaker() {
  noStroke();
  fill(0);
  int CenterCircX = 875;
  int CenterCircY = 500;
  int CircSize = 5;
  int CircSpacing = 10;
  ellipse(CenterCircX, CenterCircY, CircSize, CircSize);
  ellipse(CenterCircX, CenterCircY-CircSpacing, CircSize, CircSize);
  ellipse(CenterCircX, CenterCircY+CircSpacing, CircSize, CircSize);
  ellipse(CenterCircX+CircSpacing, CenterCircY, CircSize, CircSize);
  ellipse(CenterCircX-CircSpacing, CenterCircY, CircSize, CircSize);
  ellipse(CenterCircX+CircSpacing, CenterCircY+CircSpacing, CircSize, CircSize);
  ellipse(CenterCircX-CircSpacing, CenterCircY-CircSpacing, CircSize, CircSize);
  ellipse(CenterCircX+CircSpacing, CenterCircY-CircSpacing, CircSize, CircSize);
  ellipse(CenterCircX-CircSpacing, CenterCircY+CircSpacing, CircSize, CircSize);
}

void ButtonPanel(int Button1Y) {
  int Button2Y = Button1Y-60;
  int Button3Y = Button2Y-60;
  int ButtonCont = Button1Y+60;
  fill(0);
  stroke(85);
  //bezel
  rect(ButtonX-20, Button1Y-140, 90, 270);
  
  //Faux Braille
  fill(100);
  //Braille 3 left
  ellipse(ButtonX-15, Button1Y-107, 5, 5);
  ellipse(ButtonX-15, Button1Y-97, 5, 5);
  ellipse(ButtonX-15, Button1Y-87, 5, 5);
  //Braille 2 left
  ellipse(ButtonX-15, Button1Y-43, 5, 5);
  ellipse(ButtonX-15, Button1Y-33, 5, 5);
  //Braille 1 left
  ellipse(ButtonX-15, Button1Y+25, 5, 5);
  
  ellipse(ButtonX+65, Button1Y-107, 5, 5);
  ellipse(ButtonX+65, Button1Y-97, 5, 5);
  ellipse(ButtonX+65, Button1Y-87, 5, 5);
  //Braille 2 left
  ellipse(ButtonX+65, Button1Y-43, 5, 5);
  ellipse(ButtonX+65, Button1Y-33, 5, 5);
  //Braille 1 left
  ellipse(ButtonX+65, Button1Y+25, 5, 5);
  
  
  
  fill(255);
  //screen
  rect(ButtonX-10, Button1Y-130, 70, 250);
  
  //3
  fill(0, 223, 185, 100);
  if(ThirdFloorButt) fill(0, 223, 255);
  rect(ButtonX, Button3Y, ButtonSize, ButtonSize, 5);
  //2
  fill(0, 223, 185, 100);
  if(SecFloorButt) fill(0, 223, 255);
  rect(ButtonX, Button2Y, ButtonSize, ButtonSize, 5);
  //1
  fill(0, 223, 185, 100);
  if(FirstFloorButt) fill(0, 223, 255);
  rect(ButtonX, Button1Y, ButtonSize, ButtonSize, 5);
  //911
  fill(0, 223, 185, 100);
  rect(ButtonX, ButtonCont, ButtonSize, ButtonSize, 5);
  
}

void ButtonNums() {
  int ButtonNumX = ButtonX+13; //988
  int ButtonNum1Y = Button1Y+40;
  fill(0);
  textSize(50);
  text("3", ButtonNumX, ButtonNum1Y-120);
  text("2", ButtonNumX, ButtonNum1Y-60);
  text("1", ButtonNumX, ButtonNum1Y);
  textSize(20);
  text("Door", ButtonNumX-8, Button1Y+83);
  textSize(15);
  text("Control", ButtonNumX-11, Button1Y+98);
}

void DoorControls() {
  int DoorContX = ButtonX;
  int DoorContOpenY = Button1Y+5;
  
  //Door Open Sign
  fill(0);
  stroke(255);
  rect(DoorContX+5, DoorContOpenY, 10, 40);
  rect(DoorContX+35, DoorContOpenY, 10, 40);
  noStroke();
  rect(DoorContX+20, DoorContOpenY+16, 12, 5);
  triangle(DoorContX+15, DoorContOpenY+19, DoorContX+20, DoorContOpenY+14, DoorContX+20, DoorContOpenY+24);
  triangle(DoorContX+37, DoorContOpenY+19, DoorContX+32, DoorContOpenY+14, DoorContX+32, DoorContOpenY+24);
  
  //Door Close Sign
  stroke(255);
  rect(DoorContX+15, DoorContOpenY-60, 10, 40);
  rect(DoorContX+25, DoorContOpenY-60, 10, 40);
  noStroke();
  triangle(DoorContX+37-22, DoorContOpenY-41, DoorContX+32-22, DoorContOpenY-46, DoorContX+32-22, DoorContOpenY-36);
  triangle(DoorContX+15+21, DoorContOpenY+19-60, DoorContX+20+21, DoorContOpenY+14-60, DoorContX+20+21, DoorContOpenY+24-60);
  rect(DoorContX+2, DoorContOpenY+16-60, 10, 5);
  rect(DoorContX+39, DoorContOpenY+16-60, 10, 5);
  
  //Call Sign
  rect(DoorContX+10, DoorContOpenY-110, 30, 8);
  rect(DoorContX+7, DoorContOpenY-110, 8, 12);
  rect(DoorContX+37, DoorContOpenY-110, 8, 12);
  rect(DoorContX+5, DoorContOpenY-100, 12, 8);
  rect(DoorContX+35, DoorContOpenY-100, 12, 8);
  
  //Back to floor Controls
  textSize(19);
  text("Floor", DoorContX+5, Button1Y+83);
  textSize(15);
  text("Control", DoorContX+2, Button1Y+98);
}

void HandicapButton() {
  fill(150);
  stroke(0);
  
  //outline
  if(handiPressed) fill(0,0,255);
  ellipse(1150, 500, 100, 100);
  
  //inner circle
  fill(0, 127, 197);
  ellipse(1150, 500, 90, 90);
  
  //wheel
  fill(255);
  stroke(0, 127, 197);
  ellipse(1140, 515, 45, 45);
  
  //wheel cutoff
  fill(0, 127, 197);
  ellipse(1140, 515, 30, 30);
  rect(1135, 490, 30, 30);
  
  //vertical line
  stroke(255);
  fill(255);
  rect(1137, 473, 7, 35);
  
  //head
  ellipse(1143, 473, 18, 18);
  
  //arm
  rect(1137, 490, 20, 5);
  
  //horizontal line
  rect(1137, 505, 30, 6);
  
  //vert leg
  rect(1163, 505, 6, 25);
  
  //foot
  rect(1163, 530, 10, 6);
  
  /*//leg
  translate(width/2, height/2);
  rotate(radians(45));
  rect(-1150, -505, 30, 6);    //rotating makes no sense in processing */
  
  
}

void update(int x, int y) {
  int Button2Y = Button1Y-60;
  int Button3Y = Button2Y-60;
  int ButtonCont = Button1Y+60;
  if (overCircle(1150, 500, 90) ) {
      circleOver = true;
      rectOver1 = false;
      rectOver2 = false;
      rectOver3 = false;
      rectOverCont = false;
    } 
    else if (overRect1(ButtonX, Button1Y, ButtonSize, ButtonSize)) {
      circleOver = false;
      rectOver1 = true;
      rectOver2 = false;
      rectOver3 = false;
      rectOverCont = false;
    }
    else if (overRect2(ButtonX, Button2Y, ButtonSize, ButtonSize)) {
      circleOver = false;
      rectOver1 = false;
      rectOver2 = true;
      rectOver3 = false;
      rectOverCont = false;
    }
    else if (overRect3(ButtonX, Button3Y, ButtonSize, ButtonSize)) {
      circleOver = false;
      rectOver1 = false;
      rectOver2 = false;
      rectOver3 = true;
      rectOverCont = false;
    }
    else if (overRectCont(ButtonX, ButtonCont, ButtonSize, ButtonSize)) {
      circleOver = false;
      rectOver1 = false;
      rectOver2 = false;
      rectOver3 = false;
      rectOverCont = true;
    }
    else {
    circleOver = rectOver1 = rectOver2 = rectOver3 = false;
  }
}

void ElevatorHandler(int curNum) {
  //FloorNum = curNum;
  //int currentFrame = frameCount;
  if(DoorOpen) DoorOpen = false;
    if(onFirstFloor && curNum != 1) {
      if(curNum == 2) {
        onFirstFloor = false;
        onSecondFloor = true;
        onThirdFloor = false;
        NewFloorNum = curNum;
      }
      if(curNum == 3) {
        onFirstFloor = false;
        onSecondFloor = false;
        onThirdFloor = true;
        NewFloorNum = curNum;
      }
    }
    if(onSecondFloor && curNum != 2) {
      if(curNum == 1) {
        onFirstFloor = true;
        onSecondFloor = false;
        onThirdFloor = false;
        NewFloorNum = curNum;
      }
      if(curNum == 3) {
        onFirstFloor = false;
        onSecondFloor = false;
        onThirdFloor = true;
        NewFloorNum = curNum;
      }
    }
    if(onThirdFloor && curNum != 3) {
      if(curNum == 2) {
        onFirstFloor = false;
        onSecondFloor = true;
        onThirdFloor = false;
        NewFloorNum = curNum;
      }
      if(curNum == 1) {
        onFirstFloor = true;
        onSecondFloor = false;
        onThirdFloor = false;
        NewFloorNum = curNum;
      }
    }
}

void FloorNumber(int curNum) {
  fill(0);
  stroke(0);
  rect(955, 50, 90, 50, 10);
  textSize(70);
  fill(255, 0, 0);
  if(curNum == 1) {
    text("1", 985, 98);
  }
  if(curNum == 2) {
    text("2", 985, 98);
  }
  if(curNum == 3) {
    text("3", 985, 98);
  }
  
}

void mousePressed() {
  if (circleOver) {
    ElectricHumFile.play();
    if(!handiPressed) handiPressed = true;
    else handiPressed = false;
  }
  if (rectOverCont) {
    if(!onDoorCont) onDoorCont = true;
    else onDoorCont = false;
  }
  if(!onDoorCont) {
    if (rectOver1) {
      if(!onFirstFloor) {
        ElevatorHandler(1);
        if(!FirstFloorButt) FirstFloorButt = true;
      }
    }
    if (rectOver2) {
      if(!onSecondFloor) {
        ElevatorHandler(2);
        if(!SecFloorButt) SecFloorButt = true;
      }
    }
    if (rectOver3) {
      if(!onThirdFloor) {
        ElevatorHandler(3);
        if(!ThirdFloorButt) ThirdFloorButt = true;
      }
    }
  }
  else { 
    if (rectOver1) {
      if(!DoorOpen) DoorOpen = true;
    }
    if (rectOver2) {
      if(DoorOpen) DoorOpen = false;
    }
    if (rectOver3) {
      //play a sound or something, cant really sim a call in this
    }
  }
}

boolean overRect3(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overRect2(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overRect1(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overRectCont(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
