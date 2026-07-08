/// URL de l'API, injectée au build :
///   flutter run --dart-define=API_BASE_URL=http://192.168.x.x:8000
/// Défaut : 10.0.2.2 = localhost de la machine hôte vu depuis l'émulateur Android.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000',
);
