package testcase.test1;

import java.util.Arrays;

public class ZeroArray {
    public static void main(String[] args) {
        int[] src = new int[1500];
        int[] dst = new int[src.length];
        // for (String argss : args) {
        //     System.out.println(argss);
        // }

        // for (int elem: myarray) {
        // elem = Integer.parseInt(args[0]);
        // elem = 4;
        // }

        System.out.println("Phase 1");
      
        Arrays.fill(myarray, Integer.parseInt(args[0]));

        System.out.println("Phase 2, Copy array");

        System.arraycopy(src, 0, dst, 0, src.length);

        System.out.println("Phase 3");
        // System.out.println("Hello World!");

        // System.gc();
        
        while(true) {
            // noop
        }
    }
}

