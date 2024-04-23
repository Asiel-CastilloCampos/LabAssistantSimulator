// Button class controls all buttons used
public class Button {
  // Ininitialize  global variables
  PFont pixelFont;
  public int x;
  public int y;
  int w;
  int h;
  color c;
  public String text;
  public boolean isActive;

  // Item constructor that sets the rectangle to chosen settings
  Button(int setX, int setY, int setW, int setH, color setC, String setText) {
    x = setX;
    y = setY;
    w = setW;
    h = setH;
    c = setC;
    text = setText;
  }

  // Will render item
  void render() {
    fill(c);
    rect(x, y, w, h, 10);
    if(isInButton()){
      fill(255,0,255);
    } else {
      fill(0);
    }
    pixelFont = createFont("PixelifySans-Bold.ttf",40);
    textFont(pixelFont);
    text(text, x, y);
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
}
