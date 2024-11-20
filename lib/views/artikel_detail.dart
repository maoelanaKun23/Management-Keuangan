import 'package:flutter/material.dart';
import '../models/artickel.dart';

class ArtikelDetail extends StatelessWidget {
  final Artikel artikel;

  const ArtikelDetail({
    super.key,
    required this.artikel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2499C0),
        title: Text(
          artikel.judulArtikel ?? 'Detail Artickel',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artikel.judulArtikel ?? "Artikel Tidak Diketahui",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              artikel.contentArtikel ?? "Tidak ada konten tersedia.",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
