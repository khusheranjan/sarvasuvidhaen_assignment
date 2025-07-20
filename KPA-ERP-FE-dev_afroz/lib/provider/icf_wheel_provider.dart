import 'package:flutter/material.dart';
import 'package:kpa_erp/services/api_services/api_service.dart';

class IcfWheelProvider extends ChangeNotifier {
  bool submitted = false;
  bool isEditing = false;
  bool showSummaryCard = false;
  bool showFilterCard = false;  // for filter summary card

  final searchController = TextEditingController();
  final treadDiameterController = TextEditingController(text: "915 (900-1000)");
  final lastShopIssueController = TextEditingController(text: "837 (800-900)");
  final condemningDiaController = TextEditingController(text: "825 (800-900)");
  final wheelGaugeController = TextEditingController(text: "1600 (+2,-1)");

  final List<Map<String, Widget>> allFields = [];
  List<Map<String, Widget>> visibleFields = [];

  String filterFormNumber = '';
  String filterCreatedAt = '';
  String filterCreatedBy = '';

  void initializeFields(List<Map<String, Widget>> fields) {
    allFields.clear();
    allFields.addAll(fields);
    visibleFields = List.from(allFields);
    notifyListeners();
  }

  void filterFields(String query) {
    visibleFields = query.isEmpty
        ? List.from(allFields)
        : allFields
            .where((field) => field.keys.first.toLowerCase().contains(query.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void applyFilter({String formNumber = '', String createdAt = '', String createdBy = ''}) {
    filterFormNumber = formNumber;
    filterCreatedAt = createdAt;
    filterCreatedBy = createdBy;

    // Example condition for demonstration, adjust logic according to your actual data
    showSummaryCard = formNumber.isNotEmpty || createdAt.isNotEmpty || createdBy.isNotEmpty;

    notifyListeners();
  }

  void handleSubmit(BuildContext context) async {
  submitted = true;
  isEditing = false;
  notifyListeners();

  try {
    final requestBody = {
      "formNumber": "WHEEL-2025-001",
      "treadDiameter": treadDiameterController.text,
      "lastShopIssue": lastShopIssueController.text,
      "condemningDia": condemningDiaController.text,
      "wheelGauge": wheelGaugeController.text,
    };

    // Use localhost for this specific API call
    const String localBaseUrl = "http://localhost:8000"; // For emulator, use 10.0.2.2

    final response = await ApiService.post(
      "/api/forms/wheel-specifications",
      requestBody,
      overrideBaseUrl: localBaseUrl,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] ?? "Form submitted successfully.")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Submission failed: $e")),
    );
  }
}


  void handleEdit() {
    isEditing = true;
    notifyListeners();
  }
}
