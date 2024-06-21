import 'dart:convert';

import 'package:http/http.dart';
import 'package:tester/model/catagorymodel.dart';

class RepoCatagory {
  String? endpoint;

  RepoCatagory(String target) {
    endpoint = 'https://dummyjson.com/products/category/$target';
    print(endpoint);
  }

  Future<List<Product>> getDataCatagory() async {
    Response response = await get(Uri.parse(endpoint ?? ''));
    if (response.statusCode == 200) {
      final List<dynamic> getdata = jsonDecode(response.body)['products'];
      List<Product> product = getdata.map((e) => Product.fromJson(e)).toList();
      return product;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
