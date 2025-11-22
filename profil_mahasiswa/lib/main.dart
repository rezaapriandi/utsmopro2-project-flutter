import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import file-file yang sudah dipisahkan
import 'models/profile.dart';
import 'pages/profil_page.dart';

void main() {
  runApp(const MyApp());
}

// MyApp adalah StatefulWidget untuk mengelola state tema (bonus poin)
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State untuk menyimpan mode tema (Light/Dark)
  ThemeMode _themeMode = ThemeMode.light;

  // Fungsi callback yang diteruskan ke ProfilePage untuk mengubah state tema
  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  // Pengaturan Tema Dasar (Light dan Dark)
  ThemeData _buildTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    const Color primary = Color(0xFF004D40); // Teal 800
    const Color secondary = Color(0xFF4DB6AC); // Teal 300
    const Color background = Color(0xFFE0F2F1); // Teal 50

    return ThemeData(
      brightness: brightness,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSwatch(
        // Menentukan swatch warna berdasarkan primary color
        primarySwatch: MaterialColor(primary.value, {
          50: primary.withOpacity(0.1),
          100: primary.withOpacity(0.2),
          200: primary.withOpacity(0.3),
          300: primary.withOpacity(0.4),
          400: primary.withOpacity(0.5),
          500: primary,
          600: primary.withOpacity(0.7),
          700: primary.withOpacity(0.8),
          800: primary.withOpacity(0.9),
          900: primary,
        }),
        accentColor: secondary,
        backgroundColor: isDark ? const Color(0xFF121212) : background,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      cardColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shadowColor: Colors.black,

      // Menggunakan GoogleFonts.inter untuk konsistensi font
      textTheme: GoogleFonts.interTextTheme(
        isDark
            ? Typography.whiteMountainView // Untuk Dark Mode
            : Typography.blackMountainView, // Untuk Light Mode
      ).copyWith(
        headlineSmall: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDark ? secondary : primary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          color: isDark ? Colors.white54 : Colors.black54,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : primary,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.white),
      ),
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa Reza',
      // Mengatur tema global: light dan dark
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: _themeMode, // Menggunakan state untuk tema
      debugShowCheckedModeBanner: false,
      home: ProfilePage(
        profile: rezaApriandiProfile, // Data profil dari file models
        themeMode: _themeMode,
        onThemeToggle: _setThemeMode, // Meneruskan fungsi setState ke halaman profil
      ),
    );
  }
}