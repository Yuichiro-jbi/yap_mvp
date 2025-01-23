enum Flavor { dev, staging, production }

class FlavorConfig {
  static late Flavor flavor;
  static late String appName;
  static late String baseUrl;
  
  static void setup(String flavorName) {
    switch (flavorName) {
      case 'dev':
        flavor = Flavor.dev;
        appName = 'YAP Island (Dev)';
        baseUrl = 'https://dev-api.yapisland.com';
        break;
      case 'staging':
        flavor = Flavor.staging;
        appName = 'YAP Island (Staging)';
        baseUrl = 'https://staging-api.yapisland.com';
        break;
      case 'production':
      default:
        flavor = Flavor.production;
        appName = 'YAP Island';
        baseUrl = 'https://api.yapisland.com';
        break;
    }
  }

  static bool get isDevelopment => flavor == Flavor.dev;
  static bool get isStaging => flavor == Flavor.staging;
  static bool get isProduction => flavor == Flavor.production;
}
