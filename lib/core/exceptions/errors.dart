// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;

  const AppError({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerError extends AppError {
  const ServerError({required String message}) : super(message: message);
}

class DisconnectedError extends AppError {
  const DisconnectedError() : super(message: 'Check your internet connection.');
}

class UnknownError extends AppError {
  const UnknownError({required String message}) : super(message: message);
}
