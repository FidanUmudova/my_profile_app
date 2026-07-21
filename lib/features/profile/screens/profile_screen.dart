import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'FuadEliyevFlutterDeveloper2026SuperLongUsername';
  String _userEmail = 'fuad.eliyev.flutter.mobile.developer@gmail.com';

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.textDark, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: AppColors.textDark, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 600 : double.infinity),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.primary,
                                  child: Icon(Icons.person, size: 45, color: Colors.white),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _userName,
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _userEmail,
                                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () async {
                                  final result = await context.push<Map<String, String>>(
                                    '/edit-profile',
                                    extra: {'currentName': _userName, 'currentEmail': _userEmail},
                                  );
                                  if (result != null) {
                                    setState(() {
                                      _userName = result['name'] ?? _userName;
                                      _userEmail = result['email'] ?? _userEmail;
                                    });
                                  }
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Edit Profile', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
                                      SizedBox(width: 4),
                                      Icon(Icons.edit_outlined, color: AppColors.primary, size: 16),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Stats Row
                      Row(
                        children: [
                          _buildStatCard(Icons.people_outline, Colors.deepPurple, '24', 'Projects'),
                          const SizedBox(width: 12),
                          _buildStatCard(Icons.favorite_border, Colors.deepPurple, '128', 'Likes'),
                          const SizedBox(width: 12),
                          _buildStatCard(Icons.star_border, Colors.amber, '7', 'Badges'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text('Menu', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      const SizedBox(height: 12),

                      // Menu Items
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            _buildMenuItem(Icons.assignment_outlined, 'My Activity', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.bookmark_outline, 'Saved Items', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.mark_email_unread_outlined, 'My Projects', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.mail_outline, 'Messages', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.notifications_none_outlined, 'Notifications', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.lock_outline, 'Privacy & Security', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.settings_outlined, 'Settings', () => context.push('/settings')),
                            _buildDivider(),
                            _buildMenuItem(Icons.help_outline, 'Help & Support', () {}),
                            _buildDivider(),
                            _buildMenuItem(Icons.info_outline, 'About App', () {}),
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
      bottomNavigationBar: _buildBottomNav(context, 4),
    );
  }

  Widget _buildStatCard(IconData icon, Color color, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.black87, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
    );
  }

  Widget _buildDivider() => const Divider(height: 1, thickness: 0.5, indent: 50, endIndent: 16);
}

// Bottom Navigation Bar Component
Widget _buildBottomNav(BuildContext context, int activeIndex) {
  return BottomNavigationBar(
    currentIndex: activeIndex,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: Colors.grey,
    onTap: (index) {
      if (index == 0) context.go('/');
      if (index == 4) context.go('/profile');
    },
    items: [
      const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          child: const Icon(Icons.add, color: Colors.white, size: 20),
        ),
        label: 'Add',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ],
  );
}