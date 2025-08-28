import 'package:bite_rush/constants/colors.dart';
import 'package:bite_rush/constants/strings.dart';
import 'package:bite_rush/providers/auth_provider.dart';
import 'package:bite_rush/widgets/input_field.dart';
import 'package:bite_rush/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isEmailSelected = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final safeAreaHeight =
        screenHeight - mediaQuery.padding.top - mediaQuery.padding.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          height: safeAreaHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Header Section - 10% of screen
              Container(
                height: safeAreaHeight * 0.1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Bite",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.neonGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Rush",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(
                            color: AppColors.buttonTextOnNeon,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Title Section - 15% of screen
              Container(
                height: safeAreaHeight * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.getStarted,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              // Form Section - 60% of screen
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 5),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.softDark,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isEmailSelected = true),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _isEmailSelected
                                      ? AppColors.neonGreen
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    color: _isEmailSelected
                                        ? AppColors.buttonTextOnNeon
                                        : AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isEmailSelected = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: !_isEmailSelected
                                      ? AppColors.neonGreen
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                alignment: Alignment.center,
                                child: FittedBox(
                                  child: Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      color: !_isEmailSelected
                                          ? AppColors.buttonTextOnNeon
                                          : AppColors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 2),

                    // First Input Field (Email / Phone)
                    Text(
                      _isEmailSelected ? "Email" : "Phone Number",
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    InputField(
                      controller: _emailController,
                      hint: _isEmailSelected ? AppStrings.emailHint : "Enter Phone Number",
                      icon: _isEmailSelected ? Icons.email_outlined : Icons.phone_outlined,
                      keyboardType: _isEmailSelected ? TextInputType.emailAddress : TextInputType.phone,
                    ),

                    const Spacer(flex: 2),

                    // Second Input Field (Password / OTP)
                    Text(
                      _isEmailSelected ? "Password" : "OTP",
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    InputField(
                      controller: _passwordController,
                      hint: _isEmailSelected ? AppStrings.passwordHint : "Enter OTP",
                      icon: _isEmailSelected ? Icons.lock_outline : Icons.lock_clock_outlined,
                      obscure: _isEmailSelected, // OTP optional
                     keyboardType: _isEmailSelected ? TextInputType.text : TextInputType.number,

                    ),

                    const Spacer(flex: 2),

                    // Remember me and Forgot password
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 18,
                                width: 18,
                                child: Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) => setState(() => _rememberMe = v ?? false),
                                  activeColor: AppColors.neonGreen,
                                  checkColor: AppColors.buttonTextOnNeon,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  AppStrings.rememberMe,
                                  style: TextStyle(
                                    color: AppColors.neonGreen,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            AppStrings.forgetPassword,
                            style: TextStyle(
                              color: AppColors.accentRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(flex: 2),

                    // Login Button
                    Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonGreen.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await authProvider.login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                            if (mounted) {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login failed'),
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
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 0,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: Text(AppStrings.login),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // Divider
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0x33FFFFFF),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            AppStrings.orSignInWith,
                            style: TextStyle(
                              color: AppColors.white54,
                              fontStyle: FontStyle.italic,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0x33FFFFFF),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(flex: 2),

                    // Social Buttons
                    screenWidth < 350
                        ? Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: SocialButton(
                                  label: AppStrings.apple,
                                  icon: Icons.apple,
                                  onTap: () {},
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: SocialButton(
                                  label: AppStrings.google,
                                  iconWidget: Image.asset(
                                    'assets/images/search.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: SocialButton(
                                    label: AppStrings.apple,
                                    icon: Icons.apple,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: SocialButton(
                                    label: AppStrings.google,
                                    iconWidget: Image.asset(
                                      'assets/images/search.png',
                                      height: 16,
                                      width: 16,
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),

              // Footer Section - 15% of screen
              Container(
                height: safeAreaHeight * 0.15,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.noAccount,
                        style: TextStyle(
                          color: AppColors.white70,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: Text(
                          AppStrings.signUp,
                          style: TextStyle(
                            color: AppColors.neonGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
