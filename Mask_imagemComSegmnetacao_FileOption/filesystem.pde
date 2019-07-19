import java.awt.Rectangle;
import java.util.ArrayList;

import g4p_controls.*;

public void createFileSystemGUI(int x, int y, int w, int h, int border) {
  // Store picture frame
  rects.add(new Rectangle(x, y, w, h));
  // Set inner frame position
  x += border; 
  y += border;
  w -= 2*border; 
  h -= 2*border;
  GLabel title = new GLabel(this, x, y, w, 20);
  title.setText("Na pasta Output/nome do produto escolha o CSV desejado", GAlign.CENTER, GAlign.MIDDLE);
  title.setOpaque(true);
  title.setTextBold();
  // Create buttons
  int bgap = 20;
  int bw = round((w - 2 * bgap) / 3.0f);
  int bs = bgap + bw;
  btnFolder = new GButton(this, x+(w/2)-(bw/2), y+(h/2), bw, 40, "Importar CSV");
  btnInput = new GButton(this, x+bs, y+30, bw, 20, "Input");
  btnInput.setVisible(false);
  btnOutput = new GButton(this, x+2*bs, y+30, bw, 20, "Output");
  btnOutput.setVisible(false);
  lblFile = new GLabel(this, x, y+60, w, 60);
  lblFile.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  lblFile.setOpaque(true);
  lblFile.setLocalColorScheme(G4P.GREEN_SCHEME);
}

// Controls used for file dialog GUI 
GButton btnFolder, btnInput, btnOutput;
GLabel lblFile;

// Controls used for message dialog GUI 
GButton btnMdialog;
GOption[] optMmessType;
GToggleGroup opgMmessType;
GTextField txfMdTitle;
GTextArea txfSMMessage;
int md_mtype;

// Controls used for option dialog GUI 
GButton btnOdialog;
GOption[] optOmessType, optOoptType;
GToggleGroup opgOmessType, opgOoptType;
GTextField txfOdTitle;
GTextArea txfOdMessage;
GLabel lblReply;
int od_mtype, od_otype;

// Controls used for colour chooser dialog GUI 
GButton btnColor;
GView view;
PGraphics pg;
int sel_col = -1;

// Graphic frames used to group controls
ArrayList<Rectangle> rects ;
