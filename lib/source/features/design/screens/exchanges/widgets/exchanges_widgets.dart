import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker/source/common/values/constants/app_assets.dart';
import 'package:steps_tracker/source/common/values/enums/enums.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';

class ExchangesWidget extends StatelessWidget {
  final ExchangeHistoryModel exchangeHistoryItem;

  const ExchangesWidget({
    super.key,
    required this.exchangeHistoryItem,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMMd().format(
      DateTime.parse(exchangeHistoryItem.date),
    );
    // final date = exchangeHistoryItem.date;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
      ),
      title: Padding(
        padding: const EdgeInsets.only(
          bottom: 6.0,
        ),
        child: Text(
          exchangeHistoryItem.title == ExchangeHistoryTitle.exchange.title
              ? exchangeHistoryItem.title
              : '${exchangeHistoryItem.points} points ${exchangeHistoryItem.title}',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).listTileTheme.textColor,
              ),
        ),
      ),
      subtitle: Text(
        date,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.grey,
            ),
      ),
      leading: CachedNetworkImage(
        imageUrl:
            exchangeHistoryItem.title == ExchangeHistoryTitle.exchange.title
                ? AppAssets.exchangesIcon
                : AppAssets.rewardsIcon,
        height: 50,
        width: 50,
      ),
    );
  }
}
