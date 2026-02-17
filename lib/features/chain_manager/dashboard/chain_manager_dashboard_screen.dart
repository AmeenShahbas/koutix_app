import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../../../core/theme/app_theme.dart';
import '../../../shared_models/store_model.dart';
import '../../../core/services/store_service.dart';

class ChainManagerDashboardScreen extends StatefulWidget {
  const ChainManagerDashboardScreen({super.key});

  @override
  State<ChainManagerDashboardScreen> createState() =>
      _ChainManagerDashboardScreenState();
}

class _ChainManagerDashboardScreenState
    extends State<ChainManagerDashboardScreen> {
  final StoreService _storeService = StoreService();
  List<Store> _stores = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStores();
  }

  Future<void> _loadStores() async {
    setState(() => _isLoading = true);
    try {
      final stores = await _storeService.getStores();
      setState(() => _stores = stores);
    } catch (e) {
      debugPrint("Error loading stores: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showBranchDialog({Store? store}) {
    final isEditing = store != null;
    final nameController = TextEditingController(text: store?.name ?? '');
    final emailController = TextEditingController(
      text: store?.managerEmail ?? '',
    );
    final addressController = TextEditingController(text: store?.address ?? '');
    final latController = TextEditingController(
      text: store?.location.lat.toString() ?? '',
    );
    final lngController = TextEditingController(
      text: store?.location.lng.toString() ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(
          0xFF1E1E1E,
        ), // Dark background matching theme
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          isEditing ? 'Edit Branch' : 'Add Branch',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField("Branch Name", nameController),
                const SizedBox(height: 16),
                _buildTextField("Manager Email", emailController),
                const SizedBox(height: 16),
                _buildTextField("Address", addressController),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        "Latitude",
                        latController,
                        isNumeric: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        "Longitude",
                        lngController,
                        isNumeric: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: GoogleFonts.inter(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () async {
              final newStore = Store(
                id: store?.id, // Keep existing ID if editing
                name: nameController.text,
                managerEmail: emailController.text,
                address: addressController.text,
                location: Location(
                  lat: double.tryParse(latController.text) ?? 0.0,
                  lng: double.tryParse(lngController.text) ?? 0.0,
                ),
              );

              if (isEditing) {
                await _storeService.updateStore(newStore);
                // Update local list
                final index = _stores.indexWhere((s) => s.id == store.id);
                if (index != -1) {
                  setState(() {
                    _stores[index] = newStore;
                  });
                }
              } else {
                try {
                  final addedStore = await _storeService.addStore(newStore);
                  setState(() => _stores.add(addedStore));
                } catch (e) {
                  // Fallback for demo if backend fails to return ID
                  setState(() => _stores.add(newStore));
                }
              }
              if (mounted) Navigator.pop(context);
            },
            child: Text(
              isEditing ? "Save Changes" : "Add Branch",
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteStore(Store store) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Delete Branch",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to delete ${store.name}? This action cannot be undone.",
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Cancel",
              style: GoogleFonts.inter(color: Colors.white70),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFFCF6679,
              ), // Error color for delete
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              "Delete",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      if (store.id != null) {
        await _storeService.deleteStore(store.id!);
      }
      setState(() {
        _stores.remove(store);
      });
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
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
          body: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  width:
                      MediaQuery.of(context).size.width *
                      0.9, // Responsive width
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chain Manager Dashboard",
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Manage your branches and performance",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _showBranchDialog(),
                            icon: const Icon(Icons.add, color: Colors.white),
                            label: Text(
                              "Add Branch",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : _stores.isEmpty
                            ? Center(
                                child: Text(
                                  "No branches found. Add your first branch!",
                                  style: GoogleFonts.inter(
                                    color: Colors.white54,
                                  ),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 400,
                                      crossAxisSpacing: 24,
                                      mainAxisSpacing: 24,
                                      childAspectRatio: 1.4,
                                    ),
                                itemCount: _stores.length,
                                itemBuilder: (context, index) {
                                  final store = _stores[index];
                                  return Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.05),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.store,
                                              color: AppTheme.primaryColor,
                                              size: 32,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white54,
                                                    size: 20,
                                                  ),
                                                  onPressed: () =>
                                                      _showBranchDialog(
                                                        store: store,
                                                      ),
                                                  tooltip: 'Edit Branch',
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white54,
                                                    size: 20,
                                                  ),
                                                  onPressed: () =>
                                                      _deleteStore(store),
                                                  tooltip: 'Delete Branch',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          store.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          store.address,
                                          style: GoogleFonts.inter(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.person_outline,
                                                color: Colors.white54,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 8),
                                              Flexible(
                                                child: Text(
                                                  store.managerEmail,
                                                  style: GoogleFonts.inter(
                                                    color: Colors.white54,
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Chain Manager Dashboard",
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
