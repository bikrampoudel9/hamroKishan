import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List salesList = [];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  fetchSalesData() async {
    String ip = Constants.ip;
    String url = "http://" + ip + "/hackathon/available_sales.php";
    var uri = Uri.parse(url);
    var response = await http.post(uri);
    // setState(() {
    //   salesList = jsonDecode(response.body);
    // });
    salesList = jsonDecode(response.body);
    return salesList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchSalesData();
  }

  @override
  Widget build(BuildContext context) {
    var textSytle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    var valueTextSytle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order",
          style: TextStyle(fontSize: 15),
        ),
        toolbarHeight: 40,
      ),
      body: FutureBuilder(
          future: fetchSalesData(),
          builder: (context, snapshot) {
            if (salesList != null) {
              return ListView.builder(
                  itemCount: salesList.length,
                  itemBuilder: (context, index) {
                    // return AvailableOrderList(
                    //         salesList[index]['email'],
                    //         salesList[index]['contact'],
                    //         salesList[index]['full_name'],
                    //         salesList[index]['potato_type'],
                    //         salesList[index]['quantity'],
                    //         salesList[index]['price'],
                    //         salesList[index]['location'])
                    //     .getView();
                    return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 146, 197, -2),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name: " + salesList[index]['full_name'],
                                      style: textSytle,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "Email: " + salesList[index]['email'],
                                      style: textSytle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Type: " +
                                          salesList[index]['potato_type'],
                                      style: textSytle,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "Quantity" +
                                          salesList[index]['quantity'] +
                                          "KG",
                                      style: textSytle,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Price: " + salesList[index]['price'],
                                      style: textSytle,
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "Location: " +
                                          salesList[index]['location'],
                                      style: textSytle,
                                    ),
                                  ],
                                )
                              ]),
                              const SizedBox(
                                width: 20,
                              ),
                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                child: IconButton(
                                  onPressed: () {
                                    String number = salesList[index]['contact'];
                                    _makePhoneCall(number);
                                  },
                                  icon: const Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            } else {
              return const Text("LOading....");
            }
          }),
    );
  }
}
