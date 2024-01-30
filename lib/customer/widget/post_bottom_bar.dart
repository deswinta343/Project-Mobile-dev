import 'package:sqflite/sqflite.dart';
import 'package:ayotripfiks/sqlite_db.dart';
import 'package:flutter/material.dart';
import 'package:ayotripfiks/customer/customer_page/form_booking.dart';

class PostBottomBar extends StatelessWidget {
  Future<Map<String, dynamic>> fiks() async {
    try {
      final List<Map<String, dynamic>> results =
          await DatabaseHelper.getWisataData();

      if (results.isNotEmpty) {
        return results.first;
      } else {
        return {}; // Kembalikan objek kosong jika tidak ada data
      }
    } catch (e) {
      print("Error fetching data: $e");
      return {}; // Kembalikan objek kosong jika terjadi kesalahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Detail Wisata"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getWisataData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Menampilkan indikator loading jika data masih diambil
          }

          final List<Map<String, dynamic>> wisata = snapshot.data ?? [];

          return Container(
            height: MediaQuery.of(context).size.height / 1 + 100,
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              ),
            ),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "images/city2.jpg",
                          fit: BoxFit.cover,
                          width: 150,
                          height: 250,
                        ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${wisata.isNotEmpty ? wisata[0]['judul'] ?? "" : ""}                          ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text(
                            "${wisata.isNotEmpty ? wisata[0]['ratting'] ?? "" : ""}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "${wisata.isNotEmpty ? wisata[0]['deskripsi'] ?? "" : ""}",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "${wisata.isNotEmpty ? wisata[0]['harga'] ?? "" : ""}",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height:
                              160), // Add spacing between the two containers
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => BookingForm()),
                              );
                            },
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 26,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ),
                    ],
                  ),
                ],
                ),
              )
            ],
            ),
          );
        },
      ),
    );
  }
}
