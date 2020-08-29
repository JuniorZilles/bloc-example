import 'dart:async';

class HomePageBloc {
  int counter = 0;

  final StreamController _streamController = StreamController();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  void incrementCounter() {
    counter++;
    input.add(counter);
  }
}
