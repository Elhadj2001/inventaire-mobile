import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Couleurs de la charte IPD 2025 (miroir des jetons du back-office web).
class IpdCouleurs {
  static const bleu = Color(0xFF0089D0);
  static const bleuDk = Color(0xFF0070AD);
  static const bleuFonce = Color(0xFF055A8C);
  static const navy = Color(0xFF052A62);
  static const navy2 = Color(0xFF03204A);
  static const fond = Color(0xFFF2F3F5);
  static const bordureCarte = Color(0xFFE5E1D8);
  static const muet = Color(0xFF5B6675);
  static const gris = Color(0xFFD7D8DB);

  // Accents fonctionnels (états / synchro), identiques au web.
  static const vert = Color(0xFF1B6E3A);
  static const vertTint = Color(0xFFDCF3E3);
  static const ambre = Color(0xFFC9881A);
  static const ambreTint = Color(0xFFFBEFD3);
  static const ambreFonce = Color(0xFF8A5A00);
  static const rouge = Color(0xFF9A1F1F);
  static const rougeTint = Color(0xFFFBDDDD);
  static const bleuTint = Color(0xFFE6F2FB);
  static const ardoise = Color(0xFF4A5566);
}

ThemeData themeIpd() {
  final scheme = ColorScheme.fromSeed(
    seedColor: IpdCouleurs.bleu,
    primary: IpdCouleurs.bleu,
    surface: Colors.white,
  );
  final texte = GoogleFonts.latoTextTheme();
  TextStyle titre(TextStyle? base, {FontWeight poids = FontWeight.w700}) =>
      GoogleFonts.poppins(textStyle: base, fontWeight: poids, color: IpdCouleurs.navy);

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: IpdCouleurs.fond,
    textTheme: texte.copyWith(
      headlineSmall: titre(texte.headlineSmall),
      titleLarge: titre(texte.titleLarge),
      titleMedium: titre(texte.titleMedium, poids: FontWeight.w600),
      titleSmall: titre(texte.titleSmall, poids: FontWeight.w600),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: IpdCouleurs.navy,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: IpdCouleurs.bordureCarte),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: IpdCouleurs.bleu,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: IpdCouleurs.navy,
        side: const BorderSide(color: IpdCouleurs.gris),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: IpdCouleurs.bleu),
    ),
    chipTheme: const ChipThemeData(backgroundColor: IpdCouleurs.bleuTint),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: IpdCouleurs.bleu, width: 1.5),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: IpdCouleurs.bleu),
  );
}
