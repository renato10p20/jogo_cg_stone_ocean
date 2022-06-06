import ddf.minim.*;
Minim gerenciador; 
AudioPlayer efeito;
AudioPlayer efeitof;
AudioPlayer burnin;
//
PImage inicio;
PImage botao;
PImage personagem;
PImage fim;
PImage cred;
PImage end;
PImage fundo;
PImage fase1;
PImage fase2;
PImage fase3;
PImage tutorial;
PImage voltar;
PImage logo;
PImage[] img = new PImage[5];

ArrayList<coracao> life_count = new ArrayList<coracao>();

Playerik p0 = new Playerik(25, 10, 34, 37, 0);
Playerik p1 = new Playerik(100, 200, 38, 53, 0);
Playerik p2 = new Playerik(1000, 420, 32, 54, 0);
Playerik p3 = new Playerik(245, 180, 29, 26, 0);
Playerik p4 = new Playerik(255, 395, 29, 26, 0);
int px, pf;

//fimdostompsons

Player player = new Player();
ArrayList<meteoro> meteoros = new ArrayList<meteoro>();

int gameStart = -1; // -1(Tela de inicio), 0(Tela Game over), 1(Tela de jogo), 2(Tela WIN), -2(Tela de creditos), 3(Tela seleção de cenario e como jogar) 4(Tela historia)

boolean sp = true;

int tempo_meteoro = 400;

int speed = 10;

int life = 3, score = 0;

int speed_time = 11000;

int win_score = 1000;

int ang = 0;

int t_img_fim = 100;
//variaveis texto historia
int t_px = 95;
int t_py = 700;
int t_pd = 35;

void setup() {
  size(600, 700);

  img[0] = loadImage("0.png");
  img[1] = loadImage("1.png");
  img[2] = loadImage("2.png");
  img[3] = loadImage("3.png");
  img[4] = loadImage("4.png");

  coracao co1 = new coracao();
  coracao co2 = new coracao();
  coracao co3 = new coracao();

  life_count.add(co1);
  life_count.add(co2);
  life_count.add(co3);


  PImage img_player = loadImage("nav1.png");
  player.set_player_img(img_player);
  player.set_x(200);
  player.set_y(550);
  player.speed = speed;

  gerenciador = new Minim(this);
  efeito = gerenciador.loadFile("efeito.mp3");
  efeitof = gerenciador.loadFile("DMC.mp3");
  burnin = gerenciador.loadFile("Light.mp3");
  inicio = loadImage("espaco.jpg"); 
  botao = loadImage("botao.png");
  fundo = loadImage("Fundo1.jpg");
  fase1 = loadImage("fase1.jpg");
  fase2 = loadImage("fase2.jpg");
  fase3 = loadImage("fase3.jpg");
  tutorial = loadImage("tutorial.png");
  //logo = loadImage("logo.png");

}
void draw() {
  image(fundo,0,0);
  image(img[p0.f], p0.y, p0.x);
  p0.mover(3);
  image(img[p1.f], p1.y, p1.x);
  p1.mover(3);
  image(img[p2.f], p2.y, p2.x);
  p2.mover(3);
  image(img[p3.f], p3.y, p3.x);
  p3.mover(3);
  image(img[p4.f], p4.y, p4.x);
  p4.mover(3);

  //if(++pf > 0) pf = 0;
  //if((px +=5) > width) px = -5;
  p1.mover(4);




  //configurando o player  









  //executando enquanto o jogo roda
  if (gameStart == 1) {
    
    imageMode(CORNER);
    //aumentando a velocidade
    if ((millis() - speed_time) > 10000) {
      speed_time = millis();
      speed = speed +2;
      player.speed = player.speed+1;
    }  
    //criando meteoros
    if ((millis() - tempo_meteoro) > 300) {
      tempo_meteoro = millis();

      int r = int(random(0, 3));
      PImage img_meteoro = loadImage("meteoro1.png");

      if (r == 0) {
        img_meteoro = loadImage("meteoro1.png");
      }
      if (r == 1) {
        img_meteoro = loadImage("meteoro2.png");
      }
      if (r == 2) {
        img_meteoro = loadImage("meteoro3.png");
      }
      meteoro m = new meteoro();
      m.set_meteoro_img(img_meteoro);

      m.set_x(int(random(10, 580)));
      m.set_y(0);

      meteoros.add(m);

      if (life > 0) {
        score = score + 10;
      }
    }
    //imprime meteoros
    ang = ang + 3;
    int size_meteoros = meteoros.size();
    for (int i = 1; i < size_meteoros; i++) {
      meteoro met = meteoros.get(i);
      met.move_meteoro(speed);

      pushMatrix();
      translate(met.meteoro_px + (met.img_meteoro.width)/2, met.meteoro_py + (met.img_meteoro.height)/2);
      imageMode(CENTER);
      rotate(radians(ang));
      met.print_meteoro();
      popMatrix();
      imageMode(CORNER);


      int metx = met.meteoro_px + (met.img_meteoro.width)/2;
      int mety = met.meteoro_py + (met.img_meteoro.height)/2;

      if (metx >= player.player_px && metx < player.player_px + 39 && mety>= player.player_py && mety < player.player_py + 36) {
        if (met.show == true) {
          life = life - 1;
          met.show = false;
          efeito.rewind();
          efeito.play();

          int hit = 1;

          for (int n = life_count.size() - 1; n> -1; n--) {
            coracao life = life_count.get(n);
            if (life.active == true && hit == 1) {
              life.active = false;
              hit = 0;
            }
          }
        }
      }
    }

    if (keyPressed == true) {

      if (keyCode == 39) {
        player.img_player = loadImage("navD.png");
        player.move_dir();
      }
      if (keyCode == 37) {
        player.img_player = loadImage("navE.png");

        player.move_esq();
      }
    } else {
      player.img_player = loadImage("nav1.png");
    }

    player.print_player();


    textSize(20);


    for (int i = 0; i< life_count.size(); i++) {
      coracao life = life_count.get(i);
      life.print_coracao(30 + 30*i, 30);
    }
    textSize(25); 
    fill(255);
    text("SCORE: "+score, 420, 55);
  } 
  if (life <= 0) {
    gameStart = 0;
    //textSize(50);
    //text("Game Over", 150,400);
    fim = loadImage("fim.jpg");
    image(fim, 0, 0);
  }

  //verifica o score para definir o fim do jogo
  if (score == win_score) {
    tempo_meteoro = millis();
    gameStart = 2;
   
    win_score = 100;
  }

  if (gameStart == 2) {//seta tela de fim
    
    
    if (t_img_fim > 0) {
      end = loadImage("histfim.jpg");
      burnin.pause();
      t_img_fim--;
      print(t_img_fim);
    }else{
       
      end = loadImage("end.jpg");
      burnin.pause();
    }
    
    
    image(end, 0, 0);
  }


  if (gameStart == 0) {

    text(score, 280, 500);
  }
  if (gameStart == -1) {
    imageMode(CORNER);
    image(inicio, 0, 0); 
    image(botao, 190, 300); 
    cred = loadImage("cred.png");
    image(cred, 195, 400);
    logo = loadImage("logo.png");
    image(logo, 180, 100);

    imageMode(CORNER);
  }
  

  if (gameStart == -2) {
    
    PImage cred = loadImage("credito.jpg");
    image(cred, 0, 0);
    
    
    image(voltar, 150, 600);
  }

  if (gameStart == 3) {
    image(inicio, 0, 0);
    


    
    image(fase1, 50, 30);
    image(fase2, 70 + fase1.width, 30 );
    image(fase3, 390, 30 );
    image(tutorial, 90, 250);

  }



  if (gameStart == 4) {

    imageMode(CORNER);
    if((t_py) > 0) {
      background(0);
      fill(255, 255, 0);
      textSize(30);
      text("HISTÓRIA", t_px+140, t_py - 40);
      textSize(25);
      text("Você é  Johny, um piloto de naves", t_px, t_py + t_pd*1);
      text("que estava voltando de sua última", t_px, t_py + t_pd*2);
      text("missão  com  uma  tremenda fome,", t_px, t_py + t_pd*3);
      text("até que  no  meio do  caminho  foi", t_px, t_py + t_pd*4);
      text("pego por uma  chuva de asteroides,", t_px, t_py + t_pd*5);
      text("que ameaça  destruir sua nave!!!", t_px, t_py + t_pd*6);
      text("Seu objetivo é  passar pela chuva", t_px, t_py + t_pd*7);
      text("de  asteroides e  assim conseguir", t_px, t_py + t_pd*8);
      text("chegar no seu restaurante favorito", t_px, t_py + t_pd*9);
      text("e  degustar  uma  ótima  refeição.", t_px, t_py + t_pd*10);
     
    }else{
       gameStart = 1;
    }
     t_py--;
  }
}




void mousePressed() {
  if (gameStart == -1) {

    if (mouseX > 190 && mouseX < 190 + botao.width && mouseY > 300 && mouseY < 300 + botao.height) {//clique botão iniciar
      gameStart = 3;





      efeitof.rewind();
      efeitof.play();

      burnin.rewind();
      burnin.play();
    }

    if (mouseX > 195 && mouseX < 190 + cred.width && mouseY > 400 && mouseY < 400 + cred.height) {//clique botao credits
      gameStart = -2;
      voltar = loadImage("voltar.png");
    }
  }
  
    if (gameStart == 3) {

    if (mouseX > 50 && mouseX < 50 + fase1.width && mouseY > 30 && mouseY < 30 + fase1.height) {//clique botão iniciar
      gameStart = 4;
      PImage selFundo = loadImage("Fundo1.jpg");
      fundo = selFundo;
      efeitof.rewind();
      efeitof.play();
    }

    if (mouseX > (70 + fase1.width) && mouseX < (70 + fase1.width) + fase2.width && mouseY > 30 && mouseY < 30 + fase2.height) {//clique botão iniciar
      gameStart = 4;
      PImage selFundo = loadImage("Fundo2.jpg");
      fundo = selFundo;
      efeitof.rewind();
      efeitof.play();
    }
    
    if (mouseX > 390 && mouseX < 390 + fase3.width && mouseY > 30 && mouseY < 30 + fase3.height) {//clique botão iniciar
      gameStart = 4;
      PImage selFundo = loadImage("Fundo3.jpg");
      fundo = selFundo;
      efeitof.rewind();
      efeitof.play();
    }
  
  }
  
    if (gameStart == -2) {

    if (mouseX > 150 && mouseX < 150 + voltar.width && mouseY > 600 && mouseY < 600 + voltar.height) {//clique botao credits
      gameStart = -1;
    }
  }
}
