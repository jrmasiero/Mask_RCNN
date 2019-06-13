
 
PImage img, mimg;
PImage bimg;
int[] mmask;
float thresh = 228.79167;

int tamanho_dataset;//351

Table df; 
 
void settings() {
  //img = loadImage("prod_(0).png");
  size(360,640);
  
}
 
void setup() {
  bimg=loadImage("bg.jpg");
  bimg.resize(width, height);
  mmask=new int[width*height];
  
  df = loadTable("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/images/coord_garrafa.csv", "csv");
  
  tamanho_dataset = df.getRowCount();
  
  for (TableRow row : df.rows()) {
  //for(int i = 0; i < tamanho_dataset;i++){ 
    int y_min = row.getInt(0);
    int x_min = row.getInt(1);
    int y_max = row.getInt(2);
    int x_max = row.getInt(3);
    int file =  row.getInt(4);
  try{
  
  img = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/images/prod_("+file+").png"); 
  
  img.loadPixels();
  for (int i=0; i<width*height; i++) {
    int greenn=(img.pixels[i]>>8) & 0xff;    
    int redd=(img.pixels[i]>>16) & 0xff;
    int bluee=img.pixels[i] & 0xff;
 
    //thresh=map(mouseX,0,width,0,255);   
    
    float d=dist(redd,greenn,bluee,0,0,250);
    //print(thresh);
    if(d<thresh)
      mmask[i]=0;
    else
      mmask[i]=255;
  }
  mimg=img.get();
 
  mimg.mask(mmask);
  image(bimg, 0, 0);
  image(mimg, 0, 0);
  
  save("img("+file+").png");
  
  } catch (Exception e) {
    //e.printStackTrace();
    println("Error!" + file);
  }
  }
  
  exit();
  
}
 
//void draw() {
 
  //img.loadPixels();
  //for (int i=0; i<width*height; i++) {
  //  int greenn=(img.pixels[i]>>8) & 0xff;    
  //  int redd=(img.pixels[i]>>16) & 0xff;
  //  int bluee=img.pixels[i] & 0xff;
 
  //  //thresh=map(mouseX,0,width,0,255);   
    
  //  float d=dist(redd,greenn,bluee,0,0,250);
  //  //print(thresh);
  //  if(d<thresh)
  //    mmask[i]=0;
  //  else
  //    mmask[i]=255;
  //}
  //mimg=img.get();
 
  //mimg.mask(mmask);
  //image(bimg, 0, 0);
  //image(mimg, 0, 0);
  
   
//}

//void mousePressed(){
 
// println(thresh);
  
//}
