import 'dart:io';

void main() {
  const String appTitle = "===== Student Grader v1.0 =====";
  List<Map<String, dynamic>> students = [];

  while (true) {
    print("\n$appTitle");
    print("1. Add Student");
    print("2. Record Score");
    print("3. Add Bonus Points");
    print("4. Add Comment");
    print("5. View All Students");
    print("6. View Report Card");
    print("7. Class Summary");
    print("8. Exit");

    stdout.write("Choose an option: ");
    int choice = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    switch (choice) {
      case 1:
        addStudent(students);
        break;
      case 2:
        recordScore(students);
        break;
      case 3:
        addBonus(students);
        break;
      case 4:
        addComment(students);
        break;
      case 5:
        viewAll(students);
        break;
      case 6:
        viewReportCard(students);
        break;
      case 7:
        classSummary(students);
        break;
      case 8:
        print("Goodbye!");
        return;
      default:
        print("Invalid option!");
    }
  }
}

void addStudent(List<Map<String, dynamic>> students) {
  stdout.write("Enter student name: ");
  String name = stdin.readLineSync() ?? "Unknown";

  students.add({
    "name": name,
    "scores": <int>[],
    "bonus": null,
    "comment": null
  });

  print("Student added successfully!");
}
void recordScore(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return print("No students found.");

  int index = selectStudent(students);
  if (index == -1) return;

  int score;
  while (true) {
    stdout.write("Enter score (0-100): ");
    score = int.tryParse(stdin.readLineSync() ?? "-1") ?? -1;
    if (score >= 0 && score <= 100) break;
    print("Invalid score!");
  }

  students[index]["scores"].add(score);
  print("Score added!");
}
void addBonus(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return print("No students found.");

  int index = selectStudent(students);
  if (index == -1) return;

  stdout.write("Enter bonus (1-10): ");
  int bonus = int.tryParse(stdin.readLineSync() ?? "0") ?? 0;

  students[index]["bonus"] ??= bonus;
  print("Bonus assigned!");
}

void addComment(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return print("No students found.");

  int index = selectStudent(students);
  if (index == -1) return;

  stdout.write("Enter comment: ");
  students[index]["comment"] = stdin.readLineSync();
  print("Comment added!");
}
