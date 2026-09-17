int [] arr;

void setup(){ 
  intArr(16); 
  printArr();
  insertSort();
  printSort();
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

void insertSort(){ 
  for (int i = 1; i < arr.length; i++) { 
    int key = arr[i]; 
    int j = i - 1; 
    while (j >= 0 && arr[j] > key) { 
      arr[j+1] = arr[j]; 
      j--;
    }
    arr[j+1] = key; 
  }
}

void printSort(){ 
  for (int i=0; i<arr.length; i++) {  
    print(arr[i], " ");
  }
  println();
}




  
