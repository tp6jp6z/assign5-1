class Bar{
  float x;
  float y;
  float posX;
  
  float Length;
  float Size;

  void move(){
    x= mouseX;
    
    if(x+ Length/2>= width){
      x= width- Length/2-1;
    }
    
    if(x- Length/2<= 0){
      x= Length/2+ 1;
    }
  }
  
  void display(){
    stroke(255,255,0);
    fill(0);
    rectMode(CENTER);
    rect(x, y, Length, Size);
  }
  
  Bar(){
    x= mouseX;
    y= height- 6;
    
    Length= 120;
    Size= 10;
  }
}
