int [] arr;

void setup(){ 
  intArr(16); 
  printArr();
  heapSort(arr);
  println();
  printArr();
}

void intArr(int n){
  arr = new int[n];
  for (int i=0; i<arr.length; i++) { 
    arr[i] = (int) random(100);
  }
}

void printArr() { 
  for (int i=0; i<arr.length; i++) {  
    print(arr[i], " ");
  }
  println();
}

void heapSort(int[] a){ 
  int n = a.length;

  for (int i = n/2 - 1; i >= 0; i--) {
    heapify(a, n, i);
  }

  for (int i = n - 1; i > 0; i--) {
    swap(a, 0, i);      
    heapify(a, i, 0);    
  }
}

void heapify(int[] a, int n, int i){ 
  int largest = i;       
  int left = 2*i + 1;    
  int right = 2*i + 2;   

  if (left < n && a[left] > a[largest]) {
    largest = left;
  }
  if (right < n && a[right] > a[largest]) {
    largest = right;
  }

  if (largest != i) {
    swap(a, i, largest);
    heapify(a, n, largest); 
  }
}

void swap(int[] a, int i, int j){ 
  int tmp = a[i]; 
  a[i] = a[j]; 
  a[j] = tmp;
}
