import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import '../core/theme/app_theme.dart';
import '../core/services/auth_service.dart';
import '../core/services/cloudinary_service.dart';
import 'package:country_picker/country_picker.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isBranchManagerMode = false;

  // Country Selection state
  Country _selectedCountry = Country(
    phoneCode: "971",
    countryCode: "AE",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "United Arab Emirates",
    example: "501234567",
    displayName: "United Arab Emirates",
    displayNameNoCountryCode: "United Arab Emirates",
    e164Key: "",
  );

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _chainNameController = TextEditingController();
  final _vatTrnController = TextEditingController();
  final _hqAddressController = TextEditingController();
  final _tradeLicenseController = TextEditingController();
  final _tokenController =
      TextEditingController(); // Only for Invited Branch Managers

  // New Controllers for Branch/Independent Signup
  final _branchNameController = TextEditingController();
  final _addressController = TextEditingController(); // Specific store address
  final _logoUrlController = TextEditingController();
  final _primaryColorController = TextEditingController(text: "#FF6B35");
  final _expectedBranchCountController = TextEditingController(text: "1");

  // Image Upload State
  // Image Upload State
  XFile? _logoImageFile; // Use XFile for cross-platform support
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  String _selectedPosSystem = 'Custom';
  final List<String> _posOptions = ['SAP', 'Zoho', 'Custom'];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _chainNameController.dispose();
    _vatTrnController.dispose();
    _hqAddressController.dispose();
    _tradeLicenseController.dispose();
    _tokenController.dispose();
    _branchNameController.dispose();
    _addressController.dispose();
    _logoUrlController.dispose();
    _primaryColorController.dispose();
    _expectedBranchCountController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      if (_isBranchManagerMode) {
        // Construct E.164 phone number: +PhoneCodePhoneNumber
        String localNumber = _phoneController.text.trim();

        // Remove all non-numeric characters
        localNumber = localNumber.replaceAll(RegExp(r'\D'), '');

        // If the number starts with the country code (e.g. 971...), remove it
        if (localNumber.startsWith(_selectedCountry.phoneCode)) {
          localNumber = localNumber.substring(
            _selectedCountry.phoneCode.length,
          );
        }

        // Remove any leading zeros (e.g. 050... -> 50...)
        localNumber = localNumber.replaceAll(RegExp(r'^0+'), '');

        final fullPhone = '+${_selectedCountry.phoneCode}$localNumber';
        debugPrint('Formatted Phone for Signup: $fullPhone');

        if (_logoImageFile != null) {
          final logoUrl = await _cloudinaryService.uploadLogo(_logoImageFile!);
          if (logoUrl != null) {
            _logoUrlController.text = logoUrl;
          } else {
            throw Exception('Failed to upload logo image');
          }
        }

        await _authService.signupBranchManager(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _nameController.text.trim(),
          phoneNumber: fullPhone,
          branchName: _branchNameController.text.trim(),
          address: _addressController.text.trim(),
          vatTrn: _vatTrnController.text.trim(),
          tradeLicense: _tradeLicenseController.text.trim(),
          logoUrl: _logoUrlController.text.trim(),
          primaryColor: _primaryColorController.text.trim(),
          expectedBranchCount:
              int.tryParse(_expectedBranchCountController.text) ?? 1,
          posSystem: _selectedPosSystem,
        );
        _showSuccess('Branch Signup Successful! Check your email.');
      } else {
        // Construct E.164 phone number: +PhoneCodePhoneNumber
        // Remove all non-numeric characters first
        String localNumber = _phoneController.text.trim().replaceAll(
          RegExp(r'\D'),
          '',
        );

        // If user accidentally included the country code in the text field, remove it
        if (localNumber.startsWith(_selectedCountry.phoneCode)) {
          localNumber = localNumber.substring(
            _selectedCountry.phoneCode.length,
          );
        }

        // Remove leading zeros
        localNumber = localNumber.replaceAll(RegExp(r'^0+'), '');
        final fullPhone = '+${_selectedCountry.phoneCode}$localNumber';

        // Upload Logo if selected
        if (_logoImageFile != null) {
          final logoUrl = await _cloudinaryService.uploadLogo(_logoImageFile!);
          if (logoUrl != null) {
            _logoUrlController.text = logoUrl;
          } else {
            throw Exception('Failed to upload logo image');
          }
        }

        await _authService.signupChainManager(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _nameController.text.trim(),
          phone: fullPhone,
          chainName: _chainNameController.text.trim(),
          vatTrn: _vatTrnController.text.trim(),
          hqAddress: _hqAddressController.text.trim(),
          tradeLicense: _tradeLicenseController.text.trim(),
          primaryColor: _primaryColorController.text.trim(),
          expectedBranchCount: 1,
          posSystem: 'Custom',
          countryCode: _selectedCountry.phoneCode,
          logoUrl: _logoUrlController.text.trim(),
        );
        _showSuccess('Signup Successful! Pending SuperAdmin Approval.');
      }

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      _showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade900),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.black)),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Premium Background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.8),
                radius: 1.5,
                colors: [Color(0xFF2E5915), Color(0xFF1B3B0F), Colors.black],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(painter: GrainPainter()),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTopBar(),
                    const SizedBox(height: 40),
                    _buildMainTitle(),
                    const SizedBox(height: 32),
                    _buildToggle(),
                    const SizedBox(height: 32),

                    if (_isBranchManagerMode)
                      _buildBranchManagerForm()
                    else
                      _buildChainManagerForm(),

                    const SizedBox(height: 48),
                    _buildSubmitButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'KOUTIX',
          style: GoogleFonts.outfit(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 48), // Spacer to center logo
      ],
    );
  }

  Widget _buildMainTitle() {
    return Column(
      children: [
        Text(
          _isBranchManagerMode ? 'Join Branch' : 'Start Your Chain',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          _isBranchManagerMode
              ? 'Register your branch or independent store.'
              : 'Fill in the professional details to register your supermarket chain.',
          style: GoogleFonts.inter(color: Colors.white54, fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildToggle() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleButton('Supermarket Chain', !_isBranchManagerMode),
            _buildToggleButton('Branch Manager', _isBranchManagerMode),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          setState(() {
            _isBranchManagerMode = !_isBranchManagerMode;
            _formKey.currentState?.reset();
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.black : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildBranchManagerForm() {
    return Column(
      children: [
        _buildGlassSection(
          title: 'Store & Location',
          children: [
            _buildLabel('Store / Branch Name *'),
            _buildTextField(
              _branchNameController,
              'e.g. Nesto Al-Nud',
              validator: (v) => v!.isEmpty ? 'Store name required' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Address *'),
            _buildTextField(
              _addressController,
              'e.g. Sharjah, UAE',
              validator: (v) => v!.isEmpty ? 'Address required' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Expected Branch Count'),
            _buildTextField(
              _expectedBranchCountController,
              '1',
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildGlassSection(
          title: 'Manager Details',
          children: [
            _buildLabel('Full Name *'),
            _buildTextField(
              _nameController,
              'Alice Smith',
              validator: (v) => v!.isEmpty ? 'Name required' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Work Email *'),
            _buildTextField(
              _emailController,
              'manager@nesto.ae',
              validator: (v) => !v!.contains('@') ? 'Invalid email' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Mobile Number *'),
            _buildPhoneField(),
            const SizedBox(height: 24),
            _buildLabel('Password *'),
            _buildTextField(
              _passwordController,
              'SecurePassword123',
              isPassword: true,
              validator: (v) => v!.length < 6 ? 'Min 6 characters' : null,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildGlassSection(
          title: 'Configurations',
          children: [
            _buildLabel('POS System'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPosSystem,
                  dropdownColor: const Color(0xFF1B3B0F),
                  style: GoogleFonts.inter(color: Colors.white),
                  isExpanded: true,
                  items: _posOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPosSystem = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel('Primary Color'),
            _buildTextField(_primaryColorController, '#FF6B35'),
            const SizedBox(height: 24),
            _buildLabel('Logo (Optional)'),
            _buildImagePicker(),
            // Hidden controller field if needed, but we upload programmatically
            // _buildTextField(_logoUrlController, 'https://example.com/logo.png'),
          ],
        ),
        const SizedBox(height: 24),
        _buildGlassSection(
          title: 'Legal (Optional)',
          children: [
            _buildLabel('VAT / TRN'),
            _buildTextField(_vatTrnController, 'Optional'),
            const SizedBox(height: 24),
            _buildLabel('Trade License'),
            _buildTextField(_tradeLicenseController, 'Optional'),
          ],
        ),
      ],
    );
  }

  Widget _buildChainManagerForm() {
    return Column(
      children: [
        _buildGlassSection(
          title: 'Organization Details',
          children: [
            _buildLabel('Chain Name *'),
            _buildTextField(
              _chainNameController,
              'e.g. FreshMart Group',
              validator: (v) => v!.isEmpty ? 'Chain name required' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Business Email *'),
            _buildTextField(
              _emailController,
              'owner@company.ae',
              validator: (v) => !v!.contains('@') ? 'Invalid email' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Contact Number *'),
            _buildPhoneField(),
          ],
        ),
        const SizedBox(height: 24),
        _buildGlassSection(
          title: 'Master Admin Profile',
          children: [
            _buildLabel('Full Name *'),
            _buildTextField(
              _nameController,
              'Enter master admin name',
              validator: (v) => v!.isEmpty ? 'Name required' : null,
            ),
            const SizedBox(height: 24),
            _buildLabel('Security Password *'),
            _buildTextField(
              _passwordController,
              'Create password',
              isPassword: true,
              validator: (v) => v!.length < 6 ? 'Min 6 characters' : null,
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildGlassSection(
          title: 'Legal & Verification',
          children: [
            _buildLabel('VAT / TRN Number'),
            _buildTextField(_vatTrnController, '15-digit TRN number'),
            const SizedBox(height: 24),
            _buildLabel('Trade License'),
            _buildTextField(_tradeLicenseController, 'License number'),
            const SizedBox(height: 24),
            _buildLabel('HQ Address'),
            _buildTextField(_hqAddressController, 'Full business address'),
          ],
        ),
        const SizedBox(height: 24),
        _buildGlassSection(
          title: 'Configurations',
          children: [
            _buildLabel('Primary Color'),
            _buildTextField(_primaryColorController, '#FF6B35'),
            const SizedBox(height: 24),
            _buildLabel('Logo (Optional)'),
            _buildImagePicker(),
          ],
        ),
      ],
    );
  }

  Widget _buildGlassSection({
    required String title,
    required List<Widget> children,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.7),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                onSelect: (Country country) {
                  setState(() => _selectedCountry = country);
                },
                countryListTheme: CountryListThemeData(
                  backgroundColor: const Color(0xFF1B3B0F),
                  textStyle: GoogleFonts.inter(color: Colors.white),
                  searchTextStyle: GoogleFonts.inter(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  inputDecoration: InputDecoration(
                    hintText: 'Search country',
                    hintStyle: GoogleFonts.inter(color: Colors.white30),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(color: Colors.white.withOpacity(0.1)),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    _selectedCountry.flagEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+${_selectedCountry.phoneCode}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white54),
                ],
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: _selectedCountry.example,
                hintStyle: GoogleFonts.inter(color: Colors.white24),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: InputBorder.none,
                counterText: "", // Hide the counter for cleaner UI
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Phone required';
                if (v.length < 5) return 'Too short';
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.white24),
        filled: true,
        fillColor: Colors.white.withOpacity(0.03),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 1.5,
          ),
        ),
        errorStyle: GoogleFonts.inter(color: Colors.redAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignup,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : Text(
                _isBranchManagerMode
                    ? 'Complete Onboarding'
                    : 'Create Organization',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
              ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      behavior: HitTestBehavior
          .opaque, // Ensure tap is detected on the entire container
      onTap: () async {
        try {
          final XFile? image = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (image != null) {
            setState(() {
              _logoImageFile = image;
            });
          }
        } catch (e) {
          debugPrint('Error picking image: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to pick image: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: _logoImageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: kIsWeb
                    ? Image.network(
                        _logoImageFile!.path,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Image.file(
                        File(_logoImageFile!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: AppTheme.primaryColor,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap to upload store logo",
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random();
    for (int i = 0; i < 20000; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.08);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        0.6,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
