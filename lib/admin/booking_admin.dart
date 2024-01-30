import 'package:ayotripfiks/customer/customer_page/form_booking.dart';
import 'package:flutter/material.dart';
import 'package:ayotripfiks/model/booking.dart';
import 'package:ayotripfiks/sqlite_db.dart';

class AdminStrukList extends StatefulWidget {
  @override
  _AdminStrukListState createState() => _AdminStrukListState();
}

class _AdminStrukListState extends State<AdminStrukList> {
  late Future<List<Booking>> strukList;

  @override
  void initState() {
    super.initState();
    strukList = DatabaseHelper.getBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Struk List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle the "add" button click, navigate to the page for adding a new booking.
              // Example:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingForm(), // Replace with your actual page for adding a booking
                ),
              ).then((_) {
                // Refresh the list after adding a new booking
                setState(() {
                  strukList = DatabaseHelper.getBooking();
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Booking>>(
        future: strukList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Handle the data from snapshot.data
            List<Booking> bookings = snapshot.data ?? [];

            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Booking ID: ${bookings[index].id}'),
                  subtitle: Text('Nama: ${bookings[index].nama}'),
                  // Add more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
