int leftPlayer = 110;
int rightPlayer = 110;
int playerHitBox = 120;

int ballDiameter = 10;
int ballX = 295;
int ballY = 195;

int leftPlayerPoints = 0;
int rightPlayerPoints = 0;

boolean ballDirY = false;
boolean ballDirX = false;

boolean[] keys;

PFont gameFont;

void setup() {
  frameRate(60);
  size(600, 400);
  background(0, 0, 0);
  gameFont = createFont("8bit16.ttf", 32);
  keys = new boolean[4];
  keys[0] = false;
  keys[1] = false;
  keys[2] = false;
  keys[3] = false;

  setupGame();
}

void keyPressed() {
  if (key == 'w' || key == 'w') {
    keys[0] = true;
  }
  if (key == 's' || key == 'S') {
    keys[1] = true;
  }
  if (keyCode == UP) {
    keys[2] = true;
  }
  if (keyCode == DOWN) {
    keys[3] = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'w') {
    keys[0] = false;
  }
  if (key == 's' || key == 'S') {
    keys[1] = false;
  }
  if (keyCode == UP) {
    keys[2] = false;
  }
  if (keyCode == DOWN) {
    keys[3] = false;
  }
}

void draw() {
  clear();

  setupGame();
}

/*
*
 * Sistema de juego
 *
 */
void setupGame() {
  controls();
  drawLeftPlayer(leftPlayer);
  drawRightPlayer(rightPlayer);
  drawMiddleLine();
  drawBall(ballX, ballY);
  drawPoints();
  pointSystem();
}

void setDefault() {
  ballX = 295;
  ballY = 195;
}

void controls() {
  int movement = 15;
  if (keyPressed) {
    if (keys[0] && leftPlayer >= 20) {
      leftPlayer -= movement;
    }
    if (keys[1] && leftPlayer <= 260) {
      leftPlayer += movement;
    }
    if (keys[2] && rightPlayer >= 20) {
      rightPlayer -= movement;
    }
    if (keys[3] && rightPlayer <= 260) {
      rightPlayer += movement;
    }
  }
}

void pointSystem() {
  if (willCollideRightPlayer() || willCollideLeftPlayer() || willNotCollideAnything()) {
    calcBallPhysics();
  } else {
    if (didLeftPlayerLose()) {
      rightPlayerPoints += 1;
      ballDirX = true;
    } else {
      leftPlayerPoints += 1;
      ballDirX = false;
    }

    setDefault();
  }
}

/*
*
 * Game Physics
 *
 */

void calcBallPhysics() {
  calcBallDirections();
  setBallPosition();
}

void setBallPosition() {
  if (ballDirX) {
    ballX += 10;
  } else {
    ballX -= 10;
  }

  if (ballDirY) {
    ballY += 10;
  } else {
    ballY -= 10;
  }
}

boolean willCollideRightPlayer() {
  int rightPlayerX = 585;
  int rightPlayerYMin = rightPlayer;
  int rightPlayerYMax = rightPlayer + playerHitBox;

  boolean collisionOnY = ballY >= rightPlayerYMin && ballY <= rightPlayerYMax;
  boolean collisionOnX = ballX >= rightPlayerX;

  return collisionOnX && collisionOnY;
}

boolean willCollideLeftPlayer() {
  int leftPlayerX = 5;
  int leftPlayerYMin = leftPlayer;
  int leftPlayerYMax = leftPlayer + 120;

  boolean collisionOnY = ballY >= leftPlayerYMin && ballY <= leftPlayerYMax;
  boolean collisionOnX = ballX <= leftPlayerX;

  return collisionOnX && collisionOnY;
}

boolean willNotCollideAnything() {
  return (ballX >= 5 && ballX <= 585);
}

boolean didLeftPlayerLose() {
  int leftPlayerX = 5;
  int leftPlayerYMin = leftPlayer;
  int leftPlayerYMax = leftPlayer + 120;

  boolean collisionOnY = ballY >= leftPlayerYMin && ballY <= leftPlayerYMax;
  boolean collisionOnX = ballX <= leftPlayerX;

  return collisionOnX && !collisionOnY;
}

void calcBallDirections() {
  if (willBallCollideY(ballY)) {
    ballDirY = !ballDirY;
  }
  if (willBallCollideX(ballX)) {
    ballDirX = !ballDirX;
  }
}

boolean willBallCollideY(int y) {
  int minY = 0;
  int maxY = 390;

  return (y >= maxY || y <= minY);
}

boolean willBallCollideX(int x) {
  int minX = 0;
  int maxX = 590;

  return (x >= maxX || x <= minX);
}

/*
*
*  Game sprites
*
*/

void drawMiddleLine() {
  int x = 300;
  int y1 = 0;
  int y2 = 10;
  stroke(255);
  for (int i = 0; i <= 400; i++) {
    if (i % 2 == 0) {
      line(x, y1, x, y2);
    }
    y1 += 10;
    y2 += 10;
  }
}

void drawLeftPlayer(int y) {
  int x = 5;
  int w = 10;
  int h = 120;
  int radius = 3;

  noStroke();
  fill(255);
  rect(x, y, w, h, radius);
}

void drawRightPlayer(int y) {
  int x = 585;
  int w = 10;
  int h = 120;
  int radius = 3;

  noStroke();
  fill(255);
  rect(x, y, w, h, radius);
}

void drawBall(int x, int y) {
  noStroke();
  fill(255);
  rect(x, y, ballDiameter, ballDiameter, 10);
}

void drawPoints(){
  textFont(gameFont);
  textSize(32);
  fill(60, 195, 47);
  text(leftPlayerPoints, 140, 50);
  text(rightPlayerPoints, 440, 50);
}
