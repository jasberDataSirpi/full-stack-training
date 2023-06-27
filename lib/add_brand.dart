import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_stack_training/api_service.dart';

class AddBrand extends StatefulWidget {
  const AddBrand({super.key});

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _phNoController = TextEditingController();

  bool isLoadedBrandData = false;
  bool isEditEnabled = false;
  late int brandId;

  late Map<String, dynamic> arguments =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

  String brandName = "";
  String phoneNumber = "";
  Future fetchBrandData() async {
    isEditEnabled = arguments['id'] != null;
    if (isEditEnabled) {
      if (!isLoadedBrandData) {
        brandId = arguments['id'];
        var brandData = await getBrandById(arguments['id']);
        brandName = brandData["name"]!;
        phoneNumber = (brandData["phNo"]).toString();
        _brandNameController.text = brandName;
        _phNoController.text = phoneNumber;
        isLoadedBrandData = true;
        return true;
      }
    }
    return null;
  }

  onClickAddOrUpdateBrand(context) async {
    if (brandName.isNotEmpty && phoneNumber.isNotEmpty) {
      var payload =
          jsonEncode({"name": brandName, "phNo": int.parse(phoneNumber)});
      bool isAddedSuccessfully = false;
      if (isEditEnabled) {
        isAddedSuccessfully = await updateBrand(brandId, payload);
      } else {
        isAddedSuccessfully = await addBrand(payload);
      }
      if (isAddedSuccessfully) {
        // Clear the inputs
        _brandNameController.clear();
        _phNoController.clear();
        // Toast
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Brand ${isEditEnabled ? 'updated' : 'added'} successfully'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.greenAccent,
          ),
        );
        // Navigate
        Navigator.pushNamed(context, "/");
      }
    }
  }

  Widget formBody() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _brandNameController,
                onChanged: (value) => {brandName = value},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter brand name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _phNoController,
                onChanged: (value) => {phoneNumber = value},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () => {onClickAddOrUpdateBrand(context)},
                  child: Text("${isEditEnabled ? "Update" : "Add"} Brand"),
                )),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Brand Details Page"),
      ),
      body: FutureBuilder(
          future: fetchBrandData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return formBody();
            }
          }),
    );
  }
}
