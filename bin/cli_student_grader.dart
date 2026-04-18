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
void viewAll(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return print("No students available.");

  for (var s in students) {
    String star = (s["bonus"] != null) ? "⭐" : "";
    print("${s["name"]} (${s["scores"].length} scores) $star");
  }
}

void viewReportCard(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return print("No students found.");

  int index = selectStudent(students);
  if (index == -1) return;

  var s = students[index];
  List scores = s["scores"];

  if (scores.isEmpty) return print("No scores available.");

  double avg =
      scores.reduce((a, b) => a + b) / scores.length +
      (s["bonus"] ?? 0);

  String grade;
  if (avg >= 90) {
    grade = "A";
  } else if (avg >= 80) {
    grade = "B";
  } else if (avg >= 70) {
    grade = "C";
  } else if (avg >= 60) {
    grade = "D";
  } else {
    grade = "F";
  }

  print("\n===== REPORT CARD =====");
  print("Name: ${s["name"]}");
  print("Scores: $scores");
  print("Bonus: ${s["bonus"] ?? 0}");
  print("Average: ${avg.toStringAsFixed(2)}");
  print("Grade: $grade");
  print("Comment: ${s["comment"] ?? "No comment"}");
}
void classSummary(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return print("No data available.");

  double total = 0;
  int count = 0;
  double highest = 0;
  double lowest = 100;

  for (var s in students) {
    List scores = s["scores"];
    if (scores.isEmpty) continue;

    double avg = scores.reduce((a, b) => a + b) / scores.length;

    total += avg;
    count++;

    if (avg > highest) highest = avg;
    if (avg < lowest) lowest = avg;
  }

  if (count == 0) return print("No scores recorded.");

  print("\n===== CLASS SUMMARY =====");
  print("Students: ${students.length}");
  print("Class Average: ${(total / count).toStringAsFixed(2)}");
  print("Highest: $highest");
  print("Lowest: $lowest");
}

int selectStudent(List students) {
  for (int i = 0; i < students.length; i++) {
    print("$i. ${students[i]["name"]}");
  }

  stdout.write("Select student index: ");
  int index = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (index < 0 || index >= students.length) {
    print("Invalid student selected.");
    return -1;
  }

  return index;
}