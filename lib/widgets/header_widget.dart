import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "assets/img/logo.png",
          width: 30,
          height: 30,
        ),
        SizedBox(
          width: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Kodein',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(
              width: 2,
            ),
            Text('Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                )),
          ],
        ),
      ],
    );
  }
}
