import 'package:equatable/equatable.dart';

class RewardModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final int? points;
  final String? qrCode;

  const RewardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.points,
    required this.qrCode,
  });

  factory RewardModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return RewardModel(
      id: documentId,
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      points: map['points'],
      qrCode: map['qrCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'points': points,
      'qrCode': qrCode,
    };
  }

  @override
  List<Object?> get props => [id];

  RewardModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    int? points,
    String? qrCode,
  }) {
    return RewardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      points: points ?? this.points,
      qrCode: qrCode ?? this.qrCode,
    );
  }
}
