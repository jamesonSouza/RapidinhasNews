import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:news_app/screen1.dart';
import 'package:news_app/categorias.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';



void main() async{
  runApp(MaterialApp(
    title: "Rapidinhas News",
    home: Categoria(),
    debugShowCheckedModeBanner: false,
    routes: <String, WidgetBuilder>{
    //  '/scren1': (BuildContext context)= new Screen1();

    },
  ));

}

const request="https://newsapi.org/v2/top-headlines?sources=google-news-br&apiKey=4b08879ed3214681b0310a2f3af89048";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  static final  MobileAdTargetingInfo targetingInfo =  MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: ['News', 'Notices'],
    birthday: new DateTime.now(),

  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd(){
    return new BannerAd(adUnitId:"ca-app-pub-9275202133724780/7740473627", size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event){
          print ("Banner event: $event");
        }
    );

  }
  @override
  void initState(){

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-9275202133724780~3062862014");
    _bannerAd = createBannerAd()..load()..show();
  }
  InterstitialAd createInterstitialAd(){
    return new InterstitialAd(
        adUnitId: "ca-app-pub-9275202133724780/2659537338",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event){
          print ("InterstitialAd event: $event");
        }
    );

  }

  Future<List<Notice>> _loadNews() async{

    var response = await http.get(urlNew);
    var  jsonData = json.decode(response.body);
    print(jsonData);
    List<Notice> notices =[];

    for(var n in jsonData["articles"]){
      Notice notice  = Notice(n["title"], n["description"],n["url"],n["publishedAt"], n["urlToImage"]);
      notices.add(notice);
    }
    print(notices.length);
    return notices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rapidinhas News"),
        actions: <Widget>[

          FlatButton(
            child: Text("Categorias",
            style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Categoria()),
              );
            },
          )
        ],
        centerTitle: true,
        elevation: 5.0,

      ),
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsets.fromLTRB(1.0, 0.0, 2.0,1.0),
        child: FutureBuilder(
            future: _loadNews(),
            builder: (context, snapshot) {
              if(snapshot.data==null){
                return new Dialog(
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                        borderRadius: new BorderRadius.circular(10.0)
                    ),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new CircularProgressIndicator(),
                        Divider(),
                        new Text("Loading",),
                      ],
                    ),

                    width: 300.0,
                    height: 200.0,
                  )


                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return new ListTile(
                      leading: Image.network(
                        snapshot.data[index].image,
                        fit: BoxFit.cover,
                        width: 100.0,
                      ),
                      title: new Text(snapshot.data[index].title,
                        style: TextStyle(
                          fontSize: 14.0,fontWeight: FontWeight.bold,
                        ),),
                      subtitle: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          Divider(),
                          new Text(snapshot.data[index].publishedAt.toString() ,
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal,
                            ),),
                        ],
                      ),
                      onTap: (){
                        createInterstitialAd()..load()..show();
                        Navigator.push(context,
                            new MaterialPageRoute(
                                builder: (context)=> DetailPage(snapshot.data[index]))
                        );
                      },
                    );
                  },
                );

              }
            }
        ),
      )

    );
  }
}

class Notice{
//  final int index;
  final String title;
  final String description;
  final String url;
  final String publishedAt;
  final String image;


  Notice(this.title,this.description, this.url,this.publishedAt, this.image);

}
