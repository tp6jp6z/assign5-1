class Brick{
  
  float brSize= 30;
  
  int brX;
  int brY;
  
  Brick(int x, int y){
    brX= x;
    brY= y;
  }
  
  void display(){
    stroke(255);
    fill(255,255,0);
    
    rectMode(CENTER);
    rect(brX, brY, brSize, brSize);
  }
}
