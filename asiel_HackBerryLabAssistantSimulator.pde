// Import  libraries + font
import processing.sound.*;
import java.util.Random;
PFont pixelFont;

// Initilaize global variables

int state = 0;
int itemsPutAway = 0;

// Buttons used
Button startButton;
Button howToButton;
Button backButton;
Button homeButton;

// Images used
PImage background;
PImage startScreen;
PImage howToScreen;
PImage scoreboard;
PImage winScreen;
PImage loseScreen;

// Scoreboard variables
int scoreX = 95;
int scoreY = 630;
int scoreW = 100;
int scoreH = 80;
color scoreC = #E88FDE;

// Item variables
int xOfItem = 430;
int yOfItem = 640;
int gap = 200;
int itemsOnTable = 0;
int nextItem = 0;

// Array list / Arraus of bins, items on table, item names, item's correlating ID number, and bins names
PImage[] closedBins = new PImage[54];
PImage[] items = new PImage[4];
String[] itemNames = {"Unicorn", "Hot Glue", "Clear Tape", "Electrical Tape", "Duct Tape", "Flathead Screwdriver", "Phillips Screwdriver",
  "Computer Charger", "Arcade Button", "Hot Glue Gun", "3D Print", "Crayons", "Clay", "Hot Wire Cutter", "Scissors", "Ruler", "Pliers",
  "Marker", "Flashlight", "Servo", "Laser", "GoPro", "3V Batteries", "Arduino Uno", "X-Acto Knife", "Caliper", "USB A-Micro", "LCD Screen", "RFID Sensor", "ERROR"};
int[] itemToBinID = {50, 27, 9, 10, 11, 3, 4, 42, 16, 29, 36, 45, 47, 37, 12, 21, 14, 23, 31, 33, 52, 41, 43, 26, 13, 22, 25, 34, 54, 0};
public String[] binNames = {"glue", "zipTies", "rope", "flatHead", "phillips", "scrapper", "breadboards", "heatShrink", "jumperWires",
  "clearTape", "electricalTape", "ductTape", "scissors", "knives", "pliers", "neoPixels", "buttons", "arduinoLed", "highTempGlue", "highTempGun", "ziplocBags",
  "rulers", "calipers", "markers", "usbA", "usbMicro", "arduino", "hotGlue", "hotGlue", "hotGun", "soldering", "flashlights", "12V", "servos", "lcdScreen", "ledMatrices",
  "3dPrints", "hotWire", "3dPrints", "ieTracking", "barcode", "goPros", "charger", "batteries", "5VPower", "crayons", "scales",
  "clay", "watchRepair", "drones", "unicorn", "buttons", "lasers", "rfid", "ERROR"};
// eeps track of items used
ArrayList<Integer> itemsUsed;

// Sound
SoundFile select;
SoundFile deselect;
SoundFile correct;
SoundFile incorrect;
SoundFile backgroundMusic;

// ArrayList of bins/items
ArrayList<Bin> binList;
ArrayList<Item> itemList;

// Which item is currently active
int activeItem;

// The box in which items are taken out
Box itemBox;

// Delay for button
int buttonDelay = 500;

// Maximum number of items
int maxItems = itemNames.length - 1;

// Variables used to calculate points
long startTime = 0;
long endTime = 0;
int points = 0;
boolean showPoints = false;


// Setup will initialize the canvas, declare sound variables, initialize the box
// as well as the bin/item ArrayList, and create all the items and bins
void setup() {
  // Initialize canvas
  size(1000, 700);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  textSize(30);
  noStroke();

  // Load images
  background = loadImage("background.png");
  scoreboard = loadImage("scoreboard.png");
  startScreen = loadImage("startScreen.png");
  howToScreen = loadImage("howToScreen.png");
  loseScreen = loadImage("loseScreen.png");
  winScreen = loadImage("winScreen.png");

  // Fill the closedBin Array list with all the images of the bins(in their default closed position)
  for (int index = 0; index<closedBins.length-1; index++) {
    closedBins[index] = loadImage("binClosed_" + binNames[index] + ".png");
  }

  // Fill the items Array list with all the images of the items
  for (int index = 0; index<items.length-1; index++) {
    items[index] = loadImage(itemNames[index] + ".png");
  }

  // Sound
  select = new SoundFile(this, "select.wav");
  deselect = new SoundFile(this, "deselect.wav");
  correct = new SoundFile(this, "correct.wav");
  incorrect = new SoundFile(this, "incorrect.wav");
  backgroundMusic = new SoundFile(this, "ableSisters.mp3");
  // Box
  itemBox = new Box(880, 630, 200, 20, color(#986D11));
  // Bin/Item ArrayList
  binList = new ArrayList<Bin>();
  itemList = new ArrayList<Item>();
  // Items that have been used
  itemsUsed = new ArrayList<Integer>();

  // Buttons for homescreen
  startButton = new Button(820, 100, 280, 100, color(255), "START");
  howToButton = new Button(820, 250, 280, 100, color(255), "HOW TO PLAY");
  backButton = new Button(820, 450, 200, 100, color(255), "BACK");
  homeButton = new Button(width/2, 450, 280, 100, color(255), "BACK HOME");

  // Creates the Bins
  createBins();
}

// Depending on which state, it will display either the homescreen, insctructions, game itself, or the endGame
void draw() {
  switch(state) {
  case 0:
    startScreen();
    break;
  case 1:
    howToPlay();
    break;
  case 2:
    playGame();
    break;
  case 3:
    endGame();
    break;
  }

  // Ensures the background music is playing in a loop
  if (backgroundMusic.isPlaying() == false) {
    backgroundMusic.play();
  }
}

// When the program starts, it will direct players here at the homescreen
void startScreen() {
  // Set background
  startScreen.resize(width, height);
  image(startScreen, width/2, height/2);
  // Set buttons
  startButton.render();
  howToButton.render();

  // Set state to other place depending on which button is pressed
  if (startButton.isPressed()) {
    state = 2;
  }
  if (howToButton.isPressed()) {
    state = 1;
  }
}

// Displays the screen that expalins how to play the game to the player
void howToPlay() {
  // Set background
  howToScreen.resize(width, height);
  image(howToScreen, width/2, height/2);

  // Set buttons
  backButton.render();

  // Set state back to home if Back button is pressed.
  if (backButton.isPressed()) {
    state = 0;
  }
}

// Displays when all items have been put away
void endGame() {
  // Set screen
  winScreen.resize(width, height);
  loseScreen.resize(width, height);
  if (points >= 400) {
    image(winScreen, width/2, height/2);
  } else {
    image(loseScreen, width/2, height/2);
  }
  // Set font + text
  pixelFont = createFont("PixelifySans-Bold.ttf", 95);
  fill(0);
  textFont(pixelFont);
  text(points + " POINTS", width/2, 320);

  // Set button
  homeButton.render();

  // If home button is pressed, it will restart the game(send player to hoome screen)
  if (homeButton.isPressed()) {
    itemsPutAway = 0;
    points = 0;
    itemList.clear();
    state = 0;
  }
}

// Displays the actual game
void playGame() {
  // Set background
  image(background, width/2, height/2);
  // Renders the bins and items
  renderBinsAndItems();
  // Performs all actions necessary to see which item is currently active
  activateItemsWhenSelected();
  // Puts item in bin(if correct)
  itemInBin();
  // Renders box
  itemBox.render();
  // Renders names if hovered over
  showItemNames();
  // Draws score
  drawScore();

  // if box is pressed, it will create an item
  if (itemBox.isPressed()) {
    createItem();
    delay(buttonDelay);
  }
  // If there are 42 used items, it will end the game
  if (itemsPutAway == 42) {
    state = 3;
  }
}

// Shows items
void showItemNames() {
  for (Item aItem : itemList) {
    if (aItem.isActive) {
      textFont(pixelFont);
      fill(255, 0, 255);
      textSize(30);
      text(aItem.text, aItem.x, aItem.y-75);
    } else if (aItem.isInButton()) {
      textFont(pixelFont);
      fill(0);
      textSize(30);
      text(aItem.text, aItem.x, aItem.y-75);
    }
  }
}

// Starts timer
void startAction() {
  startTime = millis();
}

// ends timer
void endAction() {
  endTime = millis();
  // calculates the time elapsed
  long elapsedTime = endTime - startTime;
  // Calculate points based on time elapsed
  points += calculatePoints(elapsedTime);
}

// Calculate points based on time elapsed
int calculatePoints(long elapsedTime) {
  // Point system
  int maxPoints = 100;
  int maxTime = 4000;

  // calculates player score
  return maxPoints - (int)(elapsedTime / (maxTime / maxPoints));
}

// draws scoreboard
void drawScore() {
  image(scoreboard, scoreX, scoreY);
  pixelFont = createFont("PixelifySans-Bold.ttf", 32);
  textFont(pixelFont);
  scoreboard.resize(165, 150);
  if (showPoints) {
    fill(scoreC);
    textSize(50);
    text(points, scoreX, scoreY+2);
  }
}

// Creates the items and puts it in the correct orientation
void createItem() {
  // Will show points once the first item is added
  showPoints = true;
  int itemInitialX = 300;
  // will create 4 items
  if (itemsOnTable == 0) {
    for (int i = 0; i <= 3; i++) {
      if (nextItem != 30) {
        itemList.add(new Item(itemInitialX, yOfItem, 80, 80, color(255, 0, 0), nextItem, itemNames[nextItem], itemToBinID[nextItem]));
        nextItem++;
        itemsOnTable++;
        itemInitialX += 130;
        startAction();
      } else {
        state = 3;
      }
    }
    correct.rate(.7);
    correct.play();
  } else {
    deselect.play();
  }
}

// Calcuates which Item has not already been sued
int addItemNotAlreadyUsed() {
  boolean numFound = false;
  int numToBeUsed = 0;
  while (!numFound) {
    int ranNum = randomNum();
    if (!numHasBeenUsed(ranNum)) {
      numFound = true;
      numToBeUsed = ranNum;
      itemsUsed.add(numToBeUsed);
    }
  }
  return numToBeUsed;
}

// returns if an item id number has been used
boolean numHasBeenUsed(int ranNum) {
  return itemsUsed.contains(ranNum);
}

// returns a random number
int randomNum() {
  int num = int(random(itemNames.length - 1));
  return num;
}

// If a bin is selected and if the activeItem ID is correct, it will put away that Item
void itemInBin() {
  for (Bin aBin : binList) {
    if (aBin.isPressed()) {
      if (correctBin(aBin)) {
        correct.rate(1);
        correct.play();
        itemList.get(activeItem).putAway();
        itemsOnTable--;
        itemsPutAway++;
        endAction();
        startAction();
      } else {
        incorrect.play();
        points = 0;
      }
      delay(buttonDelay);
    }
  }
}

// Returns a boolean if the item's Bin ID is correct or not
boolean correctBin(Bin aBin) {
  if (itemList.size()>0) {
    if (itemList.get(activeItem).text == "Hot Glue") {
      if (aBin.returnID() == 27 || aBin.returnID() == 28) {
        return true;
      } else {
        return false;
      }
    }

    if (itemList.get(activeItem).text == "Arcade Button") {
      if (aBin.returnID() == 16 || aBin.returnID() == 51) {
        return true;
      } else {
        return false;
      }
    }

    if (itemList.get(activeItem).text == "3D Print") {
      if (aBin.returnID() == 36 || aBin.returnID() == 38) {
        return true;
      } else {
        return false;
      }
    }

    if (itemList.get(activeItem).text == "USB A-Micro") {
      if (aBin.returnID() == 25 || aBin.returnID() == 24) {
        return true;
      } else {
        return false;
      }
    }

    if (itemList.get(activeItem).receiveCorrectBin() == aBin.returnID()) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

/*
  LINES 423-467 WAS BUILT WITH THE ASSISTANCE OF OPENAI'S CHATGPT
 I was having lots of trouble trying to figure out how to make this function
 be able to activate an item when pushed, and deactivate it when pushed again;
 all while counting each click as the mouse being pressed instead of how long
 the mouse was being pressed(it would act as if it was pressing it multiple times).
 Full conversation can be viewed in link below:
 https://chat.openai.com/share/d963e0e8-bde5-428e-81f0-cb5df610beb3
 */

boolean actionPerformed = false; // Flag to track if an action was performed

void activateItemsWhenSelected() {
  if (mousePressed && !actionPerformed) { // Check if the mouse is currently pressed and no action has been performed yet
    boolean itemActivated = false; // Flag to track if any item is activated

    for (Item aItem : itemList) {
      if (aItem.isPressed()) {
        if (aItem.isActive) {
          deselect.play();
          aItem.deactivate();
          activeItem = itemList.size();
        } else {
          select.play();
          deactivateAll(); // Deactivate all other items

          aItem.activate();

          activeItem = aItem.id;
          itemActivated = true;
        }

        actionPerformed = true; // Set the flag to true after an action is performed
        break; // Exit loop after performing an action on the first pressed item
      }
    }

    // If no item was activated, deactivate all items
    if (!itemActivated) {
      deactivateAll();
    }
  }

  if (!mousePressed) {
    actionPerformed = false; // Reset the flag when the mouse is released
  }
}

void deactivateAll() {
  for (Item aItem : itemList) {
    if (aItem.isActive) {
      aItem.deactivate();
    }
  }
}

// Goes through all the Bins and Items in the ArrayList and renders them
void renderBinsAndItems() {
  for (Bin aBin : binList) {
    aBin.render();
  }
  for (Item aItem : itemList) {
    if (aItem.isPutAway) {
    } else {
      aItem.render();
    }
  }
}

// Will create the Bins and add them to the binList ArrayList
void createBins() {
  int binID = 0;

  // Go through the binName Array and input the names with the placement, name, ID, etc.
  for (int y = 1; y <= 6; y++) {
    for (int x = 1; x <= 9; x++) {
      binList.add(new Bin("x" + x, "y" + y, binID, binNames[binID]));
      binID++;
    }
  }
}

// If you press l, if will make it look like all the items were put away, sending you to the end screen
void keyPressed(){
  if(key == 'l'){
    itemsPutAway = 42;
  }
}
