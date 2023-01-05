import 'dart:convert';

//import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:httpexample/productmodel.dart';

class ApiRepo {
  Uri url = Uri.parse('https://fakestoreapi.com/products/');

  Future<List<Procuts>> fetchProduct() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //  print(response.body);

      final data = json.decode(response.body).cast<Map<String, dynamic>>();
      print(data[0]);
      return data.map<Procuts>((json) => Procuts.fromJson(json)).toList();
    } else {
      //  print('didnt get data');
      throw Exception('failed to load products');
    }
  }

  Future<void> add_product(String price, String des, String categ, String img,
      String title, Map rating) async {
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'price': price,
          'description': des,
          'category': categ,
          'image': img,
          'rating': rating
        }));

    if (response.statusCode == 200) {
      print(response.body);
      print('product added succesfully');
    } else {
      print('peoduct not added');
    }
  }

  Future<void> updateProduct(String id, String title, String price) async {
    final response = await http.put(
        Uri.parse('https://fakestoreapi.com/products/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{'title': title, 'price': price}));
    if (response.statusCode == 200) {
      print(response.body);
      print('product updated succesfully');
    } else {
      print('peoduct not updated');
    }
  }
  Future<void> deleteProduct(String id) async {
    final response = await http.delete(
        Uri.parse('https://fakestoreapi.com/products/$id'),
      //Uri.parse('https://fakestoreapi.com/products/50'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
       // body: jsonEncode(<String, dynamic>{'id': id}));
    if (response.statusCode == 200) {
      print(response.body);
      print('product deleted succesfully');
    } else {
      print('peoduct not deleted');
    }
  }

 
}
