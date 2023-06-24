import 'package:flutter/material.dart';
import 'package:full_stack_training/api_service.dart';

class Brands extends StatefulWidget {
  const Brands({super.key});

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {
  List _brands = [];
  bool isLoadedBrands = false;

  fetchData() async {
    if (!isLoadedBrands) {
      List brandsData = await getBrands();
      setState(() {
        _brands = brandsData;
        isLoadedBrands = true;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                mainAxisSpacing: 8.0, // Spacing between rows
                crossAxisSpacing: 8.0, // Spacing between columns
              ),
              itemCount: _brands.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.blueGrey,
                  child: Center(
                    child: Column(children: [
                      Text(_brands[index]["name"]!),
                      Text("Ph No.: ${_brands[index]["phNo"]!}")
                    ]),
                  ),
                );
              },
            );
          }
        });
  }
}
