import 'dart:math' as math;

/// An abstract class for accessing probability density,
/// cumulative probability, quantile and random number generation
/// functions for the normal distribution.
abstract class Normal {
  static double _zpdf(num x) => math.exp(-x * x / 2) / math.sqrt(2 * math.pi);

  /// Gives the normal probability density at [x].
  static double pdf(num x, {num mean = 0, num variance = 1}) {
    final standardDeviation = math.sqrt(variance);
    return _zpdf((x - mean) / standardDeviation) / standardDeviation;
  }

  /// Gives the  normal cululative distribution function.
  ///
  /// Approximation within 7.5E-8 (*Abramowitz* 26.2.17)
  /// of the cumulative probability.
  ///
  static double cdf(num x, {num mean = 0, num variance = 1}) {
    final standardDeviation = math.sqrt(variance),
        z0 = (x - mean) / standardDeviation,
        z = z0.abs(),
        p = 0.2316419,
        t = 1 / (1 + p * z),
        tps = List<num>.generate((5), (i) => math.pow(t, i + 1)),
        b = [0.319381530, -0.356563782, 1.781477937, -1.821255978, 1.330274429],
        c = _zpdf(z) *
            List<int>.generate(5, (i) => i)
                .map((i) => b[i] * tps[i])
                .fold(0, (a, b) => a + b);
    return z0 < 0 ? c : 1 - c;
  }

  /// Gives the quantile associated with an input probability.
  ///
  /// Approximation within 4.5E-4 (*Abramowitz* 26.2.23) of the normal
  /// quantile associated with [p].
  ///
  static double quantile(num p, {num mean = 0, num variance = 1}) {
    final standardDeviation = math.sqrt(variance),
        restrictedP = p > 0.5 ? 1 - p : p,
        t = math.sqrt(math.log(1 / restrictedP / restrictedP)),
        c = [2.515517, 0.802853, 0.010328],
        d = [1.0, 1.432788, 0.189269, 0.001308],
        indices = List<int>.generate(4, (i) => i),
        tps = indices.map((i) => math.pow(t, i)).toList(),
        z = t -
            (indices
                    .sublist(0, 3)
                    .map((i) => c[i] * tps[i])
                    .fold<double>(0, (a, b) => a + b)) /
                (indices.map((i) => d[i] * tps[i]).fold(0, (a, b) => a + b));
    return (p < 0.5 ? -1 : 1) * (mean + z * standardDeviation);
  }

  /// Generates random data drawn from a normal distribution.
  ///
  /// Produces a pseudorandom sample drawn from a normal distribution
  /// through the Box-Muller algorithm.
  ///
  static List<double> generate(int n,
      {num mean = 0, num variance = 1, int? seed}) {
    final rand = seed == null ? math.Random() : math.Random(seed),
        standardDeviation = math.sqrt(variance);
    List<num> pair() {
      final u1 = rand.nextDouble(),
          u2 = rand.nextDouble(),
          r = math.sqrt(-2 * math.log(u1)),
          t = 2 * math.pi * u2;
      return [r * math.cos(t), r * math.sin(t)];
    }

    var zScores = <num>[];
    for (var _ = 0; _ < n ~/ 2; _++) {
      zScores.addAll(pair());
    }
    if (n % 2 == 1) {
      zScores.add(pair().first);
    }
    return zScores.map((z) => z * standardDeviation + mean).toList();
  }
}
