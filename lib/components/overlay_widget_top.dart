import 'package:flutter/material.dart';

class OverlayWidgetTop extends StatelessWidget {
  const OverlayWidgetTop({
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        color: Colors.blue,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Icon(
                    Icons.circle,
                    size: 15,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '2.4 Km',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 9),
                  height: 80,
                  width: 1,
                  color: Colors.black,
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 300,
                  child: Text(
                    'Hafeezpet-1609, Rd Number 15, Krishna Nagar Colony, Aditya Nagas Hafeerpet',
                    maxLines: 2,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_pin,
                  size: 20,
                ),
                SizedBox(width: 12),
                Text(
                  '2.4 Km',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 300,
              child: Text(
                'Hafeezpet-1609, Rd Number 15, Krishna Nagar Colony, Aditya Nagas Hafeerpet',
                maxLines: 2,
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: onCancelPressed,
                  icon: Icon(
                    Icons.cancel_outlined,
                    size: 50,
                  ),
                ),
                ElevatedButton(
                  onPressed: onAcceptPressed,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.yellow),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
                    minimumSize: WidgetStateProperty.all<Size>(
                      Size(200, 50),
                      // Size(MediaQuery.of(context).size.width - 100, 50),
                    ), // Width and height
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
