import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laboratory_6/data/repositories/user_repository.dart';
import 'package:laboratory_6/model/user_profile.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UpdateThemePreference>(_onUpdateThemePreference);
    on<UpdateLanguagePreference>(_onUpdateLanguagePreference);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final profile = await _userRepository.getUserProfile();
      final isDarkMode = await _userRepository.getThemePreference();
      final languageCode = await _userRepository.getLanguagePreference();
      emit(UserLoadSuccess(
        profile: profile,
        isDarkMode: isDarkMode,
        languageCode: languageCode,
      ));
    } catch (e) {
      emit(UserLoadFailure(e.toString()));
    }
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<UserState> emit,
  ) async {
    try {
      await _userRepository.updateUserProfile(event.profile);
      emit(UserLoadSuccess(
        profile: event.profile,
        isDarkMode: (state as UserLoadSuccess).isDarkMode,
        languageCode: (state as UserLoadSuccess).languageCode,
      ));
    } catch (e) {
      emit(UserLoadFailure(e.toString()));
    }
  }

  Future<void> _onUpdateThemePreference(
    UpdateThemePreference event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoadSuccess) {
      final currentState = state as UserLoadSuccess;
      try {
        await _userRepository.saveThemePreference(event.isDarkMode);
        emit(UserLoadSuccess(
          profile: currentState.profile,
          isDarkMode: event.isDarkMode,
          languageCode: currentState.languageCode,
        ));
      } catch (e) {
        emit(UserLoadFailure(e.toString()));
      }
    }
  }

  Future<void> _onUpdateLanguagePreference(
    UpdateLanguagePreference event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoadSuccess) {
      final currentState = state as UserLoadSuccess;
      try {
        await _userRepository.saveLanguagePreference(event.languageCode);
        emit(UserLoadSuccess(
          profile: currentState.profile,
          isDarkMode: currentState.isDarkMode,
          languageCode: event.languageCode,
        ));
      } catch (e) {
        emit(UserLoadFailure(e.toString()));
      }
    }
  }
}
