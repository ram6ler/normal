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
