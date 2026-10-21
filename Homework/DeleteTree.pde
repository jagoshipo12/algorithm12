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
  int clickedVal = findNode(tree.root, width/2, 50, width/4);
  if (clickedVal != -1) {
    tree.remove(clickedVal);
  } else {
    int value = (int)random(100); 
    tree.insert(value);
  }
}

int findNode(Node curr, int x, int y, int offset) {
  if (curr == null) return -1;

  float dx = mouseX - x;
  float dy = mouseY - y;
  if (dx*dx + dy*dy <= radius*radius/4) {
    return curr.val;
  }

  int leftVal = findNode(curr.left, x-offset, y+ystep, offset/2);
  if (leftVal != -1) return leftVal;

  int rightVal = findNode(curr.right, x+offset, y+ystep, offset/2);
  return rightVal;
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
  Node(int v) { val = v; }
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

  void remove(int value) {
    root = removeRec(root, value);
  }

  Node removeRec(Node curr, int value) {
    if (curr == null) return null;
    if (value < curr.val) curr.left = removeRec(curr.left, value);
    else if (value > curr.val) curr.right = removeRec(curr.right, value);
    else {
      if (curr.left == null) return curr.right;
      else if (curr.right == null) return curr.left;
      Node minNode = findMin(curr.right);
      curr.val = minNode.val;
      curr.right = removeRec(curr.right, minNode.val);
    }
    return curr;
  }

  Node findMin(Node curr) {
    while (curr.left != null) curr = curr.left;
    return curr;
  }
}
