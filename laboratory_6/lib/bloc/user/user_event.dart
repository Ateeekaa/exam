part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends UserEvent {}

class UpdateUserProfile extends UserEvent {
  final UserProfile profile;

  const UpdateUserProfile(this.profile);

  @override
  List<Object> get props => [profile];
}

class UpdateThemePreference extends UserEvent {
  final bool isDarkMode;

  const UpdateThemePreference(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

class UpdateLanguagePreference extends UserEvent {
  final String languageCode;

  const UpdateLanguagePreference(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
