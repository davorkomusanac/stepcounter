import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class StepsCounterScreenAppBar extends StatelessWidget {
  const StepsCounterScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                log('back button called, not implemented since there is only one screen currently');
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.darkBlue,
                size: 26,
              ),
            ),
            IconButton(
              onPressed: () {
                //TODO Implement disable/turn on notification
                //TODO change icon then based on notification
              },
              icon: const Icon(
                Icons.notifications_off_outlined,
                color: AppColors.darkBlue,
                size: 26,
              ),
            ),
          ],
        ),
      );
}
