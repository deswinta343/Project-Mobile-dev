import 'package:flutter/material.dart';
import 'package:ayotripfiks/sqlite_db.dart';
import 'package:ayotripfiks/model/booking.dart';
import 'package:ayotripfiks/customer/struk.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key? key}) : super(key: key);

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  TextEditingController namaController = TextEditingController();
  TextEditingController destinasiController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Input Form Booking'),
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
                  try {
                    Booking booking = Booking(
                      nama: namaController.text,
                      destinasi: destinasiController.text,
                      nohp: nohpController.text,
                      harga: hargaController.text,
                      jumlah: jumlahController.text,
                    );

                    // Insert the booking into the database
                    await DatabaseHelper.tambahBooking(booking);

                    // Navigate to the StrukPage with the booking details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StrukPage(booking: booking),
                      ),
                    );
                  } catch (e) {
                    print('Error navigating to StrukPage: $e');
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
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

class StrukPage extends StatelessWidget {
  final Booking booking;

  StrukPage({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Struk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('------------------------------------------------', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            Text('Booking Details:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            SizedBox(height: 8),
Text('------------------------------------------------', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            Text('Nama: ${booking.nama}'),
            Text('Destinasi Tujuan: ${booking.destinasi}'),
            Text('No Hp: ${booking.nohp}'),
            Text('Harga: ${booking.harga}'),
            Text('Jumlah: ${booking.jumlah}'),
            Text('------------------------------------------------', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            Text('Pembayaran: via bank'),
Text('------------------------------------------------', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            Text('No. Reference pembayaran 123456'),
Text('------------------------------------------------', style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            Text('Jangan lupa simpan bukti transaksi:)'),
            Text('Thx'),
          ],
        ),
      ),
    );
  }
}

