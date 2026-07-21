import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final TextEditingController _phoneController = TextEditingController(text: '+994 50 123 45 67');
  final TextEditingController _bioController = TextEditingController(
    text: 'Passionate Flutter developer who loves building beautiful and functional apps.',
  );

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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
        title: const Text('Edit Profile', style: TextStyle(color: AppColors.textDark, fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              context.pop({
                'name': _nameController.text,
                'email': _emailController.text,
              });
            },
            child: const Text('Save', style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
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
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundColor: AppColors.primary,
                              child: Icon(Icons.person, size: 50, color: Colors.white),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildTextField(_nameController, 'Full Name', Icons.person_outline),
                      const SizedBox(height: 16),
                      _buildTextField(_emailController, 'Email', Icons.email_outlined),
                      const SizedBox(height: 16),
                      _buildTextField(_phoneController, 'Phone', Icons.phone_outlined),
                      const SizedBox(height: 16),
                      _buildTextField(_bioController, 'Bio', null, maxLines: 3),
                      const SizedBox(height: 24),

                      CustomButton(
                        text: 'Save Changes',
                        onPressed: () {
                          context.pop({
                            'name': _nameController.text,
                            'email': _emailController.text,
                          });
                        },
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

  Widget _buildTextField(TextEditingController controller, String label, IconData? icon, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}