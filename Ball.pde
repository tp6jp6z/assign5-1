class Ball{
  float x;
  float y;
  
  float size;
  
// GAME_RESET Ball Move -----------------
  void move1(){
    x= bar.x;
    y= bar.y- (bar.Size+ size)/2;
    }

// GAME_PLAYING Ball Move
  void move2(){
    x+= xSpeed;
    y+= ySpeed;
      
    if(x< size/2 || x> width- size/2){
      xSpeed*= -1;
    }
      
    if(y< size/2 || y> height- size/2){
      ySpeed*= -1;
    }
      
    float bottom= y+ size/2;
    
    // Positions of Bar
    float barl= bar.y- bar.Size/2;
    float barLeft= bar.x- bar.Length/2;
    float barRight= bar.x+ bar.Length/2;
    
    if(bottom>= barl && x>= barLeft && x<= barRight){
      ySpeed*= -1;
    }
  }
  
  void display(){
    noStroke();
    fill(255);
    ellipse(x, y, size, size);
  }
  
  Ball(float xSpeed,float ySpeed){
    size= 20;
  }
}

