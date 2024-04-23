// Box class controls when the items are placed
public class Box {
  // Initialize global variables
  int x;
  int y;
  int w;
  int h;
  color c;
  PImage box;
  PImage boxSelected;
  
  // Box constructor that sets the box to chosen settings
  Box(int setX, int setY, int setW, int setH, color setC) {
    x = setX;
    y = setY;
    w = setW;
    h = setH;
    c = setC;
    
    box = loadImage("box.png");
    boxSelected = loadImage("boxSelected.png");
  }
  
  // Renders box
  public void render() {
    if(isInButton()){
      PImage img = boxSelected;
      image(img, x, y-26);
    } else {
      PImage img = box;
      image(img, x, y);
    }
  }

  // Checks to see if a button is pressed by seeing if the mouse is pressed and if it is between the button
  // Returns a boolean true if a button is indeed pressed and false otherwise
  public boolean isPressed() {
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
    int top = y - w/2;
    int bottom = y + w/2;
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
}
