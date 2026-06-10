enum TaskItemActions {
  edit(name: 'Edit'),
  delete(name: 'Delete');

  final String name;

  const TaskItemActions({required this.name});
}
