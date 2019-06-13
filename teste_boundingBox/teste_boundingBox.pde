/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */

PImage img;  // Declare variable "a" of type PImage

PImage boudingBox;

int tamanho_dataset;//351

Table df;

void settings(){
  
  
  //size(img.width, img.height);
  size(360,640);
  boudingBox = loadImage("square.png");
}

void setup() {
  
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
  imageMode(CORNER);
  image(img, 0, 0);
  imageMode(CORNERS);
  image(boudingBox,x_min,y_min,x_max,y_max);
  
  save("img("+file+").png");
  
  } catch (Exception e) {
    //e.printStackTrace();
    println("Error!" + file);
  }
  }
  
  exit();
  
}
