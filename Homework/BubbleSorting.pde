int [] arr;

void setup(){ 
  intArr(16); 
  printArr();
  bubbleSort();
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
 
void bubbleSort(){ 
  int i, j;
  for(i=0; i<arr.length-1; i++) { 
    for(j=0; j<arr.length-1-i; j++) { 
      if(arr[j] > arr[j+1]) { 
        swap(j, j+1);
      }
    }
  }
}

void swap(int i, int j){ 
  int tmp = arr[j]; 
  arr[j] = arr[i]; 
  arr[i] = tmp;
}
