import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/models/work_log.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/storage_service.dart';

// Events
abstract class WorkTrackingEvent extends Equatable {
  const WorkTrackingEvent();

  @override
  List<Object?> get props => [];
}

class WorkStatusRequested extends WorkTrackingEvent {}

class WorkLogsRequested extends WorkTrackingEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const WorkLogsRequested({this.startDate, this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}

class CheckInRequested extends WorkTrackingEvent {}

class CheckOutRequested extends WorkTrackingEvent {}

// States
abstract class WorkTrackingState extends Equatable {
  const WorkTrackingState();

  @override
  List<Object?> get props => [];
}

class WorkTrackingInitial extends WorkTrackingState {}

class WorkTrackingLoading extends WorkTrackingState {}

class WorkTrackingLoaded extends WorkTrackingState {
  final WorkStatus workStatus;
  final List<WorkLog> workLogs;

  const WorkTrackingLoaded({
    required this.workStatus,
    required this.workLogs,
  });

  @override
  List<Object> get props => [workStatus, workLogs];
}

class WorkTrackingError extends WorkTrackingState {
  final String message;

  const WorkTrackingError({required this.message});

  @override
  List<Object> get props => [message];
}

class WorkTrackingActionInProgress extends WorkTrackingState {
  final String action;

  const WorkTrackingActionInProgress({required this.action});

  @override
  List<Object> get props => [action];
}

class WorkTrackingActionSuccess extends WorkTrackingState {
  final String message;
  final WorkLog workLog;

  const WorkTrackingActionSuccess({
    required this.message,
    required this.workLog,
  });

  @override
  List<Object> get props => [message, workLog];
}

// Bloc
class WorkTrackingBloc extends Bloc<WorkTrackingEvent, WorkTrackingState> {
  final ApiService apiService;
  final LocationService locationService;
  
  WorkStatus? _currentStatus;
  List<WorkLog> _workLogs = [];

  WorkTrackingBloc({
    required this.apiService,
    required this.locationService,
  }) : super(WorkTrackingInitial()) {
    on<WorkStatusRequested>(_onWorkStatusRequested);
    on<WorkLogsRequested>(_onWorkLogsRequested);
    on<CheckInRequested>(_onCheckInRequested);
    on<CheckOutRequested>(_onCheckOutRequested);
  }

  Future<void> _onWorkStatusRequested(
    WorkStatusRequested event,
    Emitter<WorkTrackingState> emit,
  ) async {
    try {
      // Get token from storage - you'll need to pass this or access it via context
      final token = await _getToken();
      if (token == null) {
        emit(const WorkTrackingError(message: 'Not authenticated'));
        return;
      }

      final status = await apiService.getWorkStatus(token);
      _currentStatus = status;
      
      emit(WorkTrackingLoaded(
        workStatus: status,
        workLogs: _workLogs,
      ));
    } catch (e) {
      emit(WorkTrackingError(message: e.toString()));
    }
  }

  Future<void> _onWorkLogsRequested(
    WorkLogsRequested event,
    Emitter<WorkTrackingState> emit,
  ) async {
    try {
      final token = await _getToken();
      if (token == null) {
        emit(const WorkTrackingError(message: 'Not authenticated'));
        return;
      }

      final logs = await apiService.getWorkLogs(
        token,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      _workLogs = logs;
      
      if (_currentStatus != null) {
        emit(WorkTrackingLoaded(
          workStatus: _currentStatus!,
          workLogs: logs,
        ));
      }
    } catch (e) {
      emit(WorkTrackingError(message: e.toString()));
    }
  }

  Future<void> _onCheckInRequested(
    CheckInRequested event,
    Emitter<WorkTrackingState> emit,
  ) async {
    emit(const WorkTrackingActionInProgress(action: 'Checking in...'));
    
    try {
      final token = await _getToken();
      if (token == null) {
        emit(const WorkTrackingError(message: 'Not authenticated'));
        return;
      }

      // Get current location
      final position = await locationService.getCurrentPosition();
      final locationName = await locationService.getLocationName(
        position.latitude,
        position.longitude,
      );

      final checkInRequest = CheckInRequest(
        latitude: position.latitude,
        longitude: position.longitude,
        locationName: locationName,
      );

      final workLog = await apiService.checkIn(token, checkInRequest);
      
      emit(WorkTrackingActionSuccess(
        message: 'Checked in successfully',
        workLog: workLog,
      ));
      
      // Refresh status and logs
      add(WorkStatusRequested());
      add(WorkLogsRequested());
      
    } catch (e) {
      emit(WorkTrackingError(message: e.toString()));
    }
  }

  Future<void> _onCheckOutRequested(
    CheckOutRequested event,
    Emitter<WorkTrackingState> emit,
  ) async {
    emit(const WorkTrackingActionInProgress(action: 'Checking out...'));
    
    try {
      final token = await _getToken();
      if (token == null) {
        emit(const WorkTrackingError(message: 'Not authenticated'));
        return;
      }

      // Get current location
      final position = await locationService.getCurrentPosition();
      final locationName = await locationService.getLocationName(
        position.latitude,
        position.longitude,
      );

      final checkOutRequest = CheckInRequest(
        latitude: position.latitude,
        longitude: position.longitude,
        locationName: locationName,
      );

      final workLog = await apiService.checkOut(token, checkOutRequest);
      
      emit(WorkTrackingActionSuccess(
        message: 'Checked out successfully',
        workLog: workLog,
      ));
      
      // Refresh status and logs
      add(WorkStatusRequested());
      add(WorkLogsRequested());
      
    } catch (e) {
      emit(WorkTrackingError(message: e.toString()));
    }
  }

  Future<String?> _getToken() async {
    // This is a simplified implementation
    // In a real app, you'd inject StorageService or get it from context
    return null; // Will be properly implemented with dependency injection
  }
}