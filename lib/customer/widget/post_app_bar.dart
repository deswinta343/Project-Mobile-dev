import 'package:flutter/material.dart';

class PostAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row( 
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow :[
                BoxShadow(
                color: Colors.white,
                blurRadius: 6,
                ),
              ],
            ),
            child: Icon(Icons.arrow_back_ios,
            size: 28,),
          ),
        ),
      ],
      ),
    );
  }
}