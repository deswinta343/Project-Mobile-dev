
class Story { // Membuat class Berita untuk merepresentasikan data Berita
  final int? id; // ID berita, bisa null karena merupakan parameter opsional
  final String judul; // Judul berita, wajib diisi
  final String deskripsi; // Deskripsi berita, wajib diisi
  final String photo;
  
  const Story({this.id, required this.judul, required this.deskripsi, required this.photo}); // Konstruktor dengan parameter opsional dan wajib diisi

  Map<String, dynamic> toList(){ // Metode untuk mengubah objek berita menjadi Map
    return {'id' : id, 'judul' : judul, 'deskripsi' : deskripsi, 'photo' : photo,};
  }

  @override
  String toString(){ // Metode override untuk menghasilkan representasi string dari objek berita
    return "{'id' : id, 'judul' : judul,'deskripsi' : deskripsi, 'photo' : photo}";
  }
}
