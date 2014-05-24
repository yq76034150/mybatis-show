package cn.thinkjoy.mybatisshow;

/**
 * Created by qyang on 14-5-9.
 */
public class Sort {
    public static void main(String[] args) {

        int[] a = {3,4,5,2,1};
        int temp;
        for(int i=0;i<a.length-1;i++) {
            for(int j=i+1;j<a.length;j++) {
                if(a[i]>a[j])
                {temp=a[i];a[i]=a[j];a[j]=temp;}

            }
        }
        for(int b:a){
            System.out.println(b);
        }

    }
}
