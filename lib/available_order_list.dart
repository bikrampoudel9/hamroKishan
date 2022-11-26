import 'package:flutter/material.dart';

class AvailableOrderList {
  String email;
  String number;
  String name;
  String potatoType;
  String quantity;
  String price;
  String location;
  AvailableOrderList(this.email, this.number, this.name, this.potatoType,
      this.quantity, this.price, this.location);
  Widget getView() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Column(children: [
            Row(
              children: [
                Text("Name: " + name),
                const SizedBox(
                  width: 10,
                ),
                Text("Email: " + email),
              ],
            ),
            Row(
              children: [
                Text("Type: " + potatoType),
                const SizedBox(
                  width: 10,
                ),
                Text("Quantity" + quantity + "KG"),
              ],
            ),
            Row(
              children: [
                Text("Price: " + price),
                const SizedBox(
                  width: 10,
                ),
                Text("Location" + location),
              ],
            )
          ]),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: Colors.green,
              ))
        ],
      ),
    ));
  }
}
