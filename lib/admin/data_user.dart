import 'package:flutter/material.dart';
import 'package:ayotripfiks/model/user.dart';
import 'package:ayotripfiks/sqlite_db.dart';

class AdminUserList extends StatefulWidget {
  @override
  _AdminUserListState createState() => _AdminUserListState();
}

class _AdminUserListState extends State<AdminUserList> {
  late Future<List<User>> userList; // Change variable name to userList

  @override
  void initState() {
    super.initState();
    userList = DatabaseHelper.getUser(); // Change variable name to userList
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data User'),
      ),
      body: FutureBuilder<List<User>>(
        future: userList, // Change variable name to userList
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Handle the data from snapshot.data
            List<User> users = snapshot.data ?? [];

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('User ID: ${users[index].id}'),
                  subtitle: Text('Username: ${users[index].username}'),
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
