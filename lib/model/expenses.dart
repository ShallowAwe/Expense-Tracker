import 'dart:convert';

class ExpenseModel {
  final String? id;
  final String userId;
  final double amount;
  final double budget;
  final String description;
  final ExpenseCategory category;
  final DateTime date;
  final String? receipt;
  final String? receiptContentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ExpenseModel({
    this.id,
    required this.userId,
    required this.amount,
    required this.budget, // Ensure budget is required
    required this.description,
    required this.category,
    required this.date,
    this.receipt,
    this.receiptContentType,
    this.createdAt,
    this.updatedAt,
  });

  // Convert JSON to ExpenseModel
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['_id'],
      userId: json['userId'],
      amount: (json['amount'] as num).toDouble(),
      budget: (json['budget'] as num).toDouble(), // ✅ Fixed budget parsing
      description: json['description'],
      category: ExpenseCategory.values.firstWhere(
          (e) => e.toString().split('.').last == json['category'],
          orElse: () => ExpenseCategory.other),
      date: DateTime.parse(json['date']),
      receipt: json['receipt'],
      receiptContentType: json['receiptContentType'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Convert ExpenseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'amount': amount,
      'budget': budget, // ✅ Ensure budget is included in JSON output
      'description': description,
      'category': category.toString().split('.').last,
      'date': date.toIso8601String(),
      'receipt': receipt,
      'receiptContentType': receiptContentType,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

// Enum for Expense Categories
enum ExpenseCategory {
  food,
  travel,
  shopping,
  rent,
  entertainment,
  utilities,
  other,
}
