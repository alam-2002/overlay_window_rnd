import 'package:flutter/material.dart';

const kText18w400 = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
const kText14w400 = TextStyle(
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);
const kHeightGap10 = SizedBox(height: 10);
const kHeightGap20 = SizedBox(height: 20);
const kHeightGap30 = SizedBox(height: 30);

class OverlayWidgetBottom extends StatelessWidget {
  const OverlayWidgetBottom({
    super.key,
    required this.onCancelPressed,
    required this.onAcceptPressed,
  });

  final void Function() onCancelPressed;
  final void Function() onAcceptPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Moto',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5),
                    // shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: onCancelPressed,
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '₹53.85',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            kHeightGap20,
            Text(
              '*Include 5% tax',
              style: kText18w400,
            ),
            kHeightGap20,
            Text(
              '*4.90 cash payment',
              style: kText18w400,
            ),
            kHeightGap20,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Icon(
                      Icons.circle,
                      color: Colors.white,
                      size: 10,
                    ),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.square,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1 min (0.2km) away',
                      style: kText14w400,
                    ),
                    Text(
                      '1-110/3, Raghavendra Colony, 500084',
                      maxLines: 2,
                      style: kText14w400,
                    ),
                    Text(
                      '12 mins (5.6 km) trip',
                      maxLines: 2,
                      style: kText14w400,
                    ),
                    SizedBox(
                      height: 80,
                      width: 250,
                      child: Text(
                        'Plot No. 4/1, Survey No. 64, Huda Techno Enclave. Madhapur, HUDA Techno Enclave, HITEC City, 500082',
                        maxLines: 4,
                        style: kText14w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onAcceptPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                minimumSize: WidgetStateProperty.all<Size>(
                  Size(350, 50),
                  // Size(MediaQuery.of(context).size.width - 100, 50),
                ), // Width and height
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                ),
              ),
              child: Text(
                'Accept',
                style: kText18w400,
              ),
            ),
            kHeightGap10,
          ],
        ),
      ),
    );
  }
}
