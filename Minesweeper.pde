import de.bezier.guido.*;
public final static int NUM_ROWS = 16;
public final static int NUM_COLS = 16;
public final static int NUM_MINES = 40;
public int count = 0;
private MSButton[][] buttons;
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); 
void setup (){
    size(400, 400);
    background(255);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0;r<NUM_ROWS;r++){
      for(int c = 0; c <NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    setMines();
}
public void setMines(){
  while(mines.size() < NUM_MINES){
    int r = (int)(Math.random() * NUM_ROWS);
    int c = (int)(Math.random() * NUM_ROWS);
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
    }
  }
}
public void draw (){
    background( 100 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon(){
    if(count == mines.size()){
      return true;
    }
    return false;
}
public void displayLosingMessage(){
    buttons[1][4].setLabel("G");
    buttons[1][5].setLabel("A");
    buttons[1][6].setLabel("M");
    buttons[1][7].setLabel("E");
    buttons[1][9].setLabel("O");
    buttons[1][10].setLabel("V");
    buttons[1][11].setLabel("E");
    buttons[1][12].setLabel("R");
    buttons[1][13].setLabel("!");
}
public void displayWinningMessage(){
    buttons[1][5].setLabel("Y");
    buttons[1][6].setLabel("O");
    buttons[1][7].setLabel("U");
    buttons[1][9].setLabel("W");
    buttons[1][10].setLabel("I");
    buttons[1][11].setLabel("N");
    buttons[1][12].setLabel("!");
}
public boolean isValid(int r, int c){
    if(r <NUM_ROWS &&  c <NUM_COLS && r >=0 && c>=0){
    return true;
  }
  return false;
}
public int countMines(int row, int col){
    int numMines = 0;
   if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
    numMines++;
  if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;
    return numMines;
}
public class MSButton{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    public MSButton (int row, int col){
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        count = 0;
        Interactive.add( this );
    }
    public void mousePressed () {
        clicked = true;
        if(mouseButton == RIGHT){
          if(flagged == false){
            flagged = true;
            count++;
          }else if(flagged == true){
            flagged = false;
            clicked = false;
            count--;
          }
        }else if(mines.contains(this) && flagged == false){
         displayLosingMessage();
        }else if(countMines(myRow,myCol) > 0){
          setLabel(countMines(myRow,myCol));
        }else if(countMines(myRow, myCol) == 0){
        if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].clicked){
     buttons[myRow][myCol-1].mousePressed(); 
    }
    if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].clicked){
     buttons[myRow-1][myCol].mousePressed(); 
    }
    if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].clicked){
     buttons[myRow-1][myCol-1].mousePressed(); 
    }
    if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].clicked){
     buttons[myRow-1][myCol+1].mousePressed(); 
    }
    if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].clicked){
     buttons[myRow][myCol+1].mousePressed(); 
    }
    if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].clicked){
     buttons[myRow+1][myCol-1].mousePressed(); 
    }
    if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].clicked){
     buttons[myRow+1][myCol].mousePressed(); 
    }
    if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].clicked){
     buttons[myRow+1][myCol+1].mousePressed(); 
    }
        }
        if(isWon() == true){
         displayWinningMessage();
        }
    }
    public void draw () {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel){
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

