import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'dart:async';
import 'package:convert/convert.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

import 'helper_classes.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled=false;

    return new MaterialApp(
      title: 'Rota do Mar',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        body: new Container(
          child: new Column(
              children: <Widget>[
                new BrandAppBar(),
                new HomePageBody()
              ]
          ),
        )
    );
  }
}

class BrandAppBar extends StatelessWidget {

  final brand = new AssetImage('assets/images/logo-rota-best.png');
  final double barHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: barHeight + statusBarHeight,
      decoration: new BoxDecoration(
          color: Colors.white
      ),
      child: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Center(
            child: new Container(
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: brand,
                  )
              ),
            )
        ),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {

  final Category male = new Category(
      name: 'Masculino',
      products: new List(),
      image: 'assets/maleCategorieBg.jpg'
  );

  final Category female = new Category(
      name: 'Feminino',
      products: new List(),
      image: 'assets/female-categorie.jpg'
  );

  final Category accessory = new Category(
      name: 'Acessórios',
      products: new List(),
      image: 'assets/acessoryCategory.jpg'
  );

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new ListView(
        children: <Widget>[
          new CategoryRow(male),
          new CategoryRow(female),
          new CategoryRow(accessory),
          new CategoryRow(female),
        ],
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {

  final Category category;

  CategoryRow(this.category);

  final headerTextStyle = const TextStyle(
    fontFamily: 'Exo2-Regular',
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {

    final categoryCard = new Stack(
      children: <Widget>[
        new Container(
          height: 200.0,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(category.image),
                  fit: BoxFit.cover
              ),
              color: new Color.fromRGBO(58, 140, 178, 0.9),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0)
                )
              ]
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: new Color.fromRGBO(58, 140, 178, 0.7),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0)
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: new Center(
              child: new Text(
                category.name,
                style: const TextStyle(
                  fontFamily: 'Exo2-Regular',
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              )
          ),
        )
      ],
    );

    return new GestureDetector(
      onTap: () => Navigator.of(context).push(new CupertinoPageRoute(
        builder: (_) => new DetailPage(category),
      )),
      child: new Container(
        margin: new EdgeInsets.all(16.0),
        child: new Stack(
          children: <Widget>[
            categoryCard
          ],
        ),
      ),
    );
  }
}


class DetailPage extends StatefulWidget {
  final Category tappedCategory;

  DetailPage(this.tappedCategory);

  _DetailPageState createState() => new _DetailPageState(tappedCategory);

}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  final Category tappedCategory;

  //List<Product> products = List();
  //Product product;
  //DatabaseReference productRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _DetailPageState(this.tappedCategory);

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Firebase
    //product = Product("", "", "", 0.0);
    // final FirebaseDatabase database = FirebaseDatabase(app: app);
    // productRef = database.reference().child('products');

    // Top Bar Desizing Animation
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
    );

    final CurvedAnimation curve = new CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    animation = new Tween(
        begin: 250.0,
        end: 80.0
    ). animate(curve)
      ..addListener((){
        setState(() {

        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                    height: animation.value + statusBarHeight,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new AssetImage(tappedCategory.image),
                            fit: BoxFit.cover
                        )
                    ),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: new Color.fromRGBO(58, 140, 178, 0.7),
                          shape: BoxShape.rectangle,
                          borderRadius: new BorderRadius.circular(8.0)
                      ),
                      child: new Center(
                        child: new Text(
                          tappedCategory.name,
                          style: const TextStyle(
                              fontFamily: 'Exo2-Regular',
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
            new Expanded(
              child: new CatalogGridView().build(),
            )
          ],
        ),
      ),
    );
  }
}


class ProductPage extends StatelessWidget {

  final Product product;

  ProductPage(this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Text(product.name),
            ),
            new Container(
              height: 500.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(product.image),
                  fit: BoxFit.cover
                )
              ),
            )
          ],
        ),
      ),
    );
  }
  
}

class ProductCard extends StatelessWidget {

  final titleTextStyle = const TextStyle(
    fontFamily: 'Exo2-Regular',
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
  );

  final priceTextStyle = const TextStyle(
    fontFamily: 'Exo2-Regular',
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );

  final Product product = new Product(name: "Teste", price: 29.90, description: 'PRODUTO MUITO BOM', image: 'assets/productEx.jpeg');


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => Navigator.of(context).push(new CupertinoPageRoute(
        builder: (_) => new ProductPage(product),
      )),
      child: new Card(
        elevation: 1.0,
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new Center(
                child: new Image(
                  image: new AssetImage(product.image),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(product.name, style: titleTextStyle),
                    ),
                    new Text(product.getPrice(), style: priceTextStyle)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}

class CatalogGridView{

  final titleTextStyle = const TextStyle(
    fontFamily: 'Exo2-Regular',
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
  );

  final priceTextStyle = const TextStyle(
    fontFamily: 'Exo2-Regular',
    color: Colors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );

  Widget makeGridCell(String image, String name, String price){
    return new ProductCard();
  }


  GridView build(){
    //final resp = new Request();

    return GridView.count(
      primary: true,
      padding: new EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        makeGridCell('assets/productEx.jpeg', 'Bermuda1', 'R\$59.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda2', 'R\$69.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda3', 'R\$89.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda4', 'R\$39.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
      ],
    );
  }
}

