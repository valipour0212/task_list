import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_list/data/data.dart';
import 'package:task_list/data/repo/repository.dart';
import 'package:task_list/main.dart';
import 'package:task_list/screens/edit/edit_task_cubit.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<EditTaskCubit>().state.taskEntity.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
        title: Text('Edit Task'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<EditTaskCubit>().onSaveChangesClick();
          Navigator.of(context).pop();
        },
        label: Row(
          children: [
            Text('Save Changes'),
            Icon(
              CupertinoIcons.check_mark,
              size: 18,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<EditTaskCubit, EditTaskState>(
              builder: (context, state) {
                final priority = state.taskEntity.priority;
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 1,
                      child: PriorityCheckBox(
                        label: 'High',
                        color: primaryColor,
                        isSelected: priority == Priority.high,
                        onTap: () {
                          context
                              .read<EditTaskCubit>()
                              .onPriorityChanged(Priority.high);
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: PriorityCheckBox(
                        label: 'Normal',
                        color: normalPriority,
                        isSelected: priority == Priority.normal,
                        onTap: () {
                          context
                              .read<EditTaskCubit>()
                              .onPriorityChanged(Priority.normal);
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: PriorityCheckBox(
                        label: 'Low',
                        color: lowPriority,
                        isSelected: priority == Priority.low,
                        onTap: () {
                          context
                              .read<EditTaskCubit>()
                              .onPriorityChanged(Priority.low);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            TextField(
              controller: _controller,
              onChanged: (value) {
                context.read<EditTaskCubit>().onTextChanged(value);
              },
              decoration: InputDecoration(
                label: Text(
                  'Add a task for today ... ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .apply(fontSizeFactor: 1.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityCheckBox extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final GestureTapCallback onTap;

  const PriorityCheckBox(
      {Key? key,
      required this.label,
      required this.color,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2,
            color: secondaryTextColor.withOpacity(0.2),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(label),
            ),
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: _CheckBoxShape(
                  value: isSelected,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBoxShape extends StatelessWidget {
  final bool value;
  final Color color;

  const _CheckBoxShape({Key? key, required this.value, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: value
          ? Icon(
              CupertinoIcons.check_mark,
              color: themeData.colorScheme.onPrimary,
              size: 12,
            )
          : null,
    );
  }
}
