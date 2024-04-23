// Bin class controls all the bins, what their ID is, and their placement
// Bins are treated as simple buttons
public class Bin {
  // Initialize Bin global variables
  int x;
  int y;
  int id;
  String name;
  PImage closed;
  PImage open;
  int w = 85;
  int h = 50;
  // positions of bins
  int y1 = 76;
  int y2 = 165;
  int y3 = 255;
  int y4 = 344;
  int y5 = 433;
  int y6 = 523;
  int x1 = 87;
  int x2 = 182;
  int x3 = 277;
  int x4 = 406;
  int x5 = 501;
  int x6 = 596;
  int x7 = 724;
  int x8 = 819;
  int x9 = 914;

  // Bin constructor that sets the bin to chosen settings
  Bin(String setX, String setY, int ID, String setName) {
    if (setX.equals("x1")) {
      x = x1;
    }
    if (setX.equals("x2")) {
      x = x2;
    }
    if (setX.equals("x3")) {
      x = x3;
    }
    if (setX.equals("x4")) {
      x = x4;
    }
    if (setX.equals("x5")) {
      x = x5;
    }
    if (setX.equals("x6")) {
      x = x6;
    }
    if (setX.equals("x7")) {
      x = x7;
    }
    if (setX.equals("x8")) {
      x = x8;
    }
    if (setX.equals("x9")) {
      x = x9;
    }

    if (setY.equals("y1")) {
      y = y1;
    }
    if (setY.equals("y2")) {
      y = y2;
    }
    if (setY.equals("y3")) {
      y = y3;
    }
    if (setY.equals("y4")) {
      y = y4;
    }
    if (setY.equals("y5")) {
      y = y5;
    }
    if (setY.equals("y6")) {
      y = y6;
    }
    id = ID;
    name = setName;
    closed = loadImage("binClosed_" + binNames[id] + ".png");
    open = loadImage("binOpened_" + binNames[id] + ".png");

  }

  // Render bins
  void render() {
    if (isInButton()) {
      PImage img = open;
      image(img, x-1, y-7);
    } else {
      PImage img = closed;
      image(img, x, y);
    }
  }

  // Will return the ID of the bin
  public int returnID() {
    return id;
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
  // Returns a boolean true if it is indeed inside a button and false otherwise
  boolean isInButton() {
    // Sets the sides of the button
    int left = x - w/2;
    int right = x + w/2;
    int top = y - h/2;
    int bottom = y + h/2;
    // Checks if mouse position is between the sides using isBetween function
    // Using the mouseX/Y and left/right or top/bottom parameters
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
