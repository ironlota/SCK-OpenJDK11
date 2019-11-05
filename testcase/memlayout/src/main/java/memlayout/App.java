package memlayout;

import org.openjdk.jol.info.ClassLayout;
import sun.misc.Unsafe;

// import sun.misc.VMSupport;

public class App {
  public static long getFirstField(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();

    long value = UnsafeHelper.normalize(unsafe.getInt(object, 12L));

    return value;
  }

  public static long getMarkAddress(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();
    long markAddress = unsafe.getLong(object, 0L);

    return markAddress;
  }

  public static long getHash(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();
    long markAddress = getMarkAddress(object);
    long hash = unsafe.getLong(markAddress + 31L);
    return hash;
  }

  public static long getKlassAddress(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();
    long classAddress = unsafe.getLong(object, 8L);

    return classAddress;
  }

  public static long getKlassAddressCompressedOops(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();
    long classAddress = UnsafeHelper.normalize(unsafe.getInt(object, 8L));
    classAddress = classAddress << 3;
    return classAddress;
  }

  public static long sizeOfCompressedOops(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();
    long classAddress = getKlassAddressCompressedOops(object);
    long size = unsafe.getInt(classAddress + 8L);
    return size;
  }

  public static long sizeOf(Object object) {
    Unsafe unsafe = UnsafeHelper.getUnsafe();
    long classAddress = getKlassAddress(object);
    long size = unsafe.getLong(classAddress + 8L);
    return size;
  }

  public static void main(String[] args) {
    Unsafe u = UnsafeHelper.getUnsafe();

    // Object experiment

    Object obj = new ExampleClass();

    long baseMarkPtr = getMarkAddress(obj);
    long baseKlassPtr = getKlassAddress(obj);
    // String firstFieldValue = (String) u.getObject(obj, 24L);

    System.out.println(System.getProperty("java.version"));
    System.out.println(ClassLayout.parseClass(ExampleClass.class).toPrintable());
    System.out.println("Mark ptr : " + baseMarkPtr);
    System.out.println("Klass ptr : " + baseKlassPtr);
    // System.out.println("Field x ptr : " + firstFieldValue);
    System.out.println("Sizeof ExampleClass " + App.sizeOf(obj));
    System.out.println("Hash of obj " + App.getHash(obj));

    // Array Experiment

    // int size = 1 << 16;
    // int[] array = new int[size];
    // Arrays.fill(array, 1);

    // int base = u.arrayBaseOffset(int[].class);
    // int scale = u.arrayIndexScale(int[].class);
    // long address = UnsafeHelper.toAddress(array);
    // int length = u.getInt(array, 16L);
    // int firstElement = u.getInt(array, 20L);

    // System.out.println(ClassLayout.parseClass(int[].class).toPrintable());
    // System.out.println("Base    : " + base);
    // System.out.println("Scale   : " + scale);
    // System.out.println("Address : " + address);
    // System.out.println("Length  : " + length);
    // System.out.println("First element : " + firstElement);
  }
}
