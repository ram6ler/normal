import 'dart:math' as math;

const _p = 0.2316419,
    _nb = 5,
    _b = [
      0.319381530,
      -0.356563782,
      1.781477937,
      -1.821255978,
      1.330274429,
    ],
    _nc = 3,
    _c = [2.515517, 0.802853, 0.010328],
    _nd = 4,
    _d = [1.0, 1.432788, 0.189269, 0.001308];

double _standardDensity(num x) => math.exp(-x * x / 2) / math.sqrt(2 * math.pi);

class Normal {
  Normal([this.mean = 0.0, this.variance = 1.0])
      : standardDeviation = math.sqrt(variance);

  /// The mean of the normal distribution.
  final num mean;

  /// The variance of the normal distribution.
  final num variance;

  /// The standard deviation of the normal distribution.
  final num standardDeviation;

  /// Gives the normal probability density at [x].
  num pdf(num x) =>
      _standardDensity((x - mean) / standardDeviation) / standardDeviation;

  /// Gives the  normal cumulative distribution function.
  ///
  /// Approximation within 7.5E-8 (*Abramowitz* 26.2.17)
  /// of the cumulative probability.
  ///
  num cdf(num x) {
    final z0 = (x - mean) / standardDeviation,
        z = z0.abs(),
        t = 1 / (1 + _p * z),
        tps = [for (var i = 0; i < _nb; i++) math.pow(t, i + 1)],
        c = _standardDensity(z) *
            [for (var i = 0; i < _nb; i++) _b[i] * tps[i]]
                .fold(0, (a, b) => a + b);
    return z0 < 0 ? c : 1 - c;
  }

  /// Gives the quantile associated with an input probability.
  ///
  /// Approximation within 4.5E-4 (*Abramowitz* 26.2.23) of the normal
  /// quantile associated with [p].
  ///
  num quantile(num p) {
    final standardDeviation = math.sqrt(variance),
        restrictedP = p > 0.5 ? 1 - p : p,
        t = math.sqrt(math.log(1 / restrictedP / restrictedP)),
        tps = [for (var i = 0; i < _nd; i++) math.pow(t, i)],
        cs = [for (var i = 0; i < _nc; i++) _c[i] * tps[i]]
            .fold(0.0, (a, b) => a + b),
        ds = [for (var i = 0; i < _nd; i++) _d[i] * tps[i]]
            .fold(0.0, (a, b) => a + b),
        z = t - cs / ds;

    return (p < 0.5 ? -1 : 1) * (mean + z * standardDeviation);
  }

  /// Generates random data drawn from a normal distribution.
  ///
  /// Produces a pseudorandom sample drawn from a normal distribution
  /// through the Box-Muller algorithm.
  ///
  List<num> generate(int n, {int? seed}) {
    final rand = seed == null ? math.Random() : math.Random(seed),
        standardDeviation = math.sqrt(variance);
    num next() {
      final u1 = rand.nextDouble(),
          u2 = rand.nextDouble(),
          r = math.sqrt(-2 * math.log(u1)),
          t = 2 * math.pi * u2;
      return r * math.cos(t);
    }

    final zScores = [for (var _ = 0; _ < n; _++) next()];

    return [for (final z in zScores) z * standardDeviation + mean];
  }
}
