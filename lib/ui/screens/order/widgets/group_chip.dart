import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/=models=/group.dart';
import 'package:testtask/ui/screens/order/screen_logic/order_provider.dart';

class GroupChip extends StatelessWidget {
  final Group group;

  const GroupChip({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final isSelected = context.select<OrderProvider, bool>((pr) {
      final selectedGroup = pr.selectedGroup;
      return (selectedGroup != null) && (group.id == selectedGroup.id);
    });

    return GestureDetector(
      onTap: () {
        context.read<OrderProvider>().selectGroup(group);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            group.name,
            style: TextStyle(fontSize: 16, color: isSelected ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }
}
