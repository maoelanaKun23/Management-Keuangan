import 'package:flutter/material.dart';
import '../models/dummyArtikel.dart';
import '../models/artickel.dart';
import '../views/artikel_detail.dart';

class ArtikelPage extends StatefulWidget {
  @override
  _ArtikelPageState createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  // Menggunakan data dari dummyArtikel
  List<Artikel> artikelList = dummyArtikel.map((item) {
    return Artikel(
      id: item['id'],
      judulArtikel: item['judulArtikel'],
      contentArtikel: item['contentArtikel'],
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2499C0),
        title: Text(
          'Artickel',
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
      body: ListView.builder(
        itemCount: artikelList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                  artikelList[index].judulArtikel ?? "Artikel Tidak Diketahui"),
              subtitle: Text(
                artikelList[index].contentArtikel ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArtikelDetail(
                      artikel: artikelList[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
