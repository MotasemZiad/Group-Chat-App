import 'package:flutter/material.dart';
import 'package:gsg_firebase/utils/constants.dart';

class ItemWidget extends StatelessWidget {
  final String label;
  final String value;

  ItemWidget({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingAll),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value ?? 'Not found',
          ),
        ],
      ),
    );
  }
}
