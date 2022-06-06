class meteoro{
   PImage img_meteoro;
   int meteoro_py;
   int meteoro_px;
   boolean show = true;
   
    void set_meteoro_img(PImage img){
    img_meteoro = img;
  }
  
  void set_x(int x){
    meteoro_px = x;
  }
  
   void set_y(int y){
    meteoro_py = y;
  }
  
  void move_meteoro(int speed){
    meteoro_py = meteoro_py + speed;
  }
  
  void print_meteoro(){
    if(show == true){

     image(img_meteoro, 0, 0);

    }
    
  }
  

 }
