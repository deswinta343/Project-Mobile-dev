class Booking {
  final int? id;
  final String nama;
  final String destinasi;
  final String nohp;
  final String harga;
  final String jumlah;

  const Booking({
    this.id,
    required this.nama,
    required this.destinasi,
    required this.nohp,
    required this.harga,
    required this.jumlah,
  });

  // Factory constructor to create a Booking object from a Map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      nama: map['nama'],
      destinasi: map['destinasi'],
      nohp: map['nohp'],
      harga: map['harga'],
      jumlah: map['jumlah'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'destinasi': destinasi,
      'nohp': nohp,
      'harga': harga,
      'jumlah': jumlah,
    };
  }

  @override
  String toString() {
    return "{'id': $id, 'nama': $nama, 'destinasi': $destinasi, 'nohp': $nohp, 'harga': $harga, 'jumlah': $jumlah}";
  }
}
