int[] arr;
int i = 0, j = 0;
boolean sorting = true;

void setup() {
  size(800, 400);
  intArr(50); 
}

void draw() {
  background(255);
  displayArray();

  if (sorting) {
    bubbleStep(); 
  }
}

void intArr(int n) {
  arr = new int[n];
  for (int i=0; i<arr.length; i++) {
    arr[i] = (int) random(height);  
  }
}

void displayArray() {
  int barWidth = width / arr.length;
  for (int k=0; k<arr.length; k++) {
    fill(100, 150, 255);
    rect(k * barWidth, height - arr[k], barWidth, arr[k]);
  }
}

void bubbleStep() {
  if (i < arr.length) {
    if (j < arr.length - i - 1) {
      if (arr[j] > arr[j+1]) {
        swap(j, j+1);
      }
      j++;
    } else {
      j = 0;
      i++;
    }
  } else {
    sorting = false;  
  }
}

void swap(int a, int b) {
  int tmp = arr[a];
  arr[a] = arr[b];
  arr[b] = tmp;
}
