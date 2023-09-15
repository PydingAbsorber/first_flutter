import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter/pages/profilePage.dart';
import 'package:flutter/material.dart';

class Shop extends StatefulWidget{
  const Shop({super.key, required this.title});


  final String title;

  @override
  State<Shop> createState() => ShopState();
}

class ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: false,
        title: const Text("Shop"),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart),),
          IconButton(onPressed: () {
            if(FirebaseAuth.instance.currentUser == null) {
              Navigator.pushNamed(context, '/profile');
            } else {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(user: FirebaseAuth.instance.currentUser!),
              ),
            );
            }
          }, icon: const Icon(Icons.person),),
        ],
      ),
      drawer: const Drawer(),
      body: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              isDense: true,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              focusedErrorBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.red),
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              hintText: "Search...",
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              )),
        ),
        const Text("Dashboard"),
      ],
      ),
    );
  }
}