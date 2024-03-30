import 'package:flutter/material.dart';
import 'package:steps_tracker/source/common/translations/l10n.dart';
import 'package:steps_tracker/source/features/data/models/user_model.dart';
import 'package:steps_tracker/source/features/design/screens/board/widgets/board_user_rank_widget.dart';
import 'package:steps_tracker/source/features/design/screens/board/widgets/board_top_user_widget.dart';

class BoardBodyView extends StatelessWidget {
  final bool isLoading;
  final List<UserModel>? users;

  const BoardBodyView({
    super.key,
    this.isLoading = false,
    this.users,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (users == null || users!.isEmpty) {
      return Center(
        child: Text(S.of(context).emptyState),
      );
    }

    List<UserModel> leftUsers = users!.length > 3 ? users!.sublist(3) : [];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // The leader 2 & 3
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (users!.length >= 2)
                        BoardTopUserWidget(
                          sNumber: 2,
                          item: users![1],
                        ),
                      if (users!.length >= 3)
                        BoardTopUserWidget(
                          sNumber: 3,
                          item: users![2],
                        ),
                    ],
                  ),
                ),

                // The leader 1
                BoardTopUserWidget(
                  sNumber: 1,
                  first: true,
                  item: users![0],
                ),
              ],
            ),

            // space
            const SizedBox(
              height: 32.0,
            ),

            // Divider
            const Divider(),

            // List user than >3
            Column(
              children: List.generate(
                leftUsers.length,
                (index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: BoardUserRankWidget(
                          sNumber: index + 4,
                          item: leftUsers[index],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
