int [] arr;

void setup(){ 
  int i, j, max, index, tmp; 
  intArr(16); 
  printArr();
  selectionSorting();
  printArr();
}

void intArr(int n){
  int i;
  arr = new int[n];
  for (i=0; i<arr.length; i++) { 
    arr[i] = (int) random(100);
  }
 }
 void printArr() { 
   int i; 
   for (i=0; i<arr.length; i++) {  
    print(arr[i], "");
  }
  println();
 }
 
 void selectionSorting(){ 
   int i, j, max, index; 
   for(i=0; i<arr.length; i++) { 
    max = index = -1;
    for(j=0; j<arr.length-i; j++) { 
      if(max<arr[j]) { 
        index = j; 
        max = arr[j]; 
      }
    }
    swap(index, arr.length-i-1);
    } 
  }

void swap(int i, int j){ 
  int tmp; 
  tmp = arr[j]; 
  arr[j] = arr[i]; 
  arr[i] = tmp;
}








/*void setup() { 
  size(600, 400);
  println("In setup");
  
} 

void draw() { 
  stroke(random(255), random(255), random(255)); //선 색깔
  line(random(600),random(400),random(600),random(400)); //선 그리기
  println("In draw");
} */
