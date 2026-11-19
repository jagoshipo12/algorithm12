
int n = 7;

// 그래프의 연결 정보
int[][] graph = {
  {0, 1},
  {0, 2},
  {1, 3},
  {1, 4},
  {2, 4},
  {2, 5},
  {3, 6},
  {4, 6},
  {5, 6}
};

// 노드 위치
float[] nodeX = {
  380, 220, 540, 130, 310, 570, 380
};

float[] nodeY = {
  100, 230, 230, 380, 380, 380, 520
};

// 방문 순서
int[] order = new int[n];

// 부모 노드
int[] parent = new int[n];

String algorithm = "NONE";
int startNode = 0;

void setup() {
  size(700, 650);

  resetGraph();
}

void draw() {
  background(245);

  // 제목
  fill(30);
  textAlign(CENTER);
  textSize(28);
  text("BFS and DFS Graph Traversal", width / 2, 45);

  textSize(17);
  text("Press B : BFS    Press D : DFS    Press R : Reset",
       width / 2, 80);

  // 간선 그리기
  drawEdges();

  // 노드 그리기
  drawNodes();

  // 탐색 결과
  fill(30);
  textSize(20);

  if (algorithm.equals("BFS")) {
    text("Breadth-First Search", width / 2, 590);
  }
  else if (algorithm.equals("DFS")) {
    text("Depth-First Search", width / 2, 590);
  }
  else {
    text("Start Node : 0", width / 2, 590);
  }

  // 탐색 순서 출력
  textSize(16);

  if (!algorithm.equals("NONE")) {
    String result = "Traversal Order : ";

    for (int i = 0; i < n; i++) {
      if (order[i] != -1) {
        result += order[i] + " ";
      }
    }

    text(result, width / 2, 625);
  }
}

// 간선 출력
void drawEdges() {

  strokeWeight(4);

  for (int i = 0; i < graph.length; i++) {

    int a = graph[i][0];
    int b = graph[i][1];

    // 탐색 트리 간선 강조
    if (parent[b] == a || parent[a] == b) {
      stroke(255, 100, 50);
    }
    else {
      stroke(170);
    }

    line(nodeX[a], nodeY[a], nodeX[b], nodeY[b]);
  }
}

// 노드 출력
void drawNodes() {

  for (int i = 0; i < n; i++) {

    // 방문 여부에 따른 색상
    if (order[i] != -1) {
      fill(100, 200, 130);
    }
    else {
      fill(220);
    }

    // 시작 노드
    if (i == startNode) {
      stroke(255, 150, 0);
      strokeWeight(5);
    }
    else {
      stroke(50);
      strokeWeight(2);
    }

    ellipse(nodeX[i], nodeY[i], 65, 65);

    // 노드 번호
    fill(30);
    textAlign(CENTER);
    textSize(20);
    text(i, nodeX[i], nodeY[i] + 7);

    // 방문 순서
    if (order[i] != -1) {
      fill(255);
      textSize(14);
      text("Order " + order[i],
           nodeX[i], nodeY[i] + 45);
    }
  }
}

// BFS
void BFS(int start) {

  boolean[] visited = new boolean[n];

  int[] queue = new int[n];
  int front = 0;
  int rear = 0;

  int count = 0;

  queue[rear++] = start;
  visited[start] = true;

  while (front < rear) {

    int current = queue[front++];

    order[current] = count++;

    // 인접 노드 확인
    for (int i = 0; i < graph.length; i++) {

      int a = graph[i][0];
      int b = graph[i][1];

      int next = -1;

      if (a == current) {
        next = b;
      }
      else if (b == current) {
        next = a;
      }

      if (next != -1 && !visited[next]) {

        visited[next] = true;
        parent[next] = current;

        queue[rear++] = next;
      }
    }
  }
}

// DFS
void DFS(int current, boolean[] visited, int count[]) {

  visited[current] = true;

  order[current] = count[0];
  count[0]++;

  // 인접 노드 확인
  for (int i = 0; i < graph.length; i++) {

    int a = graph[i][0];
    int b = graph[i][1];

    int next = -1;

    if (a == current) {
      next = b;
    }
    else if (b == current) {
      next = a;
    }

    if (next != -1 && !visited[next]) {

      parent[next] = current;

      DFS(next, visited, count);
    }
  }
}

// 초기화
void resetGraph() {

  for (int i = 0; i < n; i++) {
    order[i] = -1;
    parent[i] = -1;
  }

  algorithm = "NONE";
}

// 키 입력
void keyPressed() {

  if (key == 'b' || key == 'B') {

    resetGraph();
    algorithm = "BFS";

    BFS(startNode);
  }

  if (key == 'd' || key == 'D') {

    resetGraph();
    algorithm = "DFS";

    boolean[] visited = new boolean[n];
    int[] count = {0};

    DFS(startNode, visited, count);
  }

  if (key == 'r' || key == 'R') {

    resetGraph();
  }
}
