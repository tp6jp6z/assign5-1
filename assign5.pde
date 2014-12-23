Bar bar;
Ball ball;
Brick [] brList;

final int GAME_START   = 0;
final int GAME_RESET   = 1;
final int GAME_PLAYING = 2;
final int GAME_PAUSE   = 3;
final int GAME_WIN     = 4;
final int GAME_LOSE    = 5;
int status;

float xSpeed; // Speed of Ball 
float ySpeed; // Speed of Ball

int life= 3;
int brickTotalNum= 50;
int brickHitNum;

void setup(){
  size(640,480);
  background(0);
  rectMode(CENTER);
  
  status= GAME_START;
  
  bar= new Bar();
  ball= new Ball(xSpeed,ySpeed);
  
  brList= new Brick[50];
  
  reset2();
}

void draw(){
  noStroke();
  
  switch(status){
    case GAME_START:
      printText();
      break;
      
    case GAME_RESET:
      background(0);
      bar.display();
      bar.move();
      
      ball.display();
      ball.move1();
      
      drawBrick();
      
      drawLife();
      checkWinLose();
      reset1();
      break;
      
    case GAME_PLAYING:
      background(0);
      
      bar.display();
      bar.move();
      
      ball.display();
      ball.move2();
      
      drawBrick();
      
      drawLife();
      brickHit();
      break;
      
    case GAME_WIN:
      printText();
      break;
      
    case GAME_LOSE:
      printText();
      break;
  }
  
  if(ball.y+ ball.size/2>= height){
    life--;
    status = GAME_RESET;
  }
}

// Bricks----------------
void brickMaker(){
  int brickInRow= 10;
  
  for(int i= 0; i< brickTotalNum; i++){
    int row= int(i/ brickInRow);
    int col= int(i% brickInRow);
    
    int x= 140+ col*40;
    int y= 50+ row*40;
    
    brList[i]= new Brick(x,y);
  }
}

void drawBrick(){
  for(int i= 0; i< brList.length; i++){
    Brick bricks= brList[i];
 
    bricks.display();
  }
} 

void brickHit(){
  for(int i= 0; i<brList.length; i++){
    Brick bricks= brList[i];
    
    // Positions of Ball
    float ballRight= ball.x+ ball.size/2;
    float ballLeft= ball.x- ball.size/2;
    float ballBottom= ball.y+ ball.size/2;
    float ballTop= ball.y- ball.size/2;
    
    // Positions of Brick
    float brRight= brList[i].brX+ brList[i].brSize/2;
    float brLeft= brList[i].brX- brList[i].brSize/2;
    float brBottom= brList[i].brY+ brList[i].brSize/2;
    float brTop= brList[i].brY- brList[i].brSize/2;
    
    // Hit Right 
    if((ballRight <= brRight) && (ballRight>= brLeft) &&
       (ball.y<= brBottom) && (ball.y>= brTop)){
      removeBrick(brList[i]);
      brickHitNum++;
      xSpeed*= -1;
      checkWinLose();
      
      if(xSpeed< 1 && xSpeed> -1){
        ySpeed*= -1;
      }
    }

    // Hit Left 
    if((ballLeft <= brRight) && (ballLeft>= brLeft) &&
       (ball.y<= brBottom) && (ball.y>= brTop)){
      removeBrick(brList[i]);
      brickHitNum++;
      xSpeed*= -1;
      checkWinLose();
      
      if(xSpeed< 1 && xSpeed> -1){
        ySpeed*= -1;
      }
    }
    
    // Hit Bottom  
    if((ball.x<= brRight) && (ball.x>= brLeft) &&
       (ballBottom<= brBottom) && (ballBottom>= brTop)){
      removeBrick(brList[i]);
      brickHitNum++;
      ySpeed*= -1;
      checkWinLose();
      
    }
    
    // Hit Top  
    if((ball.x<= brRight) && (ball.x>= brLeft) &&
       (ballTop<= brBottom) && (ballTop>= brTop)){
      removeBrick(brList[i]);
      brickHitNum++;
      ySpeed*= -1;
      checkWinLose();
    }
  }
}

void removeBrick(Brick obj){
  obj.brX= 1000;
  obj.brY= 1000;
}
    

// Life-------------------------

void drawLife(){
  fill(255);
  textSize(25);
  text("LIFE:", 36, 460);
  
  for(int lifeNum= 0; lifeNum< life; lifeNum++){
    int x= 78+ lifeNum* 25;
    ellipse(x, 453, 15, 15);
  }
}


// Check Win or Lose------------
void checkWinLose(){
  if(brickHitNum== brickTotalNum){
    status= GAME_WIN;
  }
  
  if(life== 0){
    status= GAME_LOSE;
    }
}


//Reset---------------------
void reset1(){
  xSpeed= random(-5,5);
  ySpeed= -6;
}

void reset2(){
  for (int i=0; i<brList.length; i++) {
    brList[i] = null;
  }
  brickMaker();
  
  life= 3;
  brickHitNum= 0;
}


// Print Text-----------------------
void printText(){
  textAlign(CENTER);
  background(255);
  fill(0);
  
  if(status== GAME_START){
    String title= "PONG GAME";
    String subtitle= "Press ENTER to Start";
    textSize(60);
    text(title, width/2, 240);
    textSize(20);
    text(subtitle, width/2, 280);
  }
  
  if(status== GAME_WIN){
    String title= "WINNER";
    String subtitle= "Press ENTER Back to Start";
    textSize(60);
    text(title, width/2, 240);
    textSize(20);
    text(subtitle, width/2, 280);
    
  }
  
  if(status== GAME_LOSE){
    String title= "You are Dead!!";
    String subtitle= "Press ENTER Back to Start";
    textSize(60);
    text(title, width/2, 240);
    textSize(20);
    text(subtitle, width/2, 280);
  }
}


// Status Control---------------------
void keyPressed() {
  statusCtrl();
}

void mousePressed(){
  if (mouseButton == LEFT) {
    if(status== GAME_RESET){
      status = GAME_PLAYING;
    }
  }
}

void statusCtrl(){
  if (key == ENTER) {
    switch(status) {

    case GAME_START:
      status = GAME_RESET;
      break;

    case GAME_LOSE:
      status= GAME_START;
      reset2();
      break;
      
    case GAME_WIN:
      status= GAME_START;
      reset2();
      break;
    }
  }
  
}

