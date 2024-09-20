import 'package:flutter/material.dart';
import 'package:flutter_application/component/color/app_color.dart';
import 'package:flutter_application/component/spacing/app_spacing.dart';

class ItemTodo extends StatelessWidget {
  const ItemTodo({
    required this.title,
    required this.createdAt,
    this.isCompleted,
    this.onEdit,
    this.onDelete,
    this.onTab,
    this.onMarkAsCompleted,
    super.key,
  });

  final String title;
  final String createdAt;
  final bool? isCompleted;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTab;
  final VoidCallback? onMarkAsCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTab,
          child: Container(
            margin: const EdgeInsets.only(
              // left: AppSpacing.md,
              // right: AppSpacing.md,
              bottom: AppSpacing.xlg,
            ),
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacing.md),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.black,
                                    decoration: isCompleted!
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              createdAt,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Row(
                    children: [
                      FilledButton(
                        onPressed: onMarkAsCompleted,
                        style: FilledButton.styleFrom(
                          foregroundColor: AppColors.whiteColor,
                          backgroundColor: !isCompleted!
                              ? AppColors.greenColor
                              : AppColors.orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSpacing.sm),
                          ),
                        ),
                        child: Text(
                          isCompleted!
                              ? 'Mark as InCompleted'
                              : 'Mark as Completed',
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onEdit,
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.blueColor,
                        ),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.redColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
