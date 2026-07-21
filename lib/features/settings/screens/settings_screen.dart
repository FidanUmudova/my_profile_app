import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 500 : double.infinity),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('PREFERENCES', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            SwitchListTile(
                              title: const Text('Push Notifications'),
                              secondary: const Icon(Icons.notifications_none, color: AppColors.primary),
                              value: _pushNotifications,
                              activeColor: AppColors.primary,
                              onChanged: (v) => setState(() => _pushNotifications = v),
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('Email Notifications'),
                              secondary: const Icon(Icons.mail_outline, color: AppColors.primary),
                              value: _emailNotifications,
                              activeColor: AppColors.primary,
                              onChanged: (v) => setState(() => _emailNotifications = v),
                            ),
                            const Divider(height: 1),
                            SwitchListTile(
                              title: const Text('Dark Mode'),
                              secondary: const Icon(Icons.dark_mode_outlined, color: AppColors.primary),
                              value: _darkMode,
                              activeColor: AppColors.primary,
                              onChanged: (v) => setState(() => _darkMode = v),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.language, color: AppColors.primary),
                              title: const Text('Language'),
                              trailing: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('English', style: TextStyle(color: Colors.grey)),
                                  Icon(Icons.chevron_right, color: Colors.grey),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text('ACCOUNT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            _buildSettingsTile(Icons.lock_outline, 'Privacy'),
                            const Divider(height: 1),
                            _buildSettingsTile(Icons.shield_outlined, 'Security'),
                            const Divider(height: 1),
                            _buildSettingsTile(Icons.block_outlined, 'Blocked Users'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text('MORE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            _buildSettingsTile(Icons.help_outline, 'Help & Support'),
                            const Divider(height: 1),
                            _buildSettingsTile(Icons.info_outline, 'About App'),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.logout, color: Colors.redAccent),
                              title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                              onTap: () => context.go('/'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}