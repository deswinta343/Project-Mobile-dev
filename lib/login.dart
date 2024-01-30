import 'package:ayotripfiks/admin/main_admin.dart';
import 'package:flutter/material.dart';
import 'package:ayotripfiks/customer/screen/welcome_screen.dart';

void main() => runApp(const LoginPage());

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginStatefulWidget extends StatefulWidget {
  const LoginStatefulWidget({super.key});

  @override
  State<LoginStatefulWidget> createState() => _LoginStatefulWidgetState();
}

class _LoginStatefulWidgetState extends State<LoginStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ayo Trip!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              child: Text('Customer'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 60), // Adjust size as needed
                backgroundColor: Colors.blue,
                shape: StadiumBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainAdmin()),
                );
              },
              child: Text('Admin'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 60), // Adjust size as needed
                backgroundColor: Colors.blue,
                shape: StadiumBorder(),
              ),
            ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ProductPage()),
            //     );
            //   },
            //   child: Text('Coba'),
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size(250, 60), // Adjust size as needed
            //     backgroundColor: Colors.blue,
            //     shape: StadiumBorder(),
            //   ),
            // ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
