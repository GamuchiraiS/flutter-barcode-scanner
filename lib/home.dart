/* Imports */
import 'constants.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /* Takes two rows as children and centers them */
    return Column(
      /* centers text vertically*/
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
      Row(
        /* centers text horizontally*/
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Barcode',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: bigText,
              color: textColour,
            )
          )
        ],
      ),
      Row(
        /* centers text horizontally*/
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Scanner',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: bigText,
                color: textColour,
              )
          )
        ],
      )
    ]);
  }
}
