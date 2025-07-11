protocol TodoItemCallback {
    func onDelete(task: TaskModel)
    func onClicked(task: TaskModel)
}
