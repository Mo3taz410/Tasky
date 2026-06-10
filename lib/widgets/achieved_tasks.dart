import 'dart:math';
import 'package:flutter/material.dart';

class AchievedTasks extends StatelessWidget {
  const AchievedTasks({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
  });
  final int completedTasks;
  final int totalTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '$completedTasks Out of $totalTasks Done',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xFF6D6D6D),
                    value: totalTasks == 0 ? 0 : completedTasks / totalTasks,
                    color: Color(0xFF15B86C),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                totalTasks == 0
                    ? '0%'
                    : '${(completedTasks / totalTasks * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
