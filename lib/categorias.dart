import 'package:flutter/material.dart';
import 'main.dart';


String urlNew;
class Categoria extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        backgroundColor: Colors.blueAccent,
      ),
      body:Padding(padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              buildRaisedButton("Sportes mundial ", "https://newsapi.org/v2/top-headlines?sources=bbc-sport&apiKey=4b08879ed3214681b0310a2f3af89048",context, Colors.green),

              Divider(),
              buildRaisedButton("Mundo Portugues","https://newsapi.org/v2/top-headlines?sources=google-news-br&apiKey=4b08879ed3214681b0310a2f3af89048",context, Colors.deepOrangeAccent),
              Divider(),
              buildRaisedButton("Valores/Bolsa","https://newsapi.org/v2/top-headlines?sources=info-money&apiKey=4b08879ed3214681b0310a2f3af89048",context, Colors.amber),

            ],

      ),
      ),

    );
  }



}
//CRIA BOTAO COM PARAMETROS PARA RECEER O LABEL DO BOTAO
//URL DA API
// CONTEXT PARA IR PARA OUTRA TELA
Widget buildRaisedButton(String _name, var url,BuildContext context, Color cor) {

  return Expanded(
    child: RaisedButton(
      child: Text(_name,
      style: TextStyle(
        fontSize: 25.0,
        color: Colors.white
      ),),
     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blueAccent),borderRadius: BorderRadius.circular(60.0)),
      color: cor,
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        urlNew = url;

          print(url);

      },
    ) ,
  );


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