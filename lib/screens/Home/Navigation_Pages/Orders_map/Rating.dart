import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/services/Database.dart';

import '../../../../models/User.dart';
class Rating extends StatefulWidget {
  String? code;
   Rating(this.code);

  @override
  State<Rating> createState() => _RatingState(code);
}
double rating = 4;
class _RatingState extends State<Rating> {
  String? code;
  _RatingState(this.code);

  @override
  Widget build(BuildContext context) {
    print(code);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: Text('Rate the Driver'),
      ),
      body: Container(
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('How was your overall experience of this delivery', style: TextStyle(color: Colors.black87, fontSize: 19),),
                ),
                SizedBox(height: 5), build_rating(),

            TextButton(onPressed: (){
              print(rating);

              Navigator.of(context).pop();
            }, child: Text('OK'))
              ]),
        ),
      )
    );
  }

  void show_Rating(context) => showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text('Rate your user'),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Text('How was your overall experience of the delivery', style: TextStyle(color: Colors.black87, fontSize: 19),),
              SizedBox(height: 5),
              build_rating(),
            ]),

        actions: [
          Center(child: TextButton(onPressed: () async{
            final user = Provider.of<UserFB?>(context, listen: false);
            print(rating);
            await DatabaseService(uid: user!.uid).updaterating(code!, rating);
            // Navigator.of(context).pop();
          }, child: Text('OK')))
        ],

      ));


  Widget build_rating() => RatingBar.builder(
    initialRating: rating,
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: 30,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rate) {
      setState(() => rating = rate);

      print(rating);
    },
  );
}
