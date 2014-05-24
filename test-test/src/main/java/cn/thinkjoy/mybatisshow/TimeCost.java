package cn.thinkjoy.mybatisshow;

import java.util.Date;

/**
 * Created by qyang on 14-5-8.
 */
public class TimeCost {
    public static void main(String[] args) {
        int size = 1000000;
        long start = System.currentTimeMillis();
        for(int i = 0; i < size; i++){
            System.currentTimeMillis();
        }
        System.out.println(System.currentTimeMillis()-start);


        start = System.currentTimeMillis();
        for(int i = 0; i < size; i++){
            new Date().getTime();
        }
        System.out.println(System.currentTimeMillis()-start);
    }
}
