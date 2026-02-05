class SupermarketChain {
  final String id;
  final String name; // chainName
  final String location; // hqAddress
  final String ownerName; // fullName
  final String contactNumber; // phone
  final String email;
  final String status; // e.g., 'Pending', 'Approved', 'Rejected'

  // backend/additional data
  final String? vatTrn;
  final String? tradeLicense;
  final String? logoUrl;
  final String? primaryColor;
  final int? expectedBranchCount;
  final String? posSystem;
  final String? countryCode;

  SupermarketChain({
    required this.id,
    required this.name,
    required this.location,
    required this.ownerName,
    required this.contactNumber,
    required this.email,
    required this.status,
    this.vatTrn,
    this.tradeLicense,
    this.logoUrl,
    this.primaryColor,
    this.expectedBranchCount,
    this.posSystem,
    this.countryCode,
  });
}
