

PImage img, mimg;
PImage bimg;

PImage segm, segm2save;

//int[] mmask;

PImage mmask;

//float thresh = 228.79167;

float thresh = 235;

int tamanho_dataset;//351

int qnt_bg = 358;

//int qnt_bg = 3;

Table df_maskcnn, df_coreml; 

PrintWriter output, treino;

String csv_path = null;
String [] csv_infos;

String nome_produto;
String root_path;

void settings() {
  //img = loadImage("prod_(0).png");
  size(360, 640);
}

void setup() {

  //bimg.resize(width, height);

  //mmask=new int[width*height];
  
   rects = new ArrayList<Rectangle> ();
  createFileSystemGUI(0, 0, width, height, 6);  

  
}

void draw() {
  
  if(csv_path != null){
  
   mmask = createImage(360, 640, RGB);

  println(csv_path);
 //df_maskcnn = loadTable("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/output/garrafa_1/coord_garrafa_1.csv","header");
  df_maskcnn = loadTable(csv_path,"header");
  
  //println(df_maskcnn.getColumnTitles());
  
  df_coreml = new Table();
  df_coreml.addColumn("name");
  df_coreml.addColumn("id");
  df_coreml.addColumn("label");
  df_coreml.addColumn("xMin",Table.INT);
  df_coreml.addColumn("xMax",Table.INT);
  df_coreml.addColumn("yMin",Table.INT);
  df_coreml.addColumn("yMax",Table.INT);
  
  
 
  
  tamanho_dataset = df_maskcnn.getRowCount();
  
   int linha = 0;
  
  for (TableRow row : df_maskcnn.rows()) {
    //for(int i = 0; i < tamanho_dataset;i++){ 
    
      
      
    int y_min = row.getInt("Ymin");
    int x_min = row.getInt("Xmin");
    int y_max = row.getInt("Ymax");
    int x_max = row.getInt("Xmax");
    int id = row.getInt("id");
    String file_name =  row.getString("name");
    String mask_name =  row.getString("mask");
    
    //print(row);
     root_path = "/home/dblab/projects/Mask_RCNN_v3_dataAug/";
    try {
      img = loadImage(root_path + file_name); 
      segm = loadImage(root_path + mask_name); 
     // img = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/images/garrafa_1/prod_("+file+").png"); 

      //segm = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/output/garrafa_01/mask_("+file+").jpg");
      //segm2save = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/output/garrafa_01/mask_("+file+").jpg");
      
     // segm = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/output/garrafa_2/mask_("+file+").jpg");
      //segm2save = loadImage("C:/Users/joser/Documents/PROJETOS_DS_DBLab/Mask_RCNN/output/garrafa_2/mask_("+file+").jpg");
      
      //segm = loadImage("mask_(0).jpg");
      
      //segm.filter(THRESHOLD, 0.3);

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
  
        bimg = loadImage("bgd("+j+").jpg");

        image(bimg, 0, 0,width,height);
        image(mimg, 0, 0);
       
        String nome_imagem = nome_produto + '(' + linha + ')' + '(' + j + ')' + ".png";

        
        save(nome_imagem);

        
        TableRow newRow = df_coreml.addRow();
        newRow.setString("name", nome_imagem);
        newRow.setInt("id", 1);
        newRow.setString("label", nome_produto);
        newRow.setInt("xMin",x_min);
        newRow.setInt("xMax",x_max);
        newRow.setInt("yMin",y_min);
        newRow.setInt("yMax",y_max);
        
        //println(nome_imagem);
        
        
        
      }
      //TROCA LINHA
      linha++;
      
    } 
    catch (Exception e) {
      //e.printStackTrace();
      //println("Error!" + file);
    }
  }
  saveTable(df_coreml, nome_produto+".csv");
  //output.flush();  // Writes the remaining data to the file
  //output.close();
  
  //treino.flush();  // Writes the remaining data to the file
  //treino.close();
  
  exit(); 
  
  }
  
}  



public void handleButtonEvents(GButton button, GEvent event) { 
  // Folder selection
  if (button == btnFolder){
    handleFileDialog(button);
  }

}

// G4P code for folder and file dialogs
public void handleFileDialog(GButton button) {
  String fname;
  // Folder selection
  if (button == btnFolder) {
    fname = G4P.selectInput("Input Dialog", "Coordenadas");
    lblFile.setText(fname);
    
    csv_path = fname;
    csv_infos = split(fname, '\\');
    
    for (int i = 0; i < csv_infos.length; i++) {
      if (csv_infos[i].equals("output") == true) {
        
        nome_produto = csv_infos[i+1]; 
        String [] csv_infos_short = subset(csv_infos, 0, i);
        root_path = join(csv_infos_short, '\\') + '\\';
        
       
        
        println(root_path);
        println(nome_produto);
       
      } 
    
    }
    
  }
  
}

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
