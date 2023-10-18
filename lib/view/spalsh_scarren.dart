
import 'package:covid_19/model/world_state_model.dart';
import 'package:covid_19/view/cuntri_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../service/utilities/states_service.dart';
class Worldscreen extends StatefulWidget {
  @override
  State<Worldscreen> createState() => _WorldscreenState();
}
class _WorldscreenState extends State<Worldscreen>with TickerProviderStateMixin {
  late final AnimationController _controller =AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();
  void dispose(){
    super.dispose();

    _controller.dispose();
  }
  final colorlist=[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesService statesService =StatesService();
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(

              children: [
                SizedBox(height: MediaQuery.of(context).size.height*.01,),
                FutureBuilder(future:statesService.fectworldstate() ,
                    builder:(context,AsyncSnapshot<WorldStateModel> snapshot){
                      if(!snapshot.hasData){
                        return Expanded(
                            flex: 1,
                            child:SpinKitCircle(
                              color: Colors.white,
                              size:50.0,
                              controller: _controller,
                            ));
                      }
                      else{

                        return Column(
                          children: [
                            PieChart(dataMap: {
                              "Total":double.parse(snapshot.data!.cases!.toString()),
                              "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                              "Deaths":double.parse(snapshot.data!.deaths!.toString()),
                            },
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true
                              ),
                              chartRadius: MediaQuery.of(context).size.width/3.2,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorlist,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *0.06),
                              child: Card(
                                child: Column(
                                  children: [
                                    Reusablecard(title: "Total", value:snapshot.data!.cases.toString()),
                                    Reusablecard(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                    Reusablecard(title: "Death", value:snapshot.data!.deaths.toString()),
                                    Reusablecard(title: "Active", value:snapshot.data!.active.toString()),
                                    Reusablecard(title: "Critical", value: snapshot.data!.critical.toString()),
                                    Reusablecard(title: "Today Deaths", value:snapshot.data!.todayDeaths.toString()),
                                    Reusablecard(title: "Today Recover", value:snapshot.data!.todayRecovered.toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return Cuntrilist();
                                }));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text("Track Countries"),
                                ),
                              ),
                            )
                          ],
                        );


                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reusablecard extends StatelessWidget {
  String title,value;
  Reusablecard({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
