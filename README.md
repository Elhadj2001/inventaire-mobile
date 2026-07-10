# Inventaire IPD — Application mobile

[![CI](https://github.com/Elhadj2001/inventaire-mobile/actions/workflows/ci.yml/badge.svg)](https://github.com/Elhadj2001/inventaire-mobile/actions/workflows/ci.yml)

Application Android (Flutter) de scan QR pour l'inventaire de l'Institut Pasteur de Dakar.
Fonctionne **en ligne et hors ligne** (référentiel embarqué, file de synchronisation
idempotente), avec photos (Cloudinary).

- Version : **1.0.0**
- API : configurée au build via `--dart-define=API_BASE_URL=...`

## Développement
```bash
flutter pub get
dart run build_runner build          # génère la base locale drift
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

## Tests
```bash
flutter analyze
flutter test
```
> Si le chemin du projet contient une apostrophe, `flutter test` échoue (bug d'outillage
> Flutter) : copiez `lib/` + `test/` + `pubspec.*` dans un chemin sans apostrophe pour lancer
> les tests.

## Build de l'APK
```bash
flutter build apk --release --no-tree-shake-icons \
  --dart-define=API_BASE_URL=https://inventaire-api.onrender.com
```
- Ne pas retirer `--no-tree-shake-icons` ni `android/app/proguard-rules.pro` (règles keep
  ML Kit indispensables au scanner).
- Signature de production : voir `docs/GUIDE_KEYSTORE.md` (dépôt `inventaire-api`).

## Guide utilisateur
`docs/GUIDE_AGENT.md` (dépôt `inventaire-api`) — 1 page pour les agents.
