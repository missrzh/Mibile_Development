main(List<String> args) {
  print(TimeMS(1, 5, 4).hower);
}

class TimeMS {
  int hower;
  int minutes;
  int seconds;
  TimeMS(this.hower, this.minutes, this.seconds);
  TimeMS.initial() : this(0, 0, 0);
  @override
  String toString() {
    return super.toString();
  }
}
