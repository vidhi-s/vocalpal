import 'package:flutter/material.dart';
import 'package:vocalpalette/pallete.dart';
import 'features.dart';
class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Adele'),
        leading: Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [Center(
              child: Container(
                height: 120.0,
                width: 120.0,
                margin: EdgeInsets.only(top: 4.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(209, 243, 249, 1),
                  shape: BoxShape.circle
                ),

              ),

            ),
              Container(
                height: 127.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/main.png')
                  )
                ),
              )
          ]),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            margin: EdgeInsets.symmetric(horizontal: 37.0,).copyWith(top: 20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(200, 200, 200, 1)
              ),
              borderRadius: BorderRadius.circular(20.0).copyWith(topLeft:Radius.zero)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'HEY THERE 🙋🏻 How can i help you today?',style: TextStyle(
                fontFamily: 'cera pro',
                color: Color.fromRGBO(19, 61, 95, 1),
                fontSize: 20.0

              ),
              ),
            ),
          ),Padding(
            padding: const EdgeInsets.all(10.0),

            child: Container(
              margin: EdgeInsets.only(top:15.0,left: 15.0),
              alignment: Alignment.centerLeft,
              child: Text('Here are features you can use:',style: TextStyle(
                  fontFamily: 'cera pro',
                  color: Color.fromRGBO(19, 61, 95, 1),
                  fontSize: 18.0,fontWeight: FontWeight.bold

              ),),
            ),
          ),
          Column(
            children: [
             features(Color.fromRGBO(165, 231, 244, 1), "ChatGpt","use it bhai easy peasy"),
              features(Color.fromRGBO(157, 202, 235, 1), "Dell-E","bhai kya kamal ki cheez hai"),
              features(Color.fromRGBO(162, 238, 239, 1), "Smart Voice Assistant", "Masti rukni nahi chahiye")
            ],
          ),

        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Color.fromRGBO(165, 231, 244, 1),
        child: Icon(Icons.mic),
      ),
    );
  }
}
