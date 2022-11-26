import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class SellProduct extends StatefulWidget {
  const SellProduct({Key? key}) : super(key: key);

  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  TextEditingController potatoTypeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          runSpacing: 20,
          children: [
            TextField(
              controller: potatoTypeController,
              decoration: const InputDecoration(hintText: "Potato Type"),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(hintText: "Quantity"),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(hintText: "Price/kg"),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(hintText: "Location"),
            ),
            ElevatedButton(
              onPressed: uploadDate,
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  void onSubmitClick() {}
  void uploadDate() async {
    // var storage = FlutterSession();
    // String? user = await storage.get("USER_EMAIL");
    String user = Constants.USER_EMAIL;
    String potatoType = potatoTypeController.text;
    String quantity = quantityController.text;
    String price = priceController.text;
    String location = locationController.text;

    String ip = Constants.ip;
    String url = "http://" + ip + "/hackathon/sells_upload.php";
    var uri = Uri.parse(url);

    if (user != null) {
      var response = await http.post(uri, body: {
        'user': user,
        'potato_type': potatoType,
        'quantity': quantity,
        'price': price,
        'location': location
      });
      if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Unable to upload data!");
      } else if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Successfully added !");
      }
    }
  }
}
