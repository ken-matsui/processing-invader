// KenMatsui

float x;
float y;

boolean shot = false;
boolean shotAnim = false;
float shotX = 1000;
float shotY = 1000;

int score = 0;

Enemy[] enemy;

void setup() {
  // display size
  size(540, 810);
  // 一貫して枠を表示しない
  noStroke();

  enemy = new Enemy[16];
  // 発展のみの工夫点！！！！！！！！！！！！
  for (int i = 0; i < 4; ++i) {
    for (int j = 0; j < 4; ++j) {
      enemy[i * 4 + j] = new Enemy(i * 100 + 10 +((j % 2)*60), 50 * (j + 1) + 20 * j);
    }
  }

  x = width / 2 - 25;
  y = height - 100;
}

void draw() {
  background(0);

  if (keyPressed == true) {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        x += 10;
      } else if (keyCode == LEFT) {
        x -= 10;
      } else if (keyCode == UP) {
        shot = true;
      }
    }
  }
  keyPressed = false;

  // 画面外に出ない
  if (x + 50 > width) {
    x = width - 50;
  } else if (x < 0) {
    x = 0;
  }

  // 自機
  fill(255);
  rect(x, y, 50, 25);
  rect(x + 22, y - 10, 8, 10);
  // 弾
  if (shot == true) {
    shotX = x + 20;
    shotY = y;
    shot = false;
    shotAnim = true;
  }
  if (shotAnim == true) {
    shotY -= 5;
  } else {
    shotX = 1000;
    shotY = 1000;
  }
  // 画面外判定
  if (shotY < 0) {
    shotAnim = false;
  }
  // 衝突判定
  for (int i = 0; i < 16; i++) {
    if (enemy[i].hit(shotX, shotY)) {
      shotAnim = false;
      score++;
    }
  }
  // 描画
  rect(shotX, shotY, 10, 20);

  // 敵の座標更新
  // 敵の表示
  for (int i = 0; i < 16; i++) {
    enemy[i].update();
    enemy[i].display();
  }

  // GameClearを表示
  if (score == 16) {
    fill(255, 255, 0);
    textSize(70);
    text("GameClear", width/5.5 - 10, height/2);
  }
}

// 敵
class Enemy {
  float x, y;
  float velX = 2;
  float r, g, b;

  Enemy(float firstX, float firstY) {
    x = firstX;
    y = firstY;
    r = random(50, 255);
    g = random(50, 255);
    b = random(50, 255);
  }

  void update() {
    x += velX;
    if (x + 45 > width || x - 10 < 0) {
      velX = -velX;
    }
  }

  void display() {
    fill(r, g, b);
    pushMatrix();
    translate(x, y);

    // 5*5正方形で構成する
    // 胴体
    rect(0, 0, 35, 20);
    // 左触覚
    rect(0, -10, 5, 5);
    rect(5, -5, 5, 5);
    // 右触覚
    rect(30, -10, 5, 5);
    rect(25, -5, 5, 5);
    // 左腕
    rect(-5, 5, 5, 5);
    rect(-5, 10, 5, 5);
    rect(-10, 10, 5, 5);
    rect(-10, 15, 5, 5);
    rect(-10, 20, 5, 5);
    // 右腕
    rect(35, 5, 5, 5);
    rect(35, 10, 5, 5);
    rect(40, 10, 5, 5);
    rect(40, 15, 5, 5);
    rect(40, 20, 5, 5);
    // 左足
    rect(0, 20, 5, 5);
    rect(5, 25, 5, 5);
    rect(10, 25, 5, 5);
    // 右足
    rect(30, 20, 5, 5);
    rect(25, 25, 5, 5);
    rect(20, 25, 5, 5);
    // 目
    fill(0);
    rect(5, 5, 5, 5);
    rect(25, 5, 5, 5);

    popMatrix();
  }

  boolean hit(float hitX, float hitY) {
    if (hitX > x - 10 && hitX < x + 45 && hitY < y + 30 && hitY > y - 10) {
      // どこかへ吹き飛ばす
      y = 1000;
      return true;
    }
    return false;
  }
}