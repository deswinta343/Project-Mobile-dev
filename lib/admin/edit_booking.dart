import 'package:flutter/material.dart';
import 'package:ayotripfiks/sqlite_db.dart';
import 'package:ayotripfiks/model/booking.dart';
import 'package:ayotripfiks/admin/booking_admin.dart';

class FormEditBooking extends StatefulWidget {
  final Booking booking;

  FormEditBooking({required this.booking});

  @override
  _FormEditBookingState createState() => _FormEditBookingState();
}

class _FormEditBookingState extends State<FormEditBooking> {
  late TextEditingController namaController;
  late TextEditingController destinasiController;
  late TextEditingController nohpController;
  late TextEditingController hargaController;
  late TextEditingController jumlahController;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller dengan nilai awal dari widget.booking
    namaController = TextEditingController(text: widget.booking.nama);
    destinasiController = TextEditingController(text: widget.booking.destinasi);
    nohpController = TextEditingController(text: widget.booking.nohp);
    hargaController = TextEditingController(text: widget.booking.harga);
    jumlahController = TextEditingController(text: widget.booking.jumlah);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Booking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: destinasiController,
                decoration: InputDecoration(labelText: 'Destinasi Tujuan'),
              ),
              TextField(
                controller: nohpController,
                decoration: InputDecoration(labelText: 'No Hp'),
              ),
              TextField(
                controller: hargaController,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
              TextField(
                controller: jumlahController,
                decoration: InputDecoration(labelText: 'Jumlah'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Update data booking dengan nilai baru dari controller
                  Booking updatedBooking = Booking(
                    id: widget.booking.id,
                    nama: namaController.text,
                    destinasi: destinasiController.text,
                    nohp: nohpController.text,
                    harga: hargaController.text,
                    jumlah: jumlahController.text,
                  );

                  // Panggil metode updateBooking dengan objek Booking yang telah diubah
                  await DatabaseHelper.updateBooking(updatedBooking);

                  // Kembali ke halaman sebelumnya
                  Navigator.pop(context);
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
