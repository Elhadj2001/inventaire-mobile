# Règles R8/ProGuard — Inventaire IPD
#
# R8 est actif par défaut en build release (Flutter). Sans ces règles, il
# obfusque/élague les classes ML Kit (barcode scanning) que mobile_scanner
# charge par réflexion, d'où le NPE `genericError` / "getClass() on a null
# object reference" à l'ouverture de la caméra.
#
# Les règles keep embarquées par mobile_scanner utilisent `com.google.mlkit.*`
# (une seule étoile) qui ne couvre pas les sous-paquets ; on repasse en `**`.

-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Barcode scanning (implémentation interne via GMS)
-keep class com.google.android.gms.internal.mlkit_vision_barcode.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_common.** { *; }
-keep class com.google.android.libraries.barhopper.** { *; }

# CameraX (utilisé par mobile_scanner pour le flux caméra)
-keep class androidx.camera.** { *; }
-dontwarn androidx.camera.**
