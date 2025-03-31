import 'package:expense_tracker/model/expenses.dart';

List<ExpenseModel> dummyExpenses = [
  ExpenseModel(
    id: "65123abcde4567890f123456",
    userId: "user_001",
    amount: 250.75,
    description: "Dinner at a restaurant",
    category: ExpenseCategory.food,
    date: DateTime(2025, 3, 25, 19, 30),
    receipt: "base64encodedreceiptdata",
    receiptContentType: "image/png",
    createdAt: DateTime(2025, 3, 25, 19, 35),
    updatedAt: DateTime(2025, 3, 26, 10, 15),
    budget: 8000,
  ),
  ExpenseModel(
    id: "65123abcdef4567890f654321",
    userId: "user_001",
    budget: 8000,
    amount: 1200.00,
    description: "March Rent Payment",
    category: ExpenseCategory.rent,
    date: DateTime(2025, 3, 1, 8, 00),
    receipt: null,
    receiptContentType: null,
    createdAt: DateTime(2025, 3, 1, 8, 05),
    updatedAt: DateTime(2025, 3, 1, 8, 05),
  ),
  ExpenseModel(
    id: "65123abcdef4567890f654356",
    userId: "user_001",
    budget: 8000,
    amount: 3000.00,
    description: "March Rent Payment",
    category: ExpenseCategory.rent,
    date: DateTime(2025, 3, 1, 8, 00),
    receipt: null,
    receiptContentType: null,
    createdAt: DateTime(2025, 3, 1, 8, 05),
    updatedAt: DateTime(2025, 3, 1, 8, 05),
  ),
  ExpenseModel(
    budget: 8000,
    id: "65123acde67890f123abc456",
    userId: "user_002",
    amount: 350.50,
    description: "Electricity Bill",
    category: ExpenseCategory.utilities,
    date: DateTime(2025, 3, 15, 10, 00),
    receipt: "base64encodedreceiptdata",
    receiptContentType: "image/jpeg",
    createdAt: DateTime(2025, 3, 15, 10, 05),
    updatedAt: DateTime(2025, 3, 15, 10, 10),
  ),
  ExpenseModel(
    budget: 8000,
    id: "65123abcd67890f123def789",
    userId: "user_001",
    amount: 500.00,
    description: "Weekend Movie & Popcorn",
    category: ExpenseCategory.entertainment,
    date: DateTime(2025, 3, 22, 20, 15),
    receipt: null,
    receiptContentType: null,
    createdAt: DateTime(2025, 3, 22, 20, 20),
    updatedAt: DateTime(2025, 3, 22, 20, 20),
  ),
  ExpenseModel(
    id: "65123ab7890f123cde456ghi",
    userId: "user_002",
    budget: 8000,
    amount: 150.00,
    description: "Fuel for the car",
    category: ExpenseCategory.travel,
    date: DateTime(2025, 3, 18, 14, 00),
    receipt: "base64encodedreceiptdata",
    receiptContentType: "image/jpg",
    createdAt: DateTime(2025, 3, 18, 14, 10),
    updatedAt: DateTime(2025, 3, 18, 14, 15),
  ),
];
