import 'package:bite_rush/constants/colors.dart';
import 'package:bite_rush/constants/strings.dart'; // ✅ import AppStrings
import 'package:bite_rush/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _phoneController = TextEditingController();
  String _selectedCountryCode = '+237';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final safeAreaHeight =
        screenHeight - mediaQuery.padding.top - mediaQuery.padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          height: safeAreaHeight,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: safeAreaHeight * 0.05),

              /// Logo Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bite",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.neonGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Rush",
                      style: TextStyle(
                        color: AppColors.buttonTextOnNeon,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: safeAreaHeight * 0.02),

              /// Title Section
              Text(
                AppStrings.createAccount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),

              SizedBox(height: safeAreaHeight * 0.02),

              Text(
                AppStrings.signupDescription,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white70, fontSize: 14),
              ),

              SizedBox(height: safeAreaHeight * 0.03),

              /// Social Buttons
              _buildSocialButton(
                icon: Icons.apple,
                text: "${AppStrings.apple}",
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildSocialButton(
                iconWidget: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 18,
                    height: 18,
                    fit: BoxFit.contain,
                  ),
                ),
                text: "${AppStrings.google}",
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                icon: Icons.email,
                text: AppStrings.signUp,
                onTap: () {
                  // Navigate to email signup form
                },
              ),

              SizedBox(height: safeAreaHeight * 0.04),

              /// Divider
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.divider, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppStrings.orSignInWith,
                      style: TextStyle(color: AppColors.white54, fontSize: 12),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.divider, thickness: 1),
                  ),
                ],
              ),

              SizedBox(height: safeAreaHeight * 0.03),

              /// Phone Number Label
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.phoneHint,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// Country code + Phone number fields
              Row(
                children: [
                  // Country code field with flag
                  Container(
                    height: 56,
                    width: 110,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.softDark,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.yellow, Colors.green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountryCode,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.white,
                                size: 18,
                              ),
                              dropdownColor: AppColors.softDark,
                              items:
                                  ['+237', '+1', '+44', '+91', '+33']
                                      .map(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                      )
                                      .toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedCountryCode = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  /// Phone number input
                  Expanded(
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.softDark,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            hintText: AppStrings.phoneHint,
                            hintStyle: TextStyle(
                              color: AppColors.white54,
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: safeAreaHeight * 0.02),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_phoneController.text.trim().isNotEmpty) {
                      try {
                        await authProvider.signupWithPhone(
                          _selectedCountryCode + _phoneController.text.trim(),
                        );
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.errorGeneral),
                            backgroundColor: AppColors.accentRed,
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: AppColors.buttonTextOnNeon,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.signUp,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),

              const Spacer(),

              /// Bottom Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccount,
                    style: TextStyle(color: AppColors.white70, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: Text(
                      AppStrings.login,
                      style: TextStyle(
                        color: AppColors.neonGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: safeAreaHeight * 0.06),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Social Button
  Widget _buildSocialButton({
    IconData? icon,
    Widget? iconWidget,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.softDark,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(26),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) Icon(icon, color: AppColors.white, size: 20),
                if (iconWidget != null) iconWidget,
                if (icon != null || iconWidget != null)
                  const SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
