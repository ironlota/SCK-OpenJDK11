package testcase.test1;

import java.util.Arrays;

public class ZeroArray {
    static int[] myarray = new int[15000000];

    public static void main(String[] args) {
        // for (String argss : args) {
        //     System.out.println(argss);
        // }

        // for (int elem: myarray) {
        // elem = Integer.parseInt(args[0]);
        // elem = 4;
        // }
      
        Arrays.fill(myarray, Integer.parseInt(args[0]));
        // System.out.println("Hello World!");

        // System.gc();
        
        while(true) {
            // noop
        }
    }
}

