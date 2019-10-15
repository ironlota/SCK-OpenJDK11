package testcase.test1;

import java.util.Arrays;

public class ZeroArray {
  public static void main(String[] args) {
    byte[] src = new byte[4096000];
    byte[] dst = new byte[src.length];

    // for (String argss : args) {
    //     System.out.println(argss);
    // }

    // for (int elem: myarray) {
    // elem = Integer.parseInt(args[0]);
    // elem = 4;
    // }

    System.out.println("Phase 1");

    Arrays.fill(src, (byte) 1);

    System.out.println("Phase 2, Copy array");

    System.arraycopy(src, 0, dst, 0, src.length);

    System.out.println("Phase 3");

    System.out.println("src == dst : " + Arrays.equals(src, dst));

    // System.gc();

    while (true) {
      // noop
    }
  }
}
