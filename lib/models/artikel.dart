class Artikel {
  final String id;
  final String judulArtikel;
  final String contentArtikel;

  Artikel({
    required this.id,
    required this.judulArtikel,
    required this.contentArtikel,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      id: json['id'],
      judulArtikel: json['judul_artikel'],
      contentArtikel: json['content_artikel'],
    );
  }
}
