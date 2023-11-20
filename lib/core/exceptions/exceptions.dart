// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  final String message;

  const AppException({required this.message});

  @override
  List<Object> get props => [message];
}

class DisconnectedException extends AppException {
  const DisconnectedException() : super(message: 'Check your internet connection.');
}

class ServerException extends AppException {
  const ServerException({required String message}) : super(message: message);
}

class UnknownException extends AppException {
  const UnknownException({required String message}) : super(message: message);
}

class EmptyCacheException extends AppException {
  const EmptyCacheException() : super(message: 'App Cache files not found.');
}
