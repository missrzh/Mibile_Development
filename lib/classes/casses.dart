main(List<String> args) {
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
