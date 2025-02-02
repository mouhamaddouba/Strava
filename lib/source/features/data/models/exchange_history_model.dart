import 'package:equatable/equatable.dart';

class ExchangeHistoryModel extends Equatable {
  final String id;
  final String title;
  final String date;
  final int points;

  const ExchangeHistoryModel({
    required this.id,
    required this.title,
    required this.date,
    required this.points,
  });

  factory ExchangeHistoryModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return ExchangeHistoryModel(
      id: documentId,
      title: map['title'] as String,
      date: map['date'] as String,
      points: map['points'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'points': points,
    };
  }

  @override
  List<Object?> get props => [id];
}
