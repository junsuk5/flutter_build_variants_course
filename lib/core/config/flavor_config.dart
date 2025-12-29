enum Flavor { dev, staging, prod }

abstract class FlavorConfig {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? 'dev';

  static bool get isDev => name == 'dev';
  static bool get isStaging => name == 'staging';
  static bool get isProd => name == 'prod';
}
