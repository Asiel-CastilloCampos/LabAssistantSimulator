// Item class controls all the items, what their ID is, correlated bin, and their placement
// Items are treated as simple buttons
public class Item {
  // Ininitialize Item global variables
  public int x;
  public int y;
  int w;
  int h;
  color c;
  public int id;
  public String text;
  public boolean isActive;
  public boolean isPutAway = false;
  public int correctBin;
  PImage item;
  PImage itemSelected;

  // Item constructor that sets the ball to chosen settings
  Item(int setX, int setY, int setW, int setH, color setC, int setId, String setText, int cBin) {
    x = setX;
    y = setY;
    w = setW;
    h = setH;
    c = setC;
    id = setId;
    text = setText;
    correctBin = cBin;
    isActive = false;
    
    item = loadImage(itemNames[id] + ".png");
  }
  
  // Will set isPutAway boolean to true is it is called to be put away
  void putAway() {
    isPutAway = true;
    sendToNeverland();
  }
  
  // Will render item
  void render() {
    if (isPutAway) {
      println(id + "is put away");
    } else {
      PImage img = item;
      img.resize(0,130);
      image(img, x-1, y-7);
    }
  }
 
 // Will activate item when called
  void activate() {
    isActive = true;
  }

  // Will deactivate item when called
  void deactivate() {
    isActive = false;
  }
  
  // Will return its corrrelated Bin number
  public int receiveCorrectBin() {
    return correctBin;
  }

  // Checks to see if a button is pressed by seeing if the mouse is pressed and if it is between the button
  // Returns a boolean true if a button is indeed pressed and false otherwise
  boolean isPressed() {
    if (mousePressed && isInButton()) {
      return true;
    } else {
      return false;
    }
  }

  // Checks to see if the mouse cursor is in the button
  // Returns a boolean true if it is indeed inside a button and false othewise
  boolean isInButton() {
    // Sets the sides of the button
    int left = x - w/2;
    int right = x + w/2;
    int top = y - h/2;
    int bottom = y + h/2;

    // Checks if mouse position is between the sides using isBetween function
    // Using the mouseX/Y and left/right or top/bottom paramaters
    if (isBetween(mouseX, left, right) &&
      isBetween(mouseY, top, bottom)) {
      return true;
    } else {
      return false;
    }
  }

  // Checks to see if a given num(ber) is between a given min(imum) and max(imum)
  // Returns a boolean true is the number is between the min/max and false otherwise
  boolean isBetween(int num, int min, int max) {
    if (num > min && num < max) {
      return true;
    } else {
      return false;
    }
  }
    
  void sendToNeverland(){
    x = 100000;
    y = 100000;
  }
}
