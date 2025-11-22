import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


import '../models/profile.dart';
import '../widgets/info_card.dart';
import '../widgets/hobby_item.dart';
import '../widgets/skill_item.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  final ThemeMode themeMode;
  final Function(ThemeMode) onThemeToggle;

  const ProfilePage({
    Key? key,
    required this.profile,
    required this.themeMode,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- Konfigurasi Ukuran ---
  final double _coverHeight = 280.0;
  final double _profileRadius = 70.0;

  IconData _getHobbyIcon(String hobby) {
    String h = hobby.toLowerCase();
    if (h.contains('bola') || h.contains('futsal')) {
      return FontAwesomeIcons.futbol;
    } else if (h.contains('musik') || h.contains('gitar')) {
      return FontAwesomeIcons.music;
    } else if (h.contains('game') || h.contains('gaming')) {
      return FontAwesomeIcons.gamepad;
    } else if (h.contains('konten') ||
        h.contains('video') ||
        h.contains('foto')) {
      return FontAwesomeIcons.camera;
    } else if (h.contains('baca') || h.contains('nulis')) {
      return FontAwesomeIcons.book;
    } else if (h.contains('coding') || h.contains('ngoding')) {
      return FontAwesomeIcons.laptopCode;
    }
    return FontAwesomeIcons.heart;
  }

  final List<Color> skillColors = [
    Colors.blue.shade600,
    Colors.purple.shade600,
    Colors.teal.shade600,
    Colors.orange.shade600,
    Colors.red.shade600,
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.themeMode == ThemeMode.dark;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 600;
    final Color scaffoldBgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      
      body: CustomScrollView(
        slivers: [
          
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none, 
              alignment: Alignment.topCenter,
              children: [
                
                Container(
                  height: _coverHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.grey, // Placeholder warna
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/cover.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey.shade800),
                      ),
                      
                      Container(color: Colors.black.withOpacity(0.2)),
                    ],
                  ),
                ),

                
                Padding(
                  padding: EdgeInsets.only(top: _coverHeight - _profileRadius),
                  child: Column(
                    children: [
                      // Lingkaran Foto
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                scaffoldBgColor, 
                            width: 4.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: _profileRadius,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage:
                              const AssetImage('assets/foto_profil.jpg'),
                          onBackgroundImageError: (_, __) {},
                        ),
                      ),

                      const SizedBox(height: 10),

                      
                      Text(
                        widget.profile.nama,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),

                // Tombol Ganti Tema
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.onThemeToggle(
                          isDarkMode ? ThemeMode.light : ThemeMode.dark);
                    },
                    icon: FaIcon(
                      isDarkMode ? FontAwesomeIcons.sun : FontAwesomeIcons.moon,
                      size: 16,
                    ),
                    label: Text(
                      isDarkMode ? 'Light Mode' : 'Dark Mode',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isDarkMode ? Colors.grey.shade800 : primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Informasi Akademik (NIM, dll)
                Column(
                  children: [
                    Text(
                      'NIM: ${widget.profile.nim}',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.profile.jurusan,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: primaryColor.withOpacity(0.5)),
                      ),
                      child: Text(
                        widget.profile.formattedStatus,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const Divider(
                    height: 40, thickness: 1, indent: 20, endIndent: 20),

                // Kontak
                _buildSectionTitle(context, 'Kontak'),
                InfoCard(
                  icon: FontAwesomeIcons.phone,
                  title: 'Telepon',
                  subtitle: widget.profile.telepon,
                ),
                InfoCard(
                  icon: FontAwesomeIcons.solidEnvelope,
                  title: 'Email',
                  subtitle: widget.profile.email,
                ),
                InfoCard(
                  icon: FontAwesomeIcons.instagram,
                  title: 'Instagram',
                  subtitle: widget.profile.instagram,
                ),

                const Divider(
                    height: 40, thickness: 1, indent: 20, endIndent: 20),

                // Skill
                _buildSectionTitle(context, 'Skill'),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.profile.skill.length,
                    itemBuilder: (context, index) {
                      final color = skillColors[index % skillColors.length];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SkillItem(
                          skill: widget.profile.skill[index],
                          color: color,
                        ),
                      );
                    },
                  ),
                ),

                const Divider(
                    height: 40, thickness: 1, indent: 20, endIndent: 20),

                // Hobi
                _buildSectionTitle(context, 'Hobi'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 2 : 4,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: widget.profile.hobi.length,
                    itemBuilder: (context, index) {
                      final hobby = widget.profile.hobi[index];
                      return HobbyItem(
                        hobby: hobby,
                        icon: _getHobbyIcon(hobby),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.titleLarge?.color,
        ),
      ),
    );
  }
}
