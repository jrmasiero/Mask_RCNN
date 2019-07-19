
int x_a_min = 400;
int x_a_max = 500;

int y_a_min = 50;
int y_a_max = 200;

PGraphics retangulo;

void setup(){
  
  
 size(800,600,P3D);

retangulo = createGraphics(100,100);

retangulo.beginDraw();
retangulo.fill(200);
retangulo.rect(0,0,100,100);
retangulo.endDraw();


//translate(15, 20);

pushMatrix();

PVector pos_i_x_y_min = new PVector(modelX(x_a_min, x_a_min, 0), modelY(y_a_min, y_a_min, 0));
PVector pos_i_x_y_max = new PVector(modelX(x_a_max, x_a_max, 0), modelY(y_a_max, y_a_max, 0));
rotate(radians(15));


PVector pos_f_x_y_min = new PVector(modelX(x_a_min, x_a_min, 0), modelY(y_a_min, y_a_min, 0));
PVector pos_f_x_y_max = new PVector(modelX(x_a_max, x_a_max, 0), modelY(y_a_max, y_a_max, 0));



//rect(50,50,50,100);
popMatrix();
//println("2D Position Inicial: " + pos_i);
//println("2D Position Final: " + pos_f);

  
//  println(pos_i.x+"  i "+pos_i.y);
//  println(pos_f.x+"  f "+pos_f.y);  
  
  //fill(255,0,0); 
image(retangulo,pos_i_x_y_min.x,pos_i_x_y_min.y, pos_i_x_y_max.x,pos_i_x_y_max.y); 

image(retangulo,pos_f_x_y_min.x,pos_f_x_y_min.y, pos_f_x_y_max.x,pos_f_x_y_max.y); 

//fill(0,255,0);
//rect(109,409,50,100);
//rect(pos_f.x,pos_f.y, 50,100);
}

void draw(){
 
  
  
}

void mousePressed(){
 
  println("PosX: "+mouseX+" PosY: "+mouseY);
}
