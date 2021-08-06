import 'package:flutter/material.dart';

class PillBadge extends StatelessWidget {
  final Widget? icon;
  final String label;
  final String value;

  PillBadge({
    Key? key,
    this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
      ),
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) icon!,
              SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 11,
                    ),
              ),
            ],
          ),
          VerticalDivider(color: Colors.black54),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 11,
                ),
          )
        ],
      ),
    );
  }
}
