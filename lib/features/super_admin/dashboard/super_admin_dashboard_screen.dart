import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../../../core/models/supermarket_chain_model.dart';
import '../../../core/services/super_admin_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../auth/login_screen.dart';

class SuperAdminDashboardScreen extends StatefulWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  State<SuperAdminDashboardScreen> createState() =>
      _SuperAdminDashboardScreenState();
}

class _SuperAdminDashboardScreenState extends State<SuperAdminDashboardScreen> {
  final SuperAdminService _superAdminService = SuperAdminService();
  List<SupermarketChain> _chains = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChains();
  }

  Future<void> _fetchChains() async {
    setState(() => _isLoading = true);
    try {
      final chains = await _superAdminService.getPendingChainManagers();
      setState(() {
        _chains = chains;
        _isLoading = false;
      });
    } catch (e) {
      // Fallback to demo data if backend connection fails
      setState(() {
        _chains = [
          SupermarketChain(
            id: '1',
            name: 'Fresh Mart Chain',
            location: '123 Market St, Downtown',
            ownerName: 'Alice Williams',
            contactNumber: '+1 234 567 890',
            email: 'alice@freshmart.com',
            status: 'Pending',
            vatTrn: '123456789012345',
            tradeLicense: 'TL-2024-001',
            primaryColor: '#4CAF50',
            expectedBranchCount: 5,
            posSystem: 'SAP',
            countryCode: '971',
          ),
          SupermarketChain(
            id: '2',
            name: 'Green Grocers Global',
            location: '456 Eco Ave, Uptown',
            ownerName: 'Bob Smith',
            contactNumber: '+1 987 654 321',
            email: 'bob@greengrocers.com',
            status: 'Pending',
            vatTrn: '987654321098765',
            tradeLicense: 'TL-2024-042',
            primaryColor: '#8BC34A',
            expectedBranchCount: 3,
            posSystem: 'Custom',
            countryCode: '1',
          ),
        ];
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Backend not reachable. Showing Demo Data.',
              style: GoogleFonts.inter(color: Colors.black),
            ),
            backgroundColor: AppTheme.primaryColor,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _approveChain(String id) async {
    try {
      await _superAdminService.approveChainManager(id);
      setState(() {
        final index = _chains.indexWhere((c) => c.id == id);
        if (index != -1) {
          final current = _chains[index];
          _chains[index] = SupermarketChain(
            id: current.id,
            name: current.name,
            location: current.location,
            ownerName: current.ownerName,
            contactNumber: current.contactNumber,
            email: current.email,
            status: 'Approved',
            vatTrn: current.vatTrn,
            tradeLicense: current.tradeLicense,
            logoUrl: current.logoUrl,
            primaryColor: current.primaryColor,
            expectedBranchCount: current.expectedBranchCount,
            posSystem: current.posSystem,
            countryCode: current.countryCode,
          );
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Supermarket Chain Approved',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to approve: ${e.toString()}',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _cancelApproveChain(String id) async {
    try {
      await _superAdminService.rejectChainManager(id);
      setState(() {
        final index = _chains.indexWhere((c) => c.id == id);
        if (index != -1) {
          final current = _chains[index];
          _chains[index] = SupermarketChain(
            id: current.id,
            name: current.name,
            location: current.location,
            ownerName: current.ownerName,
            contactNumber: current.contactNumber,
            email: current.email,
            status: 'Rejected',
            vatTrn: current.vatTrn,
            tradeLicense: current.tradeLicense,
            logoUrl: current.logoUrl,
            primaryColor: current.primaryColor,
            expectedBranchCount: current.expectedBranchCount,
            posSystem: current.posSystem,
            countryCode: current.countryCode,
          );
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Supermarket Chain Approval Cancelled',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to reject: ${e.toString()}',
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Gradient Background
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

        // 2. Grain Overlay
        Positioned.fill(
          child: Opacity(
            opacity: 0.25,
            child: CustomPaint(painter: GrainPainter()),
          ),
        ),

        // 3. Content
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(),
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: _chains.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) =>
                        _buildChainCard(_chains[index]),
                  ),
                ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
      ),
      title: Text(
        "Super Admin Dashboard",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _buildChainCard(SupermarketChain chain) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              iconColor: AppTheme.primaryColor,
              collapsedIconColor: Colors.white70,
              title: Text(
                chain.name,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Owner: ${chain.ownerName}",
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(chain.status).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getStatusColor(chain.status).withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      chain.status,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: _getStatusColor(chain.status),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                Divider(color: Colors.white.withOpacity(0.1)),
                _buildSectionTitle("Organization Details"),
                _buildInfoRow(
                  Icons.location_on_outlined,
                  "HQ Address",
                  chain.location,
                ),
                _buildInfoRow(Icons.email_outlined, "Email", chain.email),
                _buildInfoRow(
                  Icons.phone_outlined,
                  "Contact",
                  chain.contactNumber,
                ),
                _buildInfoRow(
                  Icons.flag_outlined,
                  "Country Code",
                  chain.countryCode ?? "N/A",
                ),
                const SizedBox(height: 16),
                _buildSectionTitle("Legal & Backend"),
                _buildInfoRow(
                  Icons.verified_outlined,
                  "VAT/TRN",
                  chain.vatTrn ?? "N/A",
                ),
                _buildInfoRow(
                  Icons.assignment_outlined,
                  "Trade License",
                  chain.tradeLicense ?? "N/A",
                ),
                _buildInfoRow(
                  Icons.store_outlined,
                  "Expected Branches",
                  chain.expectedBranchCount?.toString() ?? "N/A",
                ),
                _buildInfoRow(
                  Icons.computer_outlined,
                  "POS System",
                  chain.posSystem ?? "N/A",
                ),
                if (chain.primaryColor != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.palette_outlined,
                          size: 20,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Primary Color: ",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: _hexToColor(chain.primaryColor!),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  "Actions",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: chain.status == 'Approved'
                            ? null
                            : () => _approveChain(chain.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.withOpacity(0.8),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.white.withOpacity(
                            0.1,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text("Approve"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: chain.status == 'Rejected'
                            ? null
                            : () => _cancelApproveChain(chain.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.8),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.white.withOpacity(
                            0.1,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text("Reject"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Divider(color: Colors.white.withOpacity(0.1))),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.white54),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.greenAccent;
      case 'Rejected':
        return Colors.redAccent;
      case 'Pending':
        return Colors.orangeAccent;
      default:
        return Colors.grey;
    }
  }

  Color _hexToColor(String code) {
    try {
      code = code.replaceAll('#', '');
      if (code.length == 6) {
        return Color(int.parse("FF$code", radix: 16));
      }
      return Colors.grey;
    } catch (e) {
      return Colors.grey;
    }
  }
}

class GrainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = math.Random();

    for (int i = 0; i < 25000; i++) {
      paint.color = Colors.white.withOpacity(random.nextDouble() * 0.05);
      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        0.7,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
