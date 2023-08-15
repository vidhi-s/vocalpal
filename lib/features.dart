import 'package:flutter/material.dart';

class features extends StatelessWidget {
  final Color color;
  String header;
  String contain;
   features(this.color,this.header,this.contain);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.0,vertical: 10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
         vertical: 20.0
        ).copyWith(left: 15.0,right: 3.0),
        child: Column(
          children: [
            Align(alignment: Alignment.centerLeft,
              child: Text(header,style: TextStyle(
                fontFamily: 'cera pro',
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(
              height: 4.0,
            ),
            Align(alignment: Alignment.centerLeft,
              child: Text(contain,style: TextStyle(
                  fontFamily: 'cera pro',
                  color: Colors.black,

              ),),
            )
          ],
        ),
      ),
    );
  }
}
