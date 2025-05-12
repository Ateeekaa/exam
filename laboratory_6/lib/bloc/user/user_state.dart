part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoadSuccess extends UserState {
  final UserProfile profile;
  final bool isDarkMode;
  final String languageCode;

  const UserLoadSuccess({
    required this.profile,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  List<Object?> get props => [profile, isDarkMode, languageCode];
}

class UserLoadFailure extends UserState {
  final String error;

  const UserLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
