
class Wisata { // Membuat class Berita untuk merepresentasikan data Berita
  final int? id; // ID berita, bisa null karena merupakan parameter opsional
  final String judul;
  final String ratting;// Judul berita, wajib diisi
  final String deskripsi;
  final String harga; // Deskripsi berita, wajib diisi
  final String photo;
  
  const Wisata({this.id, required this.judul, required this.ratting, required this.deskripsi, required this.harga, required this.photo}); // Konstruktor dengan parameter opsional dan wajib diisi

  Map<String, dynamic> toList(){ // Metode untuk mengubah objek berita menjadi Map
    return {'id' : id, 'judul' : judul, 'ratting' : ratting, 'deskripsi' : deskripsi,'harga' : harga, 'photo' : photo,};
  }

  @override
  String toString(){ // Metode override untuk menghasilkan representasi string dari objek berita
    return "{'id' : id, 'judul' : judul,'ratting' : ratting, 'deskripsi' : deskripsi, 'harga' : harga,'photo' : photo}";
  }
}
