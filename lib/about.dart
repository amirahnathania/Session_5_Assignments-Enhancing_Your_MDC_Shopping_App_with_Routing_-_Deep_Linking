import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo / avatar (kamu bisa ganti dengan gambar sendiri)
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/cookpedia.png'),
            ),
            const SizedBox(height: 16),

            // Judul / nama aplikasi
            const Text(
              'Thania KShop',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Deskripsi singkat
            const Text(
              'Developed with Flutter ❤️',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Versi (opsional)
            const Text(
              'Version: 1.0.0',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
