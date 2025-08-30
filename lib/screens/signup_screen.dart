import 'package:bite_rush/constants/colors.dart';
import 'package:bite_rush/constants/strings.dart';
import 'package:bite_rush/providers/auth_provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _phoneController = TextEditingController();
  Country _selectedCountry = Country(
    phoneCode: '92',
    countryCode: 'PK',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Pakistan',
    example: '301 2345678',
    displayName: 'Pakistan',
    displayNameNoCountryCode: 'Pakistan',
    e164Key: '',
  );

  @override
  void initState() {
    super.initState();
    // Initial value with default country code
    _phoneController.text = '+${_selectedCountry.phoneCode} ';
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              // Logo
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
              const SizedBox(height: 16),
              // Title & Description
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
              const SizedBox(height: 12),
              Text(
                AppStrings.signupDescription,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Social Buttons
              _buildSocialButton(
                icon: Icons.apple,
                text: AppStrings.apples,
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
                text: AppStrings.googles,
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _buildSocialButton(
                icon: Icons.email,
                text: AppStrings.gmail,
                onTap: () {},
              ),
              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.divider, thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppStrings.orSignInWith,
                      style: TextStyle(color: AppColors.white70, fontSize: 12),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.divider, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Phone Label
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

              // Country Picker + Phone Input
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            backgroundColor: AppColors.background,
                            textStyle: TextStyle(color: AppColors.white),
                            bottomSheetHeight: 500,
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              labelStyle: TextStyle(color: AppColors.white70),
                              hintText: 'Enter country name',
                              hintStyle: TextStyle(color: AppColors.white38),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.white70,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.white38,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.neonGreen,
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            setState(() {
                              _selectedCountry = country;
                              // When country changes, update text with country code
                              _phoneController.text = '+${country.phoneCode} ';
                            });
                          },
                        );
                      },
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.softDark,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: AppColors.border, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            // Flag emoji - reduced size
                            Text(
                              _selectedCountry.flagEmoji,
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                '+${_selectedCountry.phoneCode}',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.softDark,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_phoneController.text.trim().isNotEmpty) {
                      try {
                        final fullPhoneNumber = _phoneController.text.trim();
                        await authProvider.signupWithPhone(fullPhoneNumber);
                        if (!mounted) return;
                        Navigator.pushReplacementNamed(context, '/home');
                      } catch (e) {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppStrings.errorGeneral),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.softDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: AppColors.neonGreen,
                                width: 2,
                              ),
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            elevation: 4,
                            duration: const Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'OK',
                              textColor: AppColors.neonGreen,
                              onPressed: () {},
                            ),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a phone number"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.softDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.neonGreen,
                              width: 2,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          elevation: 4,
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'OK',
                            textColor: AppColors.neonGreen,
                            onPressed: () {},
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonGreen,
                    foregroundColor: AppColors.buttonTextOnNeon,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    AppStrings.signUp,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 65),

              // Bottom Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.alreadyHaveAccount,
                    style: TextStyle(color: AppColors.white70, fontSize: 14),
                  ),
                  const SizedBox(width: 4),
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

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

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
