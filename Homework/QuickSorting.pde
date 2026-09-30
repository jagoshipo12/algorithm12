int [] arr;

void setup(){ 
  intArr(16); 
  printArr();
  quickSort(arr, 0, arr.length - 1);
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

void quickSort(int[] a, int left, int right){ 
  if (left < right) { 
    int pivotIndex = partition(a, left, right);
    quickSort(a, left, pivotIndex - 1);   
    quickSort(a, pivotIndex + 1, right);  
  }
}

int partition(int[] a, int left, int right){ 
  int pivot = a[right];   
  int i = left - 1;
  
  for (int j = left; j < right; j++) { 
    if (a[j] <= pivot) { 
      i++;
      swap(a, i, j);
    }
  }
  swap(a, i+1, right);
  return i+1;
}

void swap(int[] a, int i, int j){ 
  int tmp = a[i]; 
  a[i] = a[j]; 
  a[j] = tmp;
}
