package testcase.memlayout;

import sun.misc.Unsafe;

public class MemLayout {
  public Unsafe unsafe;
  private static MemLayout memlayoutInstance = null;

  private MemLayout() {
    this.unsafe = UnsafeHelper.getUnsafe();
  }

  public static MemLayout get() {
    if (memlayoutInstance == null) return new MemLayout();
    else return memlayoutInstance;
  }

  public static Unsafe getUnsafe() {
    return get().unsafe;
  }

  public static void main(String[] args) {
    Unsafe u = MemLayout.get().getUnsafe();

    int size = 1 << 16;
    int[] array = new int[size];
    int base = u.arrayBaseOffset(Integer.class);
    int scale = u.arrayIndexScale(Integer.class);

    System.out.println(u);
    System.out.println("Base  : " + base);
    System.out.println("Scale : " + scale);
  }
}
