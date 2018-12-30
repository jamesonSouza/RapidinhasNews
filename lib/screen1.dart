import 'package:flutter/material.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {


  final Notice notice;
  DetailPage(this.notice);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notice.title),
      ),
          body:

          Container(
        padding: EdgeInsets.all(1.0),
            child:
            Column(
              children: <Widget>[
                Image.network(notice.image, fit: BoxFit.fill,width: 440,),
                Divider(),
                Center(
                  child:
                    Text(notice.title,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
                ),
                Divider(),
                Center(
                  child:
                  Text(notice.description,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),)
                ),
                Divider(),
                Text("continue lendo em:", style: TextStyle(
                  fontSize: 15.0,

                ), ),
                Center(
                    child:
                        FlatButton(onPressed:() {
                          launch(notice.url);
                        }
                        ,child:
                    Text(notice.url,
                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.blue),)
                ),
                ),
              ],
            ),
    ),

    );
  }
  _launchURL(c) async {
    var url =await c;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}