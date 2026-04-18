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
      case 8:
        print("Goodbye!");
        return;
      default:
        print("Feature not implemented yet.");
    }
  }
}