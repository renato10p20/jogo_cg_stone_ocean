class coracao{
  PImage img_coracao;
  boolean active = true;
  
  void print_coracao(int x ,int y){
    if(active == true){
      img_coracao = loadImage("coracao.png");
    }else{
      img_coracao = loadImage("ecoracao.png");
    }
    image(img_coracao, x, y);
  }
}
