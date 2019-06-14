

PImage img, mimg;
PImage bimg;

PImage segm;

//int[] mmask;

PImage mmask;

//float thresh = 228.79167;

float thresh = 235;

int tamanho_dataset;//351

int qnt_bg = 13;

Table df_maskcnn, df_coreml; 

void settings() {
  //img = loadImage("prod_(0).png");
  size(360, 640);
}

void setup() {

  //bimg.resize(width, height);

  //mmask=new int[width*height];

  mmask = createImage(360, 640, RGB);

  df_maskcnn = loadTable("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/images/garrafa_2/coord_garrafa.csv","header");
  
  df_coreml = new Table();
  df_coreml.addColumn("filename");
  df_coreml.addColumn("id");
  df_coreml.addColumn("label");
  df_coreml.addColumn("xMin",Table.INT);
  df_coreml.addColumn("xMax",Table.INT);
  df_coreml.addColumn("yMin",Table.INT);
  df_coreml.addColumn("yMax",Table.INT);
  
  tamanho_dataset = df_maskcnn.getRowCount();
  
  for (TableRow row : df_maskcnn.rows()) {
    //for(int i = 0; i < tamanho_dataset;i++){ 
    int y_min = row.getInt("yMin");
    int x_min = row.getInt("xMin");
    int y_max = row.getInt("yMax");
    int x_max = row.getInt("xMax");
    int file =  row.getInt("id_foto");

    try {

      img = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/images/garrafa_2/garrafa2("+file+").png"); 

      segm = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/output/mask_("+file+").jpg");
      //segm = loadImage("mask_(0).jpg");

      segm.filter(THRESHOLD, 0.3);

      img.loadPixels();
      mmask.loadPixels();
      for (int i=0; i<width*height; i++) {
        int greenn=(img.pixels[i]>>8) & 0xff;    
        int redd=(img.pixels[i]>>16) & 0xff;
        int bluee=img.pixels[i] & 0xff;

        //thresh=map(mouseX,0,width,0,255);   

        float d=dist(redd, greenn, bluee, 0, 0, 255);
        //print(thresh);
        if (d<thresh)
          mmask.pixels[i]=color(0);
        else
          mmask.pixels[i]=color(255);
      }
      mmask.updatePixels();
      mimg=img.get();


      mmask.blend(segm, 0, 0, 360, 640, 0, 0, 360, 640, ADD);

      //SUAVIZAR BORDAS DO CROMA
      //mmask.filter(BLUR,3);

      mimg.mask(mmask);
       
      for (int j = 0; j < qnt_bg; j++) {
  
        bimg = loadImage("bg("+j+").jpg");

        image(bimg, 0, 0);
        image(mimg, 0, 0);
       
        String nome_imagem = "img("+file+")("+j+").png";
        
        save(nome_imagem);
        
        
        TableRow newRow = df_coreml.addRow();
        newRow.setString("filename", nome_imagem);
        newRow.setInt("id", 2);
        newRow.setString("label", "agua");
        newRow.setInt("xMin",x_min);
        newRow.setInt("xMax",x_max);
        newRow.setInt("yMin",y_min);
        newRow.setInt("yMax",y_max);
        println(nome_imagem);
      }
    } 
    catch (Exception e) {
      //e.printStackTrace();
      println("Error!" + file);
    }
  }
  saveTable(df_coreml, "new_agua.csv");
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
