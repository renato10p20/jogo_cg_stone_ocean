class Playerik{
  
  int x, y, w, h, f;
  
  Playerik(int _x, int _y, int _w, int _h, int _f){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    f = _f;
  }
  void mover(int frame){ 
    if(++f > frame) f = 0;
    if ((x+=5) > height) x = -w;
  }
    
} 
