import 'package:flutter/material.dart';
import 'package:hami_kishan/order.dart';
import 'package:hami_kishan/sell.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(fontSize: 15),
          ),
          toolbarHeight: 40,
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const Order();
                    },
                  ));
                },
                child: const Text("Order")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SellProduct();
                    },
                  ));
                },
                child: const Text("Sell")),
          ]),
        ));
  }
}
