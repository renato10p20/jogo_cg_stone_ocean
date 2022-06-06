class Player{
  PImage img_player;
  int player_py;
  int player_px;
  int speed;
  
  
  void set_player_img(PImage img){
    img_player = img;
  }
  
  void set_x(int x){
    player_px = x;
  }
  
   void set_y(int y){
    player_py = y;
  }
  
   void move_dir(){
     if(player_px < 550)
     player_px = player_px + speed;
   }
   
    void move_esq(){
     if(player_px > 0)
     player_px = player_px - speed;
   }
   
   void print_player(){
     image(img_player, player_px, player_py);
   }
}
