/*
author:s5048218@gmail.com
update:2016/07/29
*/
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

PImage bg1, bg2, gameStart;
PImage enemy;
PImage fighter;
PImage hp;
PImage treasure;
PImage start1, start2;
PImage end1, end2;

int gameState;
int bg_1 = 0, bg2 = -641 ;
int enemy_x= 0, enemy_y;
int blood = 20, coefficient = 2, bloodWidth;
int treasure_x, treasure_y;
int fighter_x = 589, fighter_y = 214;

boolean upPressed = false, downPressed = false; 
boolean rightPressed = false, leftPressed = false; 

void setup () {
  size(640,480) ; 
  
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  gameState = GAME_START;
}

void draw() {
  switch(gameState){
    case GAME_START:
      enemy_y = floor(random(419));
      fighter_x = 588;
      treasure_x = floor(random(110, 600));
      treasure_y = floor(random(440));
      blood = 20;
      image(start2, 0, 0);
      if(mouseX >= 214 && mouseX <= 428 && 
         mouseY >= 380 && mouseY <= 410){
          image(start1, 0, 0);
          if(mousePressed)
            gameState = GAME_RUN;
      }
      break;
     
    case GAME_RUN:   
      //bg1
      bg_1 += 1;
      if(bg_1 == 641){
        bg_1 = -640;
      }
      image(bg1, bg_1, 0);
     
      //bg2
      bg_2 += 1 ;
      if(bg2 == 641){
        bg2 = -641;
      }
      image(bg2, bg_2, 0);
         
      //enemy
      enemy_x += 5;
      enemy_x %= 640;
      enemySpeed();
      image(enemy, enemy_x, enemy_y);
  
      //fighter
      fighterMove_x();
      fighterMove_y();
      fighterMax_x();
      fighterMax_y();
     
      //hitEnemy
      hitEnemy();
      image(fighter, fighter_x, fighter_y);
     
      //blood+treasure
      fill(255, 0, 0);
      getTreasure();
      calculateBlood();
      rect(10, 5, bloodWidth, 20 );
      image(treasure, treasure_x, treasure_y);
     
      //hp
      image(hp, 0 ,0);
      //game over
     
      if(blood <= 0)
        gameState = GAME_OVER;
      break;
     
    case GAME_OVER:
      image(end2, 0, 0);
      if(mouseX >= 215 && mouseX <= 430 && 
         mouseY >= 315 && mouseY <= 344){
          image(end1, 0, 0);
            if(mousePressed)
              gameState = GAME_START;
      }
      break;  
  }
}

void keyPressed(){
  if (key == CODED){
    switch( keyCode ){
    case UP:
      upPressed = true;
    break; 
    case DOWN:
      downPressed = true;
    break;
    case LEFT:
      leftPressed = true;
    break;
    case RIGHT:
      rightPressed = true;
    break;
    }
  }
}

void keyReleased(){
  if (key == CODED){
    switch( keyCode ){
      case UP:
        upPressed = false;
      break; 
      case DOWN:
       downPressed = false;
      break;
      case LEFT:
       leftPressed = false;
      break;
      case RIGHT:
       rightPressed = false;
      break;
    }
  }
}

int fighterMove_x(){
  if(rightPressed) 
    fighter_x += 6;
  if(leftPressed)
    fighter_x -= 6;
  
   return fighter_x;
}

int fighterMove_y(){
  if(upPressed)
    fighter_y -= 6;
  if(downPressed)
    fighter_y += 6;
    
  return fighter_y;
}

int fighterMax_x(){
  if(fighter_x >= 589)
    fighter_x = 589;
  if(fighter_x <= 0)
    fighter_x = 0;
  
  return fighter_x;
}

int fighterMax_y(){
  if(fighter_y >= 429)
    fighter_y = 429;
  if(fighter_y <= 0)
    fighter_y = 0;
  
  return fighter_y;
}

int calculateBlood(){
  bloodWidth = blood * coefficient;
  
  return bloodWidth;
}

int getTreasure(){
  if(fighter_x >= treasure_x - 40 &&
     fighter_x <= treasure_x + 40 &&
     fighter_y >= treasure_y - 40 &&
     fighter_y <= treasure_y + 40){
       blood += 10;
       treasure_x = floor(random(110,600));
       treasure_y = floor(random(440));
     }
    if(blood >= 100)
      blood = 100;
      
  return blood;
}

int enemySpeed(){
  enemy_y += (fighter_y - enemy_y)/20;
  
  return enemy_y;
}

int hitEnemy(){
  if(enemy_x >= fighter_x - 55 &&
     enemy_x <= fighter_x + 50 &&
     enemy_y >= fighter_y - 55 &&
     enemy_y <= fighter_y + 50 ){
      blood -= 20; 
      enemy_x = 0;
      enemy_y = floor(random(419));
    }
     
  return blood;
}
