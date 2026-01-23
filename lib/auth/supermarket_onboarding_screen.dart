import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import 'login_screen.dart'; // For GrainPainter reusing

class SupermarketOnboardingScreen extends StatefulWidget {
  const SupermarketOnboardingScreen({super.key});

  @override
  State<SupermarketOnboardingScreen> createState() =>
      _SupermarketOnboardingScreenState();
}

class _SupermarketOnboardingScreenState
    extends State<SupermarketOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  int _totalSteps = 8; // Default max steps for Chain flow

  // -- State Data --

  // Step 1: Account Verification
  final _identifierController = TextEditingController(); // Email or Phone
  bool _isOtpSent = false;
  final _otpController = TextEditingController();

  // Step 2: Business Type
  String _businessType =
      'Single Store'; // 'Single Store' or 'Supermarket Chain'

  // Step 3: Organization / Store Details
  final _orgNameController = TextEditingController();
  final _orgCategoryController = TextEditingController();
  // Country & Currency reused from _selectedCountry

  // Step 4: Branch Details (For Chain Flow - currently just one branch for MVP/Demo)
  // In a real app, this would be a List<BranchModel>. For demo we verify 1 branch.
  final _branchNameController = TextEditingController();
  final _branchAddressController = TextEditingController();
  final _branchCityController = TextEditingController();
  final _branchStateController = TextEditingController();
  final _branchZipController = TextEditingController();

  final _timezoneController = TextEditingController(text: 'Asia/Kolkata');
  List<Map<String, String>> _addedBranches = [];

  // Step 5: Master Admin Profile
  final _adminNameController = TextEditingController();
  final _adminPassController = TextEditingController();
  final _adminConfirmPassController = TextEditingController();
  bool _isAdminPassVisible = false;

  // Step 6: Branding (Logo + Colors)
  // _primaryColor exists. Adding secondary.
  String _secondaryColor = '#CAFF85';

  // Step 7: Manager Assignment (MVP: Single Manager email)
  final _managerEmailController = TextEditingController();

  // Step 8: Success / API Key logic (Handled in UI)

  // -- Shared State --
  String _selectedCountry = 'India';
  String _currency = '₹';
  String _primaryColor = '#2E5915'; // Default Green

  @override
  void dispose() {
    _pageController.dispose();
    _identifierController.dispose();
    _otpController.dispose();
    _orgNameController.dispose();
    _orgCategoryController.dispose();
    _branchNameController.dispose();
    _branchAddressController.dispose();
    _branchCityController.dispose();
    _branchStateController.dispose();
    _branchZipController.dispose();
    _timezoneController.dispose();
    _adminNameController.dispose();
    _adminPassController.dispose();
    _adminConfirmPassController.dispose();
    _managerEmailController.dispose();

    // Controllers from previous version if still used locally or needing cleanup
    // Assuming we've fully switched, but keeping standard disposals safe.
    super.dispose();
  }

  void _nextPage() {
    // Logic to handle flow branching
    if (_currentStep == 1) {
      // Step 2: Business Type Selection
      // If Single Store, we might skip "Organization" specific complexity or "Branch Loop"
      // But for this unified flow, we will just map steps accordingly.
      // Keep simple linear navigation for now, can implement skip logic if needed.
    }

    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    } else {
      _showSuccessScreen();
    }
  }

  void _previousPage() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context); // Go back to login if at step 0
    }
  }

  void _showSuccessScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OnboardingSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Update currency based on country selection
    if (_selectedCountry == 'India') {
      _currency = '₹';
    } else if (_selectedCountry == 'USA') {
      _currency = '\$';
    } else if (_selectedCountry == 'UAE') {
      _currency = 'AED';
    } else if (_selectedCountry == 'Saudi Arabia') {
      _currency = 'SAR';
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background (Same as Login)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.6, -0.6),
                radius: 1.4,
                colors: [
                  Color(0xFF2E5915),
                  Color(0xFF1B3B0F),
                  Color(0xFF080F05),
                  Colors.black,
                ],
                stops: [0.0, 0.2, 0.5, 1.0],
              ),
            ),
          ),
          // Bottom-Left Primary Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.6, 0.6),
                radius: 1.4,
                colors: [
                  Color(0xFF2E5915),
                  Color(0xFF1B3B0F),
                  Color(0xFF080F05),
                  Colors.transparent,
                ],
                stops: [0.0, 0.2, 0.5, 1.0],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: CustomPaint(painter: GrainPainter()),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                if (MediaQuery.of(context).size.width < 600) ...[
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    'assets/icons/logowithoutbg.svg',
                    height: 48,
                    fit: BoxFit.contain,
                  ),
                ],
                // Header (Progress)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Row(
                    children: [
                      // Glass Circular Back Button
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: InkWell(
                            onTap: _previousPage,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),

                      // Progress Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Step ${_currentStep + 1} of $_totalSteps',
                              style: GoogleFonts.inter(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Segmented Progress Indicator
                            Row(
                              children: List.generate(_totalSteps, (index) {
                                return Expanded(
                                  child: Container(
                                    height: 4,
                                    margin: const EdgeInsets.only(right: 4),
                                    decoration: BoxDecoration(
                                      color: index <= _currentStep
                                          ? AppTheme.primaryColor
                                          : Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 480),
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 60,
                                  offset: const Offset(0, 30),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: 600,
                              child: PageView(
                                controller: _pageController,
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable swipe
                                children: [
                                  _buildStep1AccountVerification(),
                                  _buildStep2BusinessType(),
                                  _buildStep3OrganizationSetup(),
                                  _buildStep4BranchCreation(),
                                  _buildStep5AdminProfile(),
                                  _buildStep6Branding(),
                                  _buildStep7ManagerAssignment(),
                                  _buildStep8ApiKey(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STEP 1: Account Verification
  Widget _buildStep1AccountVerification() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Your Koutix Account',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email or phone number to verify your identity.',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                _buildLabel('Business Email OR Phone'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _identifierController,
                  hint: 'owner@chain.com',
                ),
                if (_isOtpSent) ...[
                  const SizedBox(height: 24),
                  _buildLabel('Enter OTP'),
                  const SizedBox(height: 8),
                  _buildTextField(controller: _otpController, hint: '123456'),
                  const SizedBox(height: 8),
                  Text(
                    'OTP sent to ${_identifierController.text}. Expires in 5m.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(
            label: _isOtpSent ? 'Verify & Continue' : 'Send OTP',
            onPressed: () {
              if (!_isOtpSent) {
                setState(() => _isOtpSent = true);
              } else {
                _nextPage();
              }
            },
          ),
        ),
      ],
    );
  }

  // STEP 2: Business Type
  Widget _buildStep2BusinessType() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Structure',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Are you managing a single supermarket or multiple branches?',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                _buildOptionTile('Single Store', 'I manage one location'),
                const SizedBox(height: 16),
                _buildOptionTile(
                  'Supermarket Chain',
                  'I manage multiple branches',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(label: 'Continue', onPressed: _nextPage),
        ),
      ],
    );
  }

  Widget _buildOptionTile(String title, String subtitle) {
    bool isSelected = _businessType == title;
    return GestureDetector(
      onTap: () => setState(() => _businessType = title),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: GoogleFonts.inter(fontSize: 14, color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }

  // STEP 3: Organization Setup
  Widget _buildStep3OrganizationSetup() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _businessType == 'Single Store'
                      ? 'Store Details'
                      : 'Organization Setup',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Organization / Store Name'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _orgNameController,
                  hint: 'FreshMart Group',
                ),
                const SizedBox(height: 24),
                _buildLabel('Business Category'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _orgCategoryController,
                  hint: 'Supermarket, Grocery',
                ),
                const SizedBox(height: 24),
                _buildLabel('Country'),
                const SizedBox(height: 8),
                _buildDropdown(
                  value: _selectedCountry,
                  items: ['India', 'UAE', 'Saudi Arabia', 'USA'],
                  onChanged: (val) => setState(() => _selectedCountry = val!),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(label: 'Next', onPressed: _nextPage),
        ),
      ],
    );
  }

  // STEP 4: Branch Creation
  Widget _buildStep4BranchCreation() {
    bool isChain = _businessType == 'Supermarket Chain';
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isChain ? 'Add Your Branches' : 'Add Your Branch',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (isChain) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Add all your store locations here.',
                    style: GoogleFonts.inter(color: Colors.white70),
                  ),
                ],

                // List of Added Branches
                if (_addedBranches.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Added Branches (${_addedBranches.length})',
                    style: GoogleFonts.inter(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ..._addedBranches.asMap().entries.map((entry) {
                    final index = entry.key;
                    final branch = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.store,
                                color: AppTheme.primaryColor, size: 20),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  branch['name'] ?? '',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  branch['city'] ?? '',
                                  style: GoogleFonts.inter(
                                      color: Colors.white54, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline,
                                color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                _addedBranches.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white24),
                ],

                const SizedBox(height: 24),
                Text(
                  _addedBranches.isEmpty
                      ? 'Branch Details'
                      : 'Add Another Branch',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                _buildLabel('Branch Name'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _branchNameController,
                  hint: 'FreshMart Kozhikode',
                ),
                const SizedBox(height: 24),
                _buildLabel('City'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _branchCityController,
                  hint: 'Kozhikode',
                ),
                const SizedBox(height: 24),
                _buildLabel('Full Address'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _branchAddressController,
                  hint: 'Street, Building...',
                ),
                const SizedBox(height: 24),
                _buildLabel('Timezone'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _timezoneController,
                  hint: 'Asia/Kolkata',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              // Add Branch Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                     if (_branchNameController.text.isNotEmpty &&
                        _branchCityController.text.isNotEmpty) {
                      setState(() {
                        _addedBranches.add({
                          'name': _branchNameController.text,
                          'city': _branchCityController.text,
                          'address': _branchAddressController.text,
                          'timezone': _timezoneController.text,
                        });
                        // Clear fields for next entry
                        _branchNameController.clear();
                        _branchCityController.clear();
                        _branchAddressController.clear();
                        // Keep timezone as is or reset? Keep as is usually convenient.
                      });
                    } else {
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(content: Text('Please enter Branch Name and City')),
                       );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: AppTheme.primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Add Branch',
                        style: GoogleFonts.inter(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Continue Button
              _buildPrimaryButton(
                label: 'Continue',
                onPressed: () {
                  if (_addedBranches.isNotEmpty) {
                    _nextPage();
                  } else if (_branchNameController.text.isNotEmpty) {
                     // If user filled logic but forgot to click Add, we can auto-add or prompt.
                     // Auto-adding for smoother UX
                     setState(() {
                        _addedBranches.add({
                          'name': _branchNameController.text,
                          'city': _branchCityController.text,
                          'address': _branchAddressController.text,
                          'timezone': _timezoneController.text,
                        });
                        _branchNameController.clear();
                        _branchCityController.clear();
                        _branchAddressController.clear();
                     });
                     _nextPage();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please add at least one branch')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 5: Master Admin Profile
  Widget _buildStep5AdminProfile() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Master Admin Profile',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Full Name'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _adminNameController,
                  hint: 'Admin Name',
                ),
                const SizedBox(height: 24),
                _buildLabel('Password'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _adminPassController,
                  hint: 'Secure Password',
                  isPassword: true,
                  isVisible: _isAdminPassVisible,
                  onVisibilityChanged: () => setState(
                    () => _isAdminPassVisible = !_isAdminPassVisible,
                  ),
                ),
                const SizedBox(height: 24),
                _buildLabel('Confirm Password'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _adminConfirmPassController,
                  hint: 'Confirm Password',
                  isPassword: true,
                  isVisible: _isAdminPassVisible,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(
            label: 'Create Profile',
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }

  // STEP 6: Branding
  Widget _buildStep6Branding() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Brand Your Business',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Upload Logo'),
                const SizedBox(height: 8),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.cloud_upload,
                    color: Colors.white54,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                _buildLabel('Primary Color'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildColorSwatch('#2E5915', Colors.green.shade900),
                    const SizedBox(width: 8),
                    _buildColorSwatch('#1E3A8A', Colors.blue.shade900),
                  ],
                ),
                const SizedBox(height: 24),
                _buildLabel('Secondary Color'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildSecondaryColorSwatch(
                      '#CAFF85',
                      const Color(0xFFCAFF85),
                    ),
                    const SizedBox(width: 8),
                    _buildSecondaryColorSwatch('#BFDBFE', Colors.blue.shade100),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(
            label: 'Save Branding',
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }

  // STEP 7: Branch Managers
  Widget _buildStep7ManagerAssignment() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Assign Branch Managers',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel(
                  'Manager Email for ${_branchNameController.text.isEmpty ? "Main Branch" : _branchNameController.text}',
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _managerEmailController,
                  hint: 'manager@branch.com',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(
            label: 'Send Invitations',
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }

  // STEP 8: POS API
  Widget _buildStep8ApiKey() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'POS API Key Generated',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Use this key to connect your POS terminals.',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'KOUTIX_BRANCH_${DateTime.now().millisecondsSinceEpoch}',
                          style: GoogleFonts.robotoMono(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      const Icon(Icons.copy, color: Colors.white54, size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: _buildPrimaryButton(
            label: 'Finish Setup',
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryColorSwatch(String colorHex, Color color) {
    bool isSelected = _secondaryColor == colorHex;
    return GestureDetector(
      onTap: () => setState(() => _secondaryColor = colorHex),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
      ),
    );
  }

  // -- Widgets --

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.85),
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    bool? isVisible,
    VoidCallback? onVisibilityChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword && (isVisible == false || isVisible == null),
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: AppTheme.primaryColor,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: Colors.white.withOpacity(0.3),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 1.5,
          ),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (isVisible == true)
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white54,
                  size: 22,
                ),
                onPressed: onVisibilityChanged ?? () {},
              )
            : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: GoogleFonts.inter(color: Colors.white)),
            ),
          )
          .toList(),
      onChanged: onChanged,
      dropdownColor: const Color(0xFF1B3B0F),
      style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white54),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildColorSwatch(String colorHex, Color color) {
    bool isSelected = _primaryColor == colorHex;
    return GestureDetector(
      onTap: () => setState(() => _primaryColor = colorHex),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: Colors.white, width: 3)
              : Border.all(color: Colors.white24, width: 1),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 24)
            : null,
      ),
    );
  }
}

class OnboardingSuccessScreen extends StatelessWidget {
  const OnboardingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.6, -0.6),
                radius: 1.4,
                colors: [
                  Color(0xFF2E5915),
                  Color(0xFF1B3B0F),
                  Color(0xFF080F05),
                  Colors.black,
                ],
                stops: [0.0, 0.2, 0.5, 1.0],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: CustomPaint(painter: GrainPainter()),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryColor,
                    size: 80,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Your Supermarket is Ready',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your Koutix dashboard is now active.\nStart billing, tracking inventory, and monitoring sales instantly.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Dashboard
                        // For now, pop to login or main
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ), // Should be Dashboard
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Go to Dashboard',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Watch Quick Setup Guide',
                      style: GoogleFonts.inter(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
