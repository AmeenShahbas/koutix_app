import 'package:flutter/material.dart';
import '../../../core/models/supermarket_chain_model.dart';
import '../../../core/services/super_admin_service.dart';

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
              'Backend not reachable (${e.toString().contains('404') ? '404 Endpoint Not Found' : 'Connection Error'}). Showing Demo Data.',
            ),
            backgroundColor: Colors.orange,
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
          const SnackBar(content: Text('Supermarket Chain Approved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve: ${e.toString()}')),
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
          const SnackBar(content: Text('Supermarket Chain Approval Cancelled')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reject: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Super Admin Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: _chains.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final chain = _chains[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      title: Text(
                        chain.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text("Owner: ${chain.ownerName}"),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                chain.status,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _getStatusColor(chain.status),
                              ),
                            ),
                            child: Text(
                              chain.status,
                              style: TextStyle(
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
                        const Divider(),
                        _buildSectionTitle("Organization Details"),
                        _buildInfoRow(
                          Icons.location_on_outlined,
                          "HQ Address",
                          chain.location,
                        ),
                        _buildInfoRow(
                          Icons.email_outlined,
                          "Email",
                          chain.email,
                        ),
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
                                Icon(
                                  Icons.palette_outlined,
                                  size: 20,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "Primary Color: ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: _hexToColor(chain.primaryColor!),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 24),
                        const Text(
                          "Actions",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
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
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text("Approved"),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: chain.status == 'Rejected'
                                    ? null
                                    : () => _cancelApproveChain(chain.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text("Cancel Approved"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Divider()),
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
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Helper to parse hex color string
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
