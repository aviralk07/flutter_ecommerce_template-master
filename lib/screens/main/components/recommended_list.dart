import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/products2api.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatelessWidget {
  final email;

  var StaggeredGridView;

  var StaggeredTile;
  RecommendedList(this.email);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                'Recommended',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: FutureBuilder(
              future: fetchAllProducts2(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding:
                        EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                    child: StaggeredGridView.countBuilder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          new ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => ProductPage(email,
                                      product: snapshot.data[index]))),
                          child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                    colors: [
                                      Colors.grey.withOpacity(0.3),
                                      Colors.grey.withOpacity(0.7),
                                    ],
                                    center: Alignment(0, 0),
                                    radius: 0.6,
                                    focal: Alignment(0, 0),
                                    focalRadius: 0.1),
                              ),
                              child: Hero(
                                  tag: snapshot.data[index].imgurl,
                                  child: Image.asset(
                                      snapshot.data[index].imgurl))),
                        ),
                      ),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(2, index.isEven ? 3 : 2),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  );
                }
                return CircularProgressIndicator.adaptive();
              }),
        ),
      ],
    );
  }
}