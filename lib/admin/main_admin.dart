import 'package:flutter/material.dart';
import 'package:ayotripfiks/admin/product_admin.dart';
import 'package:ayotripfiks/admin/booking_admin.dart';
import 'package:ayotripfiks/admin/data_user.dart';
import 'package:flutter/painting.dart'; // This import includes ImageProvider


void main() {
  runApp(
    const MaterialApp(
      home: MainAdmin(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

const List<Item> _items = [
  Item(
    name: 'Kelola Wisata',
    uid: '1',
    imageProvider: NetworkImage('https://cdn.fortuneidn.com//post/20220915/shutterstock-631736717-77f12c3dfcc7ed31b914b58f3ba8fcea-c368def470dfd0860f8f307afce1ed9a.jpg'),
  ),
  Item(
    name: 'Kelola Booking',
    uid: '2',
    imageProvider: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzJ3StU7mmVAxAxquy4SZ_n_ng9YOfV5wwmw&usqp=CAU'),
  ),
  Item(
    name: 'Kelola Artikel Wisata',
    uid: '3',
    imageProvider: NetworkImage('https://joglosemarnews.com/images/2019/02/0111-buku-a.jpg'),
  ),
  Item(
    name: 'Kelola Data User',
    uid: '4',
    imageProvider: NetworkImage('https://cdn1.katadata.co.id/media/images/thumb/2022/11/23/Ilustrasi_Perbedaan_administrasi_dan_manajemen-2022_11_23-19_42_21_74f4093dfeb74941188f19fa90834ec4_960x640_thumb.jpg'),
  ),
];

@immutable
class MainAdmin extends StatefulWidget {
  const MainAdmin({Key? key}) : super(key: key);

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

   PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.blue),
      title: Text(
        'Halo Admin01!',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 20,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: _buildMenuList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return Align(
          alignment: Alignment.centerRight,
          child: _buildMenuItem(
            item: item,
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required Item item,
  }) {
    return GestureDetector(
      onTap: () {
        if (item.uid == '1') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProdukPage()),
          );
        } else if (item.uid == '2') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminStrukList()),
          );
        } else if (item.uid == '3' || item.uid == '4') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminUserList()),
          );
        }
      },
      child: MenuListItem(
        name: item.name,
        photoProvider: item.imageProvider,
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    Key? key,
    required this.name,
    required this.photoProvider,
    this.isDepressed = false,
  }) : super(key: key);

  final String name;
  final ImageProvider photoProvider;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image(
                      image: photoProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item({
    required this.name,
    required this.uid,
    required this.imageProvider,
  });

  final String name;
  final String uid;
  final ImageProvider imageProvider;
}
