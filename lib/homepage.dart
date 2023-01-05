import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:httpexample/productmodel.dart';
import 'package:httpexample/repository/api_repo.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Procuts>> futureproduct;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureproduct = ApiRepo().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ApiRepo().add_product(
                  '500',
                  'For childrens',
                  'Fashion',
                  'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                  'Tshirts',
                  {"rate": 3.9, "count": 120},
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<Procuts>>(
        future: futureproduct,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisExtent: 450),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Productcard(product: snapshot.data[index]);
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Productcard extends StatelessWidget {
  Productcard({Key? key, required this.product}) : super(key: key);
  Procuts product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2800,
      width: 200,
      // color: Colors.red,
      child: Column(children: [
        Image.network(product.image.toString()),
        Text(
          product.title.toString(),
        ),
        Text(product.price.toString()),
        Text(product.rating.toString()),
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                    ApiRepo().updateProduct(
                        product.id.toString(), 'Name changed', '1000');
                  },
                  child: Text('Update')),
              TextButton(
                  onPressed: () {
                    ApiRepo().deleteProduct(product.id.toString());
                  },
                  child: Text('delete'))
            ],
          ),
        ),
      ]),
    );
  }
}
