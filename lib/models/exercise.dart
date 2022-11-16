import 'package:equatable/equatable.dart';

class Excercise extends Equatable {
  Excercise({
    required this.title,
    required this.prelude,
    required this.duration,
    this.index,
    this.startTime,
  });

  final String? title;
  final int? prelude;
  final int? duration;
  final int? index;
  final int? startTime;

  factory Excercise.fromJson(
          Map<String, dynamic> json, int index, int startTime) =>
      Excercise(
          title: json["title"],
          prelude: json["prelude"],
          duration: json["duration"],
          index: index,
          startTime: startTime);

  Map<String, dynamic> toJson() => {
        "title": title,
        "prelude": prelude,
        "duration": duration,
      };

  Excercise copyWith({
    int? prelude,
    String? title,
    int? duration,
    int? index,
    int? startTime,
  }) =>
      Excercise(
          title: title ?? this.title,
          prelude: prelude ?? this.prelude,
          duration: duration ?? this.duration,
          index: index ?? this.index,
          startTime: startTime ?? this.startTime);

  @override
  List<Object?> get props => [title, prelude, duration, index, startTime];
}
