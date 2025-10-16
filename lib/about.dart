import 'package:flutter/material.dart';
import 'colors.dart'; // IMPORT INI UNTUK WARNA THEME

class AboutScreen extends StatelessWidget {
  final bool showAppBar;
  const AboutScreen({Key? key, this.showAppBar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kShrinePink300, // TAMBAHKAN BACKGROUND COLOR
      appBar: showAppBar ? AppBar(
        title: const Text('About Us'), // CONSISTENT TITLE
        centerTitle: true,
        backgroundColor: kShrinePink100, // CONSISTENT COLOR
        foregroundColor: kShrineBrown900, // CONSISTENT COLOR
      ) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo / avatar (kamu bisa ganti dengan gambar sendiri)
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: kShrinePink100, // CONSISTENT COLOR
                shape: BoxShape.circle,
                border: Border.all(color: kShrineBrown900, width: 2),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 50,
                color: kShrineBrown900, // CONSISTENT COLOR
              ),
            ),
            const SizedBox(height: 24),

            // Judul / nama aplikasi
            Text(
              'THANIA KSHOP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kShrineBrown900, // CONSISTENT COLOR
              ),
            ),
            const SizedBox(height: 12),

            // Deskripsi singkat
            Text(
              'Your Favorite Shopping Destination',
              style: TextStyle(
                fontSize: 16,
                color: kShrineBrown900.withOpacity(0.7), // CONSISTENT COLOR
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            Text(
              'Developed with Flutter ❤️',
              style: TextStyle(
                fontSize: 14,
                color: kShrineBrown900.withOpacity(0.6), // CONSISTENT COLOR
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Informasi tambahan
            _buildInfoCard(
              icon: Icons.email,
              title: 'Contact Us',
              subtitle: 'thaniafahreza@email.com',
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.location_on,
              title: 'Location',
              subtitle: 'Indonesia',
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.phone,
              title: 'Customer Service',
              subtitle: '+6282396505539',
            ),
            const SizedBox(height: 24),

            // Versi
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: kShrinePink100, // CONSISTENT COLOR
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: kShrineBrown900, // CONSISTENT COLOR
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: kShrineBackgroundWhite, // TAMBAHKAN CARD BACKGROUND COLOR
      child: ListTile(
        leading: Icon(
          icon,
          color: kShrineBrown900, // CONSISTENT COLOR
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kShrineBrown900, // CONSISTENT COLOR
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: kShrineBrown900.withOpacity(0.7), // CONSISTENT COLOR
          ),
        ),
      ),
    );
  }
}