import 'package:normal/normal.dart';

void main() {
  final d = Normal(),
      xs = [for (var i = 0; i < 14; i++) (i - 6) / 2],
      ps = [for (var i = 1; i < 10; i++) i / 10.0];

  // Probability density function.
  print('\nNormal.pdf\n----------\n');
  for (final x in xs) {
    final p = d.pdf(x);
    print(
        '${x.toString().padLeft(4)} |${' ' * (p * 30).round()}:${p.toStringAsFixed(4)}');
  }

  // Cumulative density function.
  print('\nNormal.cdf\n----------\n');
  for (final x in xs) {
    final p = d.cdf(x);
    print(
        '${x.toString().padLeft(4)} |${' ' * (p * 40).round()}:${p.toStringAsFixed(4)}');
  }

  // Quantile function.
  print('\nNormal.inverseCdf\n-----------------\n');
  for (final p in ps) {
    final x = d.quantile(p);
    print('${p.toStringAsFixed(1)}\t${x.toStringAsFixed(4).padLeft(7)}');
  }

  // Generate random numbers.
  print('\nNormal.generate\n---------------\n');
  for (final x in d.generate(10, seed: 0)) {
    print(x.toStringAsFixed(4).padLeft(7));
  }
}
