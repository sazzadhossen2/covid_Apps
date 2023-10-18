
import 'package:covid_19/view/spalsh_scarren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailscreen extends StatelessWidget {
  String image;
  String name;
  int totalCases,totalDeaths,active,critical,test,totalRecover,todayRecover;
  Detailscreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecover,
    required this.active,
   required this.todayRecover,
    required this.test,
    required this.critical

});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text(name),


),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height* 0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height* 0.06,),
                      Reusablecard(title: 'cases', value:totalCases.toString()),
                      Reusablecard(title: 'Recover', value: totalRecover.toString()),
                      Reusablecard(title: 'Death', value: totalDeaths.toString()),
                      Reusablecard(title: 'Critical', value: critical.toString()),
                      Reusablecard(title: 'Today Recover', value: todayRecover.toString()),
                      Reusablecard(title: 'total Test', value: test.toString()),
                      Reusablecard(title: 'Active', value: active.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(image),
              )
            ],
          )
        ],
      ),
    );
  }
}
