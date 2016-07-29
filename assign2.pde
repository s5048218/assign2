/*
author:s5048218@gmail.com
update:2016/07/29
*/
PImage bg1,bg2,treasure,hp,fighter,enemy,start1,start2,end1,end2;
int x,y,z; 
float a,b,c;
final int start=1;
final int run=2;
final int end=3;
boolean up;
boolean down;
boolean left;
boolean right;
int gameState;

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
  gameState = start;
}


  int bgX = 0;
  int bgY = -640;
  float enemyX = 0;
  float enemyY = 0;
  float trX = random(560);
  float trY = random(100,420);
  float upDown;
  float leftRight;
  int tmp = 1;
  int speed = 5;
  int blood = 50+18*tmp;

  
void draw(){
  switch(gameState){
    case start:
      leftRight = 0;
      upDown = 0;
      tmp = 1;
      blood = 50+18*tmp;
        image(start1,0,0);
        if(mouseX>200 && mouseX<450 && mouseY>380 && mouseY<420){
          image(start2,0,0);
          if(mousePressed){
            gameState = run;
          }
        }
    break;
    //game start
    case run:
      //background
      image(bg1,bgX++,0);
      image(bg2,bgY++,0);
      while(bgX>640){
        bgX = -640;
      }
      while(bgY>640){
        bgY = -640;
      }    
      //fighter's place
      if(right == true){
        leftRight += speed;
      }
      if(left == true){
        leftRight -= speed;
      }
      if(up == true){
        upDown -= speed;
      }
      if(down == true){
        upDown += speed;
      }
      float meX = 580+leftRight;
      float meY = 240+upDown;
      //fighter's place
      image(fighter,meX,meY);
      //background's extreme line
      if(meX < 10){
        leftRight = -570;
      } 
      if(meX > 600){
        leftRight = 20;
      }
      if(meY < 5){
        upDown = -235;
      }
      if(meY > 420){
        upDown = 180;
      }
      //enemy's place     
      image(enemy,enemyX,enemyY);
      enemyX += 2;
      if(enemyY > meY){
        enemyY -= 3;
      }
      if(enemyY < meY){
        enemyY += 3;
      }
      if(enemyX > 640){
        enemyX = 0;
        enemyY = random(20,420);
      }
      //treasure's place     
      image(treasure,trX,trY);
      //hp
      blood = 50+18*tmp;
      strokeWeight(20);
      stroke(255,54,54);
      line(50,40,blood,40);
      image(hp,30,30);
      //replace the treasure and add hp
      while(meX > trX-30 && meX < trX+30 && meY > trY-30 && meY < trY+30){
        trX = random(560);
        trY = random(240);
        tmp ++;
      }
      //hp
      if(blood >= 230){
        tmp = 10;
      }
      //decrease hp
      while(meX > enemyX-35 && meX < enemyX+35 && meY > enemyY-35 && meY < enemyY +35){
        enemyX = 0;
        enemyY = meY;
        tmp -= 2;
      }
      //gameover
      if(blood < 50){ 
        gameState = end;
      }
      break;
     
    case end:
    image(end1,0,0);
    if(mouseX>200 && mouseX<450 && mouseY>300 && mouseY<350){
        image(end2,0,0);
        if(mousePressed){
          gameState = start;
        }
    } 
    break;
  }
}
void keyPressed(){
   switch(keyCode){
    case LEFT:
      left = true;
    break;
    case RIGHT:
      right = true;
    break;
    case UP:
      up = true;  
    break;
    case DOWN:
      down = true;
    break;
  }
}
void keyReleased(){
  switch(keyCode){
    case LEFT:
     left = false;
    break;
    case RIGHT:
     right = false;
    break;
    case UP:
     up = false;     
    break;
    case DOWN:
     down = false;     
    break;
  }
}
