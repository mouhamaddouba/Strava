import 'package:flutter/material.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/common/values/constants/app_color.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialGuageView extends StatelessWidget {
  final String steps;

  const RadialGuageView({
    this.steps = '0',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      title: GaugeTitle(
        text: S.of(context).totalStepsToday,
        textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
      axes: <RadialAxis>[
        RadialAxis(
          axisLineStyle: AxisLineStyle(
            color: Theme.of(context).primaryColorDark,
            dashArray: const <double>[8, 2],
          ),
          axisLabelStyle: GaugeTextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
          annotations: [
            GaugeAnnotation(
              widget: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$steps\n',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    TextSpan(
                      text: '${S.of(context).stepGoal}\n',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    TextSpan(
                      text: '8000\n',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          pointers: <GaugePointer>[
            RangePointer(
              value: ((double.tryParse(steps)!) / 80000) * 100,
              color: AppColors.kPrimaryColor,
              dashArray: const <double>[8, 2],
            ),
          ],
        ),
      ],
    );
  }
}
