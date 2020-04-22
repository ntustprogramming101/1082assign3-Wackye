

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;
final int ONE_BLOCK = 80;
final int GROUNDHOG_W = 80;
final int GROUNDHOG_H = 80;

int actionFrame; //groundhog's moving frame 
int x, y;//size CENTER

int floor = 0;

float lastTime; 
float groundhogLestX, groundhogLestY;

float groundhogX = 360;
float groundhogY = 120;

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage title, gameover;
PImage startNormal, startHovered;
PImage restartNormal, restartHovered;
PImage bg, soil8x24, lifeImg;

PImage stone1, stone2;

PImage groundhogImg;
PImage groundhogDownImg;
PImage groundhogLeftImg;
PImage groundhogRightImg;

// For debug function
int playerHealth = 2;
float cameraOffsetY = 0;
boolean debugMode = false;
boolean moveMode = false;


void setup() {
  size(640, 480, P2D);
  x = 320;
  y = 240;
  
  // loadImage
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil8x24 = loadImage("img/soil8x24.png");
  groundhogImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  lifeImg = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    
    /* ------ End of Debug Function ------ */
    if (moveMode || gameState == GAME_OVER) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    
  switch (gameState) {

    case GAME_START: // Start Screen
    image(title, 0, 0);

    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;

    case GAME_RUN: // In_Game
     imageMode(CENTER);
     image(bg,x,y);
  
     // sun
     fill(253,184,19);
     stroke(255,255,0);
     strokeWeight(5);
     ellipse(x+270,y-190,120,120);
  
     // grass
     fill(124,204,05);
     noStroke();
     rectMode(CENTER);
     rect(x,y-80,640,30);
     
    // soil
    image(soil8x24, x, y+880);
    
    for(int i = 0; i < 24; i++){
      if(i < 8){
        for(int j = 40; j <= width; j+= 80){
          image(stone1, j, j + 160);
        }
      }
      if(i > 8 && i <= 16){
        for(int j = 40; j <= width; j+= 80){
          for(int k = (i + 2) * ONE_BLOCK - 40; k <= 18 * ONE_BLOCK - 40; k += 80){
            if(j / 80 % 4 == 1 || j / 80 % 4 == 2){
              if(k / 80 % 4 == 1 || k / 80 % 4 == 2){
                print("hey");
                image(stone1, j, k);
              }
            }
            if(j / 80 % 4 == 0 || j / 80 % 4 == 3){
              if(k / 80 % 4 == 0 || k / 80 % 4 == 3){
                image(stone1, j, k);
              }
            }            
          }
        }
      }
      if(i >16 && i <= 24){
        for(int j = 40; j <= width; j+= 80){
          for(int k = (i + 2) * ONE_BLOCK - 40; k <= 26 * ONE_BLOCK - 40; k += 80){
            
              if(k / 80 % 3 == 0){
                if(j / 80 % 3 == 1 || j / 80 % 3 == 2){
                image(stone1, j, k);
                if(j / 80 % 3 == 2){
                  image(stone2, j, k);
                }
              }
            }
              if(k / 80 % 3 == 1){
                if(j / 80 % 3 == 0 || j / 80 % 3 == 1){
                image(stone1, j, k);
                if(j / 80 % 3 == 1){
                  image(stone2, j, k);
                }
              }
            }
              if(k / 80 % 3 == 2){
                if(j / 80 % 3 == 0 || j / 80 % 3 == 2){
                image(stone1, j, k);
                if(j / 80 % 3 == 0){
                  image(stone2, j, k);
                }                
              }
            }            
          }
        }
      }      
    }

    // Player
    // groundhog
    if(playerHealth == 0){
      gameState = 2;
    }
    
     if(groundhogX < 0 + 40){
       groundhogX = 40;
     }
     
     if(groundhogX > width - 40){
       groundhogX = width - 40;
     }
     
     if(groundhogY < 120){
       groundhogY = 120;
     }
     
     if (downPressed == false && leftPressed == false && rightPressed == false) {
      image(groundhogImg, groundhogX, groundhogY, GROUNDHOG_W, GROUNDHOG_H);
    }
    
    // draw the groundhogDown image between 1-14 frames
    if (downPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogY += ONE_BLOCK / 15.0;
        image(groundhogDownImg, groundhogX, groundhogY, GROUNDHOG_W, GROUNDHOG_H);
      } else {
        groundhogY = groundhogLestY + ONE_BLOCK;
        downPressed = false;
      }
    }
    
    //draw the groundhogLeft image between 1-14 frames
    if (leftPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogX -= ONE_BLOCK / 15.0;
        image(groundhogLeftImg, groundhogX, groundhogY, GROUNDHOG_W, GROUNDHOG_H);
      } else {
        groundhogX = groundhogLestX - ONE_BLOCK;
        leftPressed = false;
      }
    }
    
    //draw the groundhogRight image between 1-14 frames
    if (rightPressed) {
      actionFrame++;
      if (actionFrame > 0 && actionFrame < 15) {
        groundhogX += ONE_BLOCK / 15.0;
        image(groundhogRightImg, groundhogX, groundhogY, GROUNDHOG_W, GROUNDHOG_H);
      } else {
        groundhogX = groundhogLestX + ONE_BLOCK;
        rightPressed = false;
      }
    }
    
    if (moveMode) {
        popMatrix();
    }

    // Health UI
     for(int i = 0; i < playerHealth; i++){
     image(lifeImg,40 + 70*i ,35);
     }

    break;

    case GAME_OVER: // Gameover Screen
    cameraOffsetY += ONE_BLOCK * floor;
    floor = 0;
    if(gameState == GAME_OVER){
      popMatrix();
    }
    
    imageMode(CORNER);
    image(gameover, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
        groundhogX = 360;
        groundhogY = 120;
        playerHealth = 2;
        groundhogLestX = 0; 
        groundhogLestY = 0;
        downPressed = false; 
        leftPressed = false;
        rightPressed = false;
        floor = 0;
        
      }
    }else{

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;
    
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
  // Add your moving input code here
float newTime = millis(); //time when the groundhog started moving
  if (key == CODED) {
    switch (keyCode) {
    case DOWN:
    if(floor < 24){
      if (newTime - lastTime > 250) {
        downPressed = true;
        actionFrame = 0;
        groundhogLestY = groundhogY;
        lastTime = newTime;
        floor++;
        //println(floor);
        if(floor < 21){
          moveMode = true;
          cameraOffsetY -= ONE_BLOCK;
        }
      }
    }
      break;
    case LEFT:
      if (newTime - lastTime > 250) {
        leftPressed = true;
        actionFrame = 0;
        groundhogLestX = groundhogX;
        lastTime = newTime;
      }
      break;
    case RIGHT:
      if (newTime - lastTime > 250) {
        rightPressed = true;
        actionFrame = 0;
        groundhogLestX = groundhogX;
        lastTime = newTime;
      }
      break;
    }
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){

      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
}
