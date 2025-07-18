import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_log.g.dart';

@JsonSerializable()
class WorkLog extends Equatable {
  final int id;
  final int userId;
  final String type;
  final DateTime timestamp;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final DateTime createdAt;

  const WorkLog({
    required this.id,
    required this.userId,
    required this.type,
    required this.timestamp,
    this.latitude,
    this.longitude,
    this.locationName,
    required this.createdAt,
  });

  factory WorkLog.fromJson(Map<String, dynamic> json) => _$WorkLogFromJson(json);
  Map<String, dynamic> toJson() => _$WorkLogToJson(this);

  bool get isCheckIn => type == 'checkin';
  bool get isCheckOut => type == 'checkout';

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        timestamp,
        latitude,
        longitude,
        locationName,
        createdAt,
      ];
}

@JsonSerializable()
class CheckInRequest extends Equatable {
  final double latitude;
  final double longitude;
  final String locationName;

  const CheckInRequest({
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  factory CheckInRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckInRequestToJson(this);

  @override
  List<Object?> get props => [latitude, longitude, locationName];
}

@JsonSerializable()
class WorkStatus extends Equatable {
  final bool isWorking;
  final WorkLog? latestLog;
  final User user;

  const WorkStatus({
    required this.isWorking,
    this.latestLog,
    required this.user,
  });

  factory WorkStatus.fromJson(Map<String, dynamic> json) =>
      _$WorkStatusFromJson(json);
  Map<String, dynamic> toJson() => _$WorkStatusToJson(this);

  @override
  List<Object?> get props => [isWorking, latestLog, user];
}