int [] arr;

void setup(){ 
  intArr(16); 
  printArr();
  mergeSort(arr, 0, arr.length-1);
  printMerge();
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

void mergeSort(int[] a, int left, int right){ 
  if (left < right) { 
    int mid = (left + right) / 2;
    mergeSort(a, left, mid);     
    mergeSort(a, mid+1, right);   
  }
}

void merge(int[] a, int left, int mid, int right){ 
  int n1 = mid - left + 1;
  int n2 = right - mid;

  int[] L = new int[n1];
  int[] R = new int[n2];

  for (int i=0; i<n1; i++) L[i] = a[left + i];
  for (int j=0; j<n2; j++) R[j] = a[mid + 1 + j];

  int i = 0, j = 0, k = left;
  while (i < n1 && j < n2) { 
    if (L[i] <= R[j]) { 
      a[k] = L[i]; 
      i++;
    } else { 
      a[k] = R[j]; 
      j++;
    }
    k++;
  }

  while (i < n1) { 
    a[k] = L[i]; 
    i++; 
    k++;
  }
  while (j < n2) { 
    a[k] = R[j]; 
    j++; 
    k++;
  }
}

void printMerge() { 
  for (int i=0; i<arr.length; i++) {
    print(arr[i] + " ");
  }
  println();
}
