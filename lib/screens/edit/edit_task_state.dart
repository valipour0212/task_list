part of 'edit_task_cubit.dart';

@immutable
abstract class EditTaskState {
  final TaskEntity taskEntity;

  EditTaskState(this.taskEntity);
}

class EditTaskInitial extends EditTaskState {
  EditTaskInitial(TaskEntity taskEntity) : super(taskEntity);
}

class EditTaskPriorityChange extends EditTaskState {
  EditTaskPriorityChange(TaskEntity taskEntity) : super(taskEntity);
}
