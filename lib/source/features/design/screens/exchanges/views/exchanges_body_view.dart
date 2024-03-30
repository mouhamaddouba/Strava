import 'package:flutter/material.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/features/data/models/exchange_history_model.dart';
import 'package:steps_tracker/source/features/design/screens/exchanges/widgets/exchanges_widgets.dart';

class ExchangeBodyView extends StatelessWidget {
  final bool isLoading;
  final List<ExchangeHistoryModel>? exchanges;

  const ExchangeBodyView({
    super.key,
    this.isLoading = false,
    this.exchanges,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return exchanges != null && exchanges!.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: exchanges!
                    .map(
                      (e) => Column(
                        children: [
                          ExchangesWidget(
                            exchangeHistoryItem: e,
                          ),
                          const Divider(),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          )

        // if exchange empty
        : Center(
            child: Text(
              S.of(context).emptyState,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          );
  }
}
