import 'dart:math';

void main(List<String> args) {
  // Частина 1

  // Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

  String studentsStr =
      "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія - ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82";
  // Завдання 1
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – відсортований масив студентів, які відносяться до відповідної групи

  Map<String, List<String>> studentsGroups = Map();

  // Ваш код починається тут

  var element = studentsStr.split(";");
  for (var student in element) {
    var aboutStudent = student.split("-");
    String name = aboutStudent[0];
    String group = aboutStudent[1] + "-" + aboutStudent[2];
    if (studentsGroups.containsKey(group)) {
      studentsGroups[group].add(name);
    } else {
      studentsGroups[group] = [name];
    }
  }

  for (var groups in studentsGroups.keys) {
    studentsGroups[groups].sort();
  }
  // Ваш код закінчується тут

  print("Завдання 1");
  print(studentsGroups);
  print('\n');

  // Дано масив з максимально можливими оцінками

  List<int> marks = [12, 12, 12, 12, 12, 12, 12, 16];

  // Завдання 2
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – словник, де:
  //   - ключ – студент, який відносяться до відповідної групи
  //   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

  Map<String, Map<String, List<int>>> studentMarks = Map();

  // Ваш код починається тут
  for (var group in studentsGroups.keys) {
    Map<String, List<int>> marksStudent = Map();
    for (var student in studentsGroups[group]) {
      List<int> marksReal = List();
      for (int marksValue in marks) {
        marksReal.add(randomValue(marksValue));
      }
      marksStudent[student] = marksReal;
    }
    studentMarks[group] = marksStudent;
  }

  // Ваш код закінчується тут

  print("Завдання 2");
  print(studentMarks);
  print('\n');

  // Завдання 3
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – словник, де:
  //   - ключ – студент, який відносяться до відповідної групи
  //   - значення – сума оцінок студента

  Map<String, Map<String, int>> sumMarks = Map();

  // Ваш код починається тут

  for (var group in studentMarks.keys) {
    Map<String, int> studentSum = Map();
    for (var student in studentMarks[group].keys) {
      studentSum[student] =
          studentMarks[group][student].reduce((a, b) => a + b);
    }
    sumMarks[group] = studentSum;
  }

  // Ваш код закінчується тут

  print("Завдання 3");
  print(sumMarks);
  print('\n');

  // Завдання 4
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – середня оцінка всіх студентів групи

  Map<String, double> groupAvg = Map();

  // Ваш код починається тут

  for (var group in sumMarks.keys) {
    var avg = 0;
    var i = 0;
    for (var student in sumMarks[group].keys) {
      i++;
      avg += sumMarks[group][student];
    }
    groupAvg[group] = avg / i;
  }
  // Ваш код закінчується тут

  print("Завдання 4");
  print(groupAvg);
  print('\n');

  // Завдання 5
  // Заповніть словник, де:
  // - ключ – назва групи
  // - значення – масив студентів, які мають >= 60 балів

  Map<String, List<String>> passedPerGroup = Map();

  // Ваш код починається тут

  for (var group in sumMarks.keys) {
    List<String> goodStudents = List();
    for (var student in sumMarks[group].keys) {
      if (sumMarks[group][student] >= 60) {
        goodStudents.add(student);
      }
    }
    passedPerGroup[group] = goodStudents;
  }

  // Ваш код закінчується тут
  print("Завдання 5");
  print(passedPerGroup);
  print('\n');

  // Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
  //
  //Завдання 1
  //["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
  //
  //Завдання 2
  //["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
  //
  //Завдання 3
  //["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
  //
  //Завдання 4
  //["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
  //
  //Завдання 5
  //["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]
  TimeMS a = TimeMS.initial();
  TimeMS b = TimeMS(10, 59, 0, Date.AM);
  TimeMS c = TimeMS(13, 59, 30);
  TimeMS d = TimeMS(14, 26, 35);
  print(a);
  print(b);
  print(c);
  print(TimeMS.sum_st(d, c));
  print(TimeMS.minus_st(a, d));
  print(c.sum(d));
  print(c.minus(d));
}

var randomer = Random();

int randomValue(int maxValue) {
  switch (randomer.nextInt(6)) {
    case 1:
      return (maxValue * 0.7).ceil();
    case 2:
      return (maxValue * 0.9).ceil();
    case 3:
    case 4:
    case 5:
      return maxValue;
    default:
      return 0;
  }
}

enum Date { PM, AM }

class TimeMS {
  int hour;
  int minutes;
  int seconds;
  Date dat;
  TimeMS(this.hour, this.minutes, this.seconds, [this.dat]) {
    if (this.dat != null) {
      assert(0 <= hour && hour <= 12);
    } else {
      assert(0 <= hour && hour <= 23);
    }

    assert(0 <= minutes && minutes <= 59, 'bugs: $minutes');
    assert(0 <= seconds && seconds <= 59);
  }
  TimeMS.initial() : this(0, 0, 0);
  @override
  String toString() {
    if (this.dat != null) {
      return "hour:$hour, minutes: $minutes, seconds:$seconds, $dat";
    } else {
      return "hour:$hour, minutes: $minutes, seconds:$seconds";
    }
  }

  TimeMS sum(TimeMS object) {
    this.hour = this.hour + object.hour;
    this.minutes = this.minutes + object.minutes;
    this.seconds = this.seconds + object.seconds;
    if (this.seconds > 59) {
      this.seconds = this.seconds - 60;
      this.minutes += 1;
    }
    if (this.minutes > 59) {
      this.minutes = this.minutes - 60;
      this.hour += 1;
    }
    if (this.hour > 23) {
      this.hour = this.hour - 24;
    }
    TimeMS result = TimeMS(this.hour, this.minutes, this.seconds);
    return result;
  }

  static TimeMS sum_st(TimeMS object, TimeMS object2) {
    var hour = object.hour + object2.hour;
    var minutes = object.minutes + object2.minutes;
    var seconds = object.seconds + object2.seconds;
    if (seconds > 59) {
      seconds = seconds - 60;
      minutes += 1;
    }
    if (minutes > 59) {
      minutes = minutes - 60;
      hour += 1;
    }
    if (hour > 23) {
      hour = hour - 24;
    }
    TimeMS result = TimeMS(hour, minutes, seconds);
    return result;
  }

  TimeMS minus(TimeMS object) {
    this.hour = this.hour - object.hour;
    this.minutes = this.minutes - object.minutes;
    this.seconds = this.seconds - object.seconds;
    if (this.seconds < 0) {
      this.seconds = 60 + this.seconds;
      this.minutes -= 1;
    }
    if (this.minutes < 0) {
      this.minutes = 60 + this.minutes;
      this.hour -= 1;
    }
    if (this.hour < 0) {
      this.hour = 24 + this.hour;
    }
    TimeMS result = TimeMS(this.hour, this.minutes, this.seconds);
    return result;
  }

  static TimeMS minus_st(TimeMS object, TimeMS object2) {
    var hour = object.hour - object2.hour;
    var minutes = object.minutes - object2.minutes;
    var seconds = object.seconds - object2.seconds;
    if (seconds < 0) {
      seconds = 60 + seconds;
      minutes -= 1;
    }
    if (minutes < 0) {
      minutes = 60 + minutes;
      hour -= 1;
    }
    if (hour < 0) {
      hour = 24 + hour;
    }
    TimeMS result = TimeMS(hour, minutes, seconds);
    return result;
  }
}
