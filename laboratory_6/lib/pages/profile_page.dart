import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laboratory_6/bloc/auth/auth_bloc.dart';
import 'package:laboratory_6/bloc/user/user_bloc.dart';
import 'package:laboratory_6/model/user_profile.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadSuccess) {
            return _buildProfileContent(context, state);
          } else if (state is UserLoadFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('error_loading_profile'.tr()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(LoadUserProfile());
                    },
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserLoadSuccess state) {
    final profile = state.profile;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                _buildProfileImage(profile),
                const SizedBox(height: 16),
                Text(
                  profile.displayName ?? profile.email,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (profile.displayName != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingsSection(context, state),
          const SizedBox(height: 32),
          _buildPreferencesSection(context, state),
        ],
      ),
    );
  }

  Widget _buildProfileImage(UserProfile profile) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: profile.photoUrl != null
              ? NetworkImage(profile.photoUrl!)
              : null,
          child: profile.photoUrl == null
              ? Text(
                  (profile.displayName ?? profile.email)[0].toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                )
              : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.edit,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(BuildContext context, UserLoadSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text('edit_profile'.tr()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to edit profile page
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: Text('notifications'.tr()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to notifications settings
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.security_outlined),
                title: Text('privacy_security'.tr()),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to privacy settings
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(BuildContext context, UserLoadSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'preferences'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                secondary: Icon(
                  state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                title: Text('dark_mode'.tr()),
                value: state.isDarkMode,
                onChanged: (value) {
                  context
                      .read<UserBloc>()
                      .add(UpdateThemePreference(value));
                },
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text('language'.tr()),
                trailing: DropdownButton<String>(
                  value: state.languageCode,
                  items: [
                    DropdownMenuItem(
                      value: 'kk',
                      child: Text('kazakh'.tr()),
                    ),
                    DropdownMenuItem(
                      value: 'ru',
                      child: Text('russian'.tr()),
                    ),
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('english'.tr()),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      context
                          .read<UserBloc>()
                          .add(UpdateLanguagePreference(value));
                      context.setLocale(Locale(value));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
