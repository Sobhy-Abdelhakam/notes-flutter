abstract class AppStates{}

class InitState extends AppStates{}

class BottomNavChangeState extends AppStates{}

class CreateDatabaseState extends AppStates{}

class InsertIntoTaskTableState extends AppStates{}
class TaskLoadingState extends AppStates{}
class GetTasksFromDatabaseState extends AppStates{}

class InsertIntoNoteTableState extends AppStates {}
class NoteLoadingState extends AppStates {}
class GetNotesFromDatabaseState extends AppStates {}
class DeleteNoteState extends AppStates {}

class ChangeBottomSheetState extends AppStates{}