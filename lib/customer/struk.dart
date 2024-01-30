import 'package:flutter/material.dart';
import 'package:ayotripfiks/model/booking.dart';

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
            Text('----------------------------------------------------'),
            Text('Booking Details:', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('----------------------------------------------------'),
            Text('Nama: ${booking.nama}'),
            Text('Destinasi Tujuan: ${booking.destinasi}'),
            Text('No Hp: ${booking.nohp}'),
            Text('Harga: ${booking.harga}'),
            Text('Jumlah: ${booking.jumlah}'),
            Text('----------------------------------------------------'),
            Text('Pembayaran dapat dilakukan melalui via bank', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
            Text('----------------------------------------------------'),
            Text('No. Reference pembayaran 123456'),
            Text('----------------------------------------------------'),
            Text('Jangan lupa simpan bukti transaksi:)'),
            Text('Thx'),
          ],
        ),
      ),
    );
  }
}
