
import 'package:covid_19/service/utilities/states_service.dart';
import 'package:covid_19/view/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Cuntrilist extends StatefulWidget {
  @override
  State<Cuntrilist> createState() => _CuntrilistState();
}

class _CuntrilistState extends State<Cuntrilist> {
TextEditingController searchcontroll =TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesService statesService =StatesService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller:searchcontroll ,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(future:statesService.countriesApi() ,
                  builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount:4,
                      itemBuilder: (context,index){

                        return Shimmer.fromColors(
                            child: Column(
                          children: [
                            ListTile(
                              title: Container(height: 10,width: 89,color: Colors.white,),
                              subtitle: Container(height: 10,width: 89,color: Colors.white,),
                         leading: Container(height: 10,width: 89,color: Colors.white,),
                            )
                          ],
                        ) ,
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100);
                      });

                }else{
                return ListView.builder(
                    itemCount:snapshot.data!.length,
                    itemBuilder: (context,index){
                      String name = snapshot.data![index]['country'];
                      if(searchcontroll.text.isEmpty){
                        return
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Detailscreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name:snapshot.data![index]['country'] ,
                                        totalCases: snapshot.data![index]['cases'] ,
                                        totalDeaths: snapshot.data![index]['deaths'] ,
                                        totalRecover: snapshot.data![index]['recovered'] ,
                                        active: snapshot.data![index]['active'] ,
                                        todayRecover: snapshot.data![index]['todayRecovered'] ,
                                        test: snapshot.data![index]['tests'] ,
                                        critical: snapshot.data![index]['critical'] ,
                                    );
                                  }));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                      }
                      else if(name.toLowerCase().contains(searchcontroll.text.toLowerCase())){
                        return
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Detailscreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name:snapshot.data![index]['country'] ,
                                      totalCases: snapshot.data![index]['cases'] ,
                                      totalDeaths: snapshot.data![index]['deaths'] ,
                                      totalRecover: snapshot.data![index]['recovered'] ,
                                      active: snapshot.data![index]['active'] ,
                                      todayRecover: snapshot.data![index]['todayRecovered'] ,
                                      test: snapshot.data![index]['tests'] ,
                                      critical: snapshot.data![index]['critical'] ,
                                    );
                                  }));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                      }else{
return Container();
                      }
                return
                  Column(
                children: [
ListTile(
  title: Text(snapshot.data![index]['country']),
  subtitle: Text(snapshot.data![index]['cases'].toString()),
  leading: Image(
    height: 50,
    width: 50,
    image: NetworkImage(
      snapshot.data![index]['countryInfo']['flag']
    ),
  ),
)
                ],
                );
                });

                }

              }),
            )
          ],
        ),
      ),
    );
  }
}