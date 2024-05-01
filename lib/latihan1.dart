import 'dart:convert';

void main() {
  String jsonString = '''
  {
    "nama": "Cinta Ruya",
    "npm": "1209760704",
    "program_studi": "Agroteknologi",
    "transkrip": [
      {
        "semester": 1,
        "mata_kuliah": [
          {"kode": "AU0110", "nama": "Pengenalan Pertanian", "sks": 3, "nilai": "A"},
          {"kode": "AU120", "nama": "Biokimia Tumbuhan", "sks": 3, "nilai": "B+"},
          {"kode": "AU130", "nama": "Kimia Pertanian", "sks": 2, "nilai": "A"}
        ]
      },
      {
        "semester": 2,
        "mata_kuliah": [
          {"kode": "AU210", "nama": "Genetika", "sks": 3, "nilai": "A-"},
          {"kode": "AU220", "nama": "Irigasi dan Drainase", "sks": 3, "nilai": "A"},
          {"kode": "AU230", "nama": "Ekonomi Pertanian", "sks": 2, "nilai": "B-"}
        ]
      },
      {
        "semester": 3,
        "mata_kuliah": [
          {"kode": "AU310", "nama": "Manajemen Agribisnis", "sks": 3, "nilai": "A"},
          {"kode": "AU320", "nama": "Fisiologi Tumbuhan", "sks": 3, "nilai": "A"},
          {"kode": "AU330", "nama": "TMekanisasi Pertanian", "sks": 2, "nilai": "B+"}
        ]
      }
    ]
  }
  ''';

  var data = jsonDecode(jsonString);
  calculateGPA(data);
}

void calculateGPA(Map<String, dynamic> data) {
  double totalPoints = 0;
  int totalCredits = 0;

  List<dynamic> semesters = data['transkrip'];
  for (var semester in semesters) {
    List<dynamic> courses = semester['mata_kuliah'];
    for (var course in courses) {
      int credits = course['sks'];
      double grade = gradeToPoint(course['nilai']);
      totalCredits += credits;
      totalPoints += grade * credits;
    }
  }

  double gpa = totalPoints / totalCredits;
  print(" Nilai IPK ${data['nama']} = ${gpa.toStringAsFixed(2)}");
}

double gradeToPoint(String grade) {
  switch (grade) {
    case 'A':
      return 4.0;
    case 'A-':
      return 3.7;
    case 'B+':
      return 3.3;
    case 'B':
      return 3.0;
    case 'B-':
      return 2.7;
    case 'C+':
      return 2.3;
    case 'C':
      return 2.0;
    case 'C-':
      return 1.7;
    case 'D':
      return 1.0;
    case 'E':
      return 0.0;
    default:
      return 0.0;
  }
}
