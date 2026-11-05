
int[][] value = new int[3][3];
int[][] DP = new int[5][3];
int[][] prev = new int[5][3];

int cnt = 3;

// 가능한 조약돌 배치 패턴 5가지
int[][] pat = {
  {1, 0, 0},
  {0, 1, 0},
  {0, 0, 1},
  {1, 0, 1},
  {0, 0, 0}
};

int[] selectedPattern = new int[3];
boolean[][] selected = new boolean[3][3];

int maxScore = 0;

int cellSize = 140;
int startX = 170;
int startY = 140;

// 각 패턴의 점수 계산
int score(int p, int j) {
  int s = 0;

  for (int r = 0; r < 3; r++) {
    if (pat[p][r] == 1) {
      s += value[r][j];
    }
  }

  return s;
}

// 이전 열과 현재 열의 배치가 겹치는지 확인
boolean ok(int p, int q) {
  for (int r = 0; r < 3; r++) {
    if (pat[p][r] == 1 && pat[q][r] == 1) {
      return false;
    }
  }

  return true;
}

// 문제 생성 및 DP 계산
void generateProblem() {

  // 무작위 숫자 생성
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < cnt; j++) {
      value[i][j] = (int)random(-10, 11);
    }
  }

  // DP 배열 초기화
  for (int p = 0; p < 5; p++) {
    for (int j = 0; j < cnt; j++) {
      DP[p][j] = -999999;
      prev[p][j] = -1;
    }
  }

  // 첫 번째 열 초기화
  for (int p = 0; p < 5; p++) {
    DP[p][0] = score(p, 0);
  }

  // DP 수행
  for (int j = 1; j < cnt; j++) {

    for (int p = 0; p < 5; p++) {

      int best = -999999;
      int bestQ = -1;

      for (int q = 0; q < 5; q++) {

        if (ok(p, q) && DP[q][j - 1] > best) {

          best = DP[q][j - 1];
          bestQ = q;
        }
      }

      DP[p][j] = best + score(p, j);
      prev[p][j] = bestQ;
    }
  }

  // 최댓값 찾기
  maxScore = -999999;
  int bestPattern = -1;

  for (int p = 0; p < 5; p++) {
    if (DP[p][cnt - 1] > maxScore) {
      maxScore = DP[p][cnt - 1];
      bestPattern = p;
    }
  }

  // 최적 배치 역추적
  for (int j = cnt - 1; j >= 0; j--) {

    selectedPattern[j] = bestPattern;

    for (int r = 0; r < 3; r++) {
      selected[r][j] = (pat[bestPattern][r] == 1);
    }

    if (j > 0) {
      bestPattern = prev[bestPattern][j];
    }
  }

  // 결과 콘솔 출력
  println("===== Pebble Placement Problem =====");

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      print(nf(value[i][j], 5) + " ");
    }
    println();
  }

  println("Max Score = " + maxScore);
  println();
}

// 화면 설정
void setup() {
  size(760, 650);
  generateProblem();
}

// 화면 출력
void draw() {

  background(245);

  // 제목
  fill(30);
  textAlign(CENTER);
  textSize(27);
  text("Pebble Placement Problem", width / 2, 55);

  textSize(15);
  fill(90);
  text("Dynamic Programming", width / 2, 85);

  // 격자 출력
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {

      int x = startX + j * cellSize;
      int y = startY + i * cellSize;

      // 기본 칸 색상
      if (selected[i][j]) {
        fill(190, 225, 200);
      } else {
        fill(255);
      }

      stroke(100);
      strokeWeight(2);

      rect(x, y, cellSize, cellSize);

      // 숫자 출력
      fill(40);
      textAlign(CENTER);
      textSize(24);
      text(value[i][j], x + cellSize / 2, y + 35);

      // 조약돌 출력
      if (selected[i][j]) {

        // 그림자
        noStroke();
        fill(0, 35);
        ellipse(
          x + cellSize / 2 + 4,
          y + 88 + 5,
          65, 55
        );

        // 조약돌
        fill(110, 115, 125);
        ellipse(
          x + cellSize / 2,
          y + 88,
          65, 55
        );

        // 돌의 밝은 부분
        fill(175, 180, 190);
        ellipse(
          x + cellSize / 2 - 10,
          y + 78,
          25, 13
        );
      }
    }
  }

  // 최대 점수 표시
  fill(30);
  textSize(25);
  text("Maximum Score : " + maxScore,
       width / 2, 610);

  // 안내 문구
  fill(100);
  textSize(15);
  text("Press R to generate new problem",
       width / 2, 635);
}

// R 키를 누르면 새로운 문제 생성
void keyPressed() {

  if (key == 'r' || key == 'R') {
    generateProblem();
  }
}
