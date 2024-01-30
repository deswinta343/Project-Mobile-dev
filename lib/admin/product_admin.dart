// Import paket-paket yang diperlukan untuk mengimplementasikan halaman ini.
import 'package:flutter/material.dart';
// import 'package:uas/detail_wisata.dart';
import 'package:ayotripfiks/sqlite_db.dart'; // Import file yang berisi definisi kelas DatabaseHelper.
import 'dart:io'; // Import pustaka dart:io untuk berinteraksi dengan sistem operasi.
import 'package:path_provider/path_provider.dart'; // Import pustaka path_provider.dart untuk manipulasi path file.
import 'package:file_picker/file_picker.dart'; // Import pustaka file_picker untuk memungkinkan pengguna memilih file.
import 'package:ayotripfiks/model/wisata.dart'; // Import file yang berisi definisi kelas Foto.

// Kelas Halaman3 adalah StatefulWidget yang menampilkan daftar kenangan foto.
class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

// Kelas _Halaman3State adalah State dari Halaman3.
class _ProdukPageState extends State<ProdukPage> {
  // Controller untuk input judul dan deskripsi foto.
  TextEditingController judulController = TextEditingController();
  TextEditingController rattingController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController hargaController = TextEditingController();

  // Daftar kenangan foto yang akan ditampilkan di halaman.
  List<Map<String, dynamic>> fiks = [];
  Map<String, dynamic>? fiksDihapus;

  @override
  void initState() {
    // Memanggil fungsi refreshData() pada saat inisialisasi state.
    refreshData();
    super.initState();
  }

  // Fungsi untuk menambahkan foto baru ke dalam database.
  Future<void> tambahWisata(Wisata wisata) async {
    await DatabaseHelper.tambahWisata(wisata);
    return refreshData();
  }

  // Fungsi untuk memperbarui foto di dalam database.
  Future<void> updateWisata(Wisata wisata) async {
    await DatabaseHelper.updateWisata(wisata);
    return refreshData();
  }

  // Fungsi untuk menghapus foto dari database.
  Future<void> deleteWisata(int id) async {
    await DatabaseHelper.deleteWisata(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Berhasil Dihapus")));
    return refreshData();
  }

  // Fungsi untuk memperbarui data yang ditampilkan di halaman.
  Future<void> refreshData() async {
    final data = await DatabaseHelper.getWisataData();
    setState(() {
      fiks = data;
    });
  }

  // Path file foto yang dipilih oleh pengguna.
  String? photoprofile;

  // Fungsi untuk memilih file foto menggunakan FilePicker.
  Future<String> getFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
        'webm',
      ],
    );

    if (result != null) {
      PlatformFile sourceFile = result.files.first;
      final destination = await getExternalStorageDirectory();
      File? destinationFile =
          File('${destination!.path}/${sourceFile.name.hashCode}');
      final newFile =
          File(sourceFile.path!).copy(destinationFile.path.toString());
      setState(() {
        photoprofile = destinationFile.path;
      });
      File(sourceFile.path!.toString()).delete();
      return destinationFile.path;
    } else {
      return "Dokumen belum diupload";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Memanfaatkan widget Scaffold sebagai kerangka utama halaman.
    return Scaffold(
      appBar: AppBar(
        title: Text("AyoTrip!"),
      ),
      body: ListView.builder(
        itemCount: fiks.length,
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Wisata selectedWisata = Wisata(
                      id: fiks[index]['id'],
                      judul: fiks[index]['judul'],
                      ratting: fiks[index]['ratting'],
                      deskripsi: fiks[index]['deskripsi'],
                      harga: fiks[index]['harga'],
                      photo: fiks[index]['photo'],
                    );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         DetailWisataPage(wisata: selectedWisata),
                    //   ),
                    // );
                  },
                  child: Image.file(
                    File(fiks[index]['photo']),
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Menampilkan judul foto.
                          Text(
                            fiks[index]['judul'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            fiks[index]['ratting'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Menampilkan deskripsi foto.
                          Text(fiks[index]['deskripsi']),
                          const SizedBox(height: 8),
                          Text(
                            fiks[index]['harga'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Tombol-tombol untuk mengedit dan menghapus foto.
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Form(fiks[index]['id']),
                            icon: const Icon(Icons.edit),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              deleteWisata(fiks[index]['id']);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // Tombol Floating Action Button untuk menambahkan kenangan foto baru.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Form(null);
        },
        tooltip: 'Tambah Produk',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Fungsi untuk menampilkan formulir tambah/edit kenangan foto.
  void Form(id) async {
    if (id != null) {
      // Jika id tidak null, isi formulir dengan data foto yang akan diupdate.
      final dataupdate = fiks.firstWhere((element) => element['id'] == id);
      judulController.text = dataupdate['judul'];
      rattingController.text = dataupdate['ratting'];
      deskripsiController.text = dataupdate['deskripsi'];
      hargaController.text = dataupdate['harga'];
    }

    // Tunggu hingga pengguna memilih file foto.
    String? photoPath = await getFilePicker();

    // Menampilkan bottom sheet yang berisi formulir tambah/edit kenangan foto.
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: 800,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Input judul kenangan foto.
                  TextField(
                    controller: judulController,
                    decoration: const InputDecoration(hintText: "Judul"),
                  ),
                  TextField(
                    controller: rattingController,
                    decoration: const InputDecoration(hintText: "Ratting"),
                  ),
                  // Input deskripsi kenangan foto.
                  TextField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(hintText: "Deskripsi"),
                  ),
                  TextField(
                    controller: hargaController,
                    decoration: const InputDecoration(hintText: "Harga"),
                  ),
                  // Tombol untuk memilih file foto.
                  ElevatedButton(
                      onPressed: () {
                        getFilePicker();
                      },
                      child: Row(
                        children: const [
                          Text("Pilih Gambar"),
                          Icon(Icons.camera)
                        ],
                      )),
                  // Tombol untuk menambahkan atau memperbarui kenangan foto.
                  ElevatedButton(
                      onPressed: () async {
                        if (id != null) {
                          // Jika id tidak null, update data foto.
                          String? photo = photoPath;
                          final data = Wisata(
                              id: id,
                              judul: judulController.text,
                              ratting: rattingController.text,
                              deskripsi: deskripsiController.text,
                              harga: hargaController.text,
                              photo: photo.toString());
                          updateWisata(data);
                          judulController.text = '';
                          rattingController.text = '';
                          deskripsiController.text = '';
                          hargaController.text = '';
                          Navigator.pop(context);
                        } else {
                          // Jika id null, tambahkan data foto baru.
                          String? photo = photoPath;
                          final data = Wisata(
                             judul: judulController.text,
                              ratting: rattingController.text,
                              deskripsi: deskripsiController.text,
                              harga: hargaController.text,
                              photo: photo.toString());
                          tambahWisata(data);
                          judulController.text = '';
                          rattingController.text = '';
                          deskripsiController.text = '';
                          hargaController.text = '';
                          Navigator.pop(context);
                        }
                      },
                      child: Text(id == null ? "Tambah" : 'update'))
                ],
              ),
            ),
          );
        });
  }
}
