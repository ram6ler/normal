# normal

A simple library for working with the normal probability distribution.

## Usage

A simple usage example:

```dart
import "package:normal/normal.dart";

main() {
  // Probability density function.
  print("\nNormal.pdf\n----------\n");
  for (final x in List.generate(14, (i) => (i - 6) / 2)) {
    final p = Normal.pdf(x);
    print(
        "${x.toString().padLeft(4)} |${" " * (p * 30).round()}:${p.toStringAsFixed(4)}");
  }

  // Cumulative density function.
  print("\nNormal.cdf\n----------\n");
  for (final x in List.generate(14, (i) => (i - 6) / 2)) {
    final p = Normal.cdf(x);
    print(
        "${x.toString().padLeft(4)} |${" " * (p * 40).round()}:${p.toStringAsFixed(4)}");
  }

  // Quantile function.
  print("\nNormal.inverseCdf\n-----------------\n");
  for (final p in List.generate(9, (i) => (i + 1) * 0.1)) {
    final x = Normal.inverseCdf(p);
    print("${p.toStringAsFixed(1)}\t${x.toStringAsFixed(4).padLeft(7)}");
  }

  // Generate random numbers.
  print("\nNormal.generate\n---------------\n");
  for (final x in Normal.generate(10, seed: 0)) {
    print(x.toStringAsFixed(4).padLeft(7));
  }
}

```

Output:

```text
Normal.pdf
----------

-3.0 |:0.0044
-2.5 | :0.0175
-2.0 |  :0.0540
-1.5 |    :0.1295
-1.0 |       :0.2420
-0.5 |           :0.3521
 0.0 |            :0.3989
 0.5 |           :0.3521
 1.0 |       :0.2420
 1.5 |    :0.1295
 2.0 |  :0.0540
 2.5 | :0.0175
 3.0 |:0.0044
 3.5 |:0.0009

Normal.cdf
----------

-3.0 |:0.0013
-2.5 |:0.0062
-2.0 | :0.0228
-1.5 |   :0.0668
-1.0 |      :0.1587
-0.5 |            :0.3085
 0.0 |                    :0.5000
 0.5 |                            :0.6915
 1.0 |                                  :0.8413
 1.5 |                                     :0.9332
 2.0 |                                       :0.9772
 2.5 |                                        :0.9938
 3.0 |                                        :0.9987
 3.5 |                                        :0.9998

Normal.inverseCdf
-----------------

0.1     -1.2817
0.2     -0.8415
0.3     -0.5240
0.4     -0.2529
0.5     -0.0000
0.6      0.2529
0.7      0.5240
0.8      0.8415
0.9      1.2817

Normal.generate
---------------

 0.4679
-0.4057
-0.2936
-1.2753
 0.1079
-0.5593
 0.2815
-0.1063
 0.6585
 0.7765
```

## Features and bugs

Thanks for your interest in *normal*. Please submit [any issues you encounter](https://bitbucket.org/ram6ler/normal/issues).
