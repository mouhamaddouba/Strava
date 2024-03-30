import 'package:flutter/material.dart';

class PointsCardWidgets extends StatelessWidget {
  final Color color;
  final String mainTitle;
  final IconData iconData;
  final String number;
  final String unit;

  const PointsCardWidgets({
    super.key,
    this.color = Colors.blue,
    required this.mainTitle,
    required this.iconData,
    this.number = '-',
    this.unit = '',
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  iconData,
                  size: 26,
                ),

                // Space
                const SizedBox(
                  width: 8.0,
                ),

                // value
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: number.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                      ),
                      if (unit.isNotEmpty)
                        TextSpan(
                          text: ' $unit',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                        ),
                    ],
                  ),
                )
              ],
            ),

            // Space
            const SizedBox(
              height: 8.0,
            ),

            // Title Card
            Text(
              mainTitle,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
