#include <stdio.h>
#include <stdlib.h>
int binarySearch(int *arr,int size,int key){

int low =0,high = size-1;
int mid;

while(high >=low){
mid = (low + high)/2;
    if (key == arr[mid])
        return mid;
    else if (key > arr[mid]) 
        low = mid + 1;
    else                       
        high = mid - 1;
}
return -1;
}

int main(){

int arr[5]={1,5,3,4,8};
int search = binarySearch(arr,5,8);
if(search == -1){
printf("NotFound");
}
else{
printf("The index is %d \n" ,search);
}
return 0;
};
