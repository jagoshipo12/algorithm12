int xstep = 60;  
int ystep = 60;  
int radius = 30; 

BST tree = new BST();

void setup() {
  size(800, 600);
  background(200);
}

void draw() {
  background(200);
  drawTree(tree.root, width/2, 50, width/4);
}

void mousePressed() {
  int value = (int)random(100); 
  tree.insert(value);
}


void drawTree(Node curr, int x, int y, int offset) {
  if (curr == null) return;

  if (curr.left != null) {
    line(x, y, x-offset, y+ystep);
    drawTree(curr.left, x-offset, y+ystep, offset/2);
  }

  if (curr.right != null) {
    line(x, y, x+offset, y+ystep);
    drawTree(curr.right, x+offset, y+ystep, offset/2);
  }

  fill(255);
  ellipse(x, y, radius, radius);
  fill(0);
  textAlign(CENTER, CENTER);
  text(curr.val, x, y);
}

class Node {
  int val;
  Node left, right;

  Node(int v) {
    val = v;
  }
}

class BST {
  Node root;

  void insert(int value) {
    root = insertRec(root, value);
  }

  Node insertRec(Node curr, int value) {
    if (curr == null) return new Node(value);
    if (value < curr.val) curr.left = insertRec(curr.left, value);
    else if (value > curr.val) curr.right = insertRec(curr.right, value);
    return curr;
  }
}
