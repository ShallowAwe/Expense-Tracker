import 'package:expense_tracker/data/dummydata.dart';
import 'package:expense_tracker/model/expenses.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:intl/intl.dart'; // Add this package for date formatting

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String? selectedCategory;
  double maxExpense =
      dummyExpenses.map((e) => e.amount).reduce((a, b) => a > b ? a : b);

  // Map category to colors for consistent coloring
  final Map<ExpenseCategory, Color> categoryColors = {
    ExpenseCategory.food: Colors.orange,
    ExpenseCategory.travel: Colors.blue,
    ExpenseCategory.entertainment: Colors.deepPurple,
    ExpenseCategory.shopping: Colors.green,
    ExpenseCategory.utilities: Colors.purpleAccent,
    ExpenseCategory.other: Colors.amber,
    // Add other categories as needed
  };

  // Currency formatter
  final currencyFormat = NumberFormat.currency(
    symbol: '₹',
    decimalDigits: 2,
  );

  void _selectCategory(ExpenseCategory? category) {
    setState(() {
      selectedCategory = category?.toString();
    });
  }

  void _clearFilter() {
    setState(() {
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<ExpenseCategory, double> categoryTotal = {};
    double totalexpenses = 0.0;

    for (var expenses in dummyExpenses) {
      categoryTotal.update(
        expenses.category,
        (value) => value + expenses.amount,
        ifAbsent: () => expenses.amount,
      );
      totalexpenses += expenses.amount;
    }

    List<CategoryData> chartData = categoryTotal.entries
        .map((entry) => CategoryData(
              entry.key,
              (entry.value / totalexpenses) * 100,
              entry.value,
            ))
        .toList();

    // Sort expenses by date (newest first)
    final sortedExpenses = List.from(dummyExpenses)
      ..sort((a, b) => b.date.compareTo(a.date));

    // Filter expenses if category is selected
    final filteredExpenses = selectedCategory != null
        ? sortedExpenses
            .where((e) => e.category.toString() == selectedCategory)
            .toList()
        : sortedExpenses;

    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D1D1D),
        title: Text(
          'Expense Analytics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (selectedCategory != null)
            IconButton(
              icon: Icon(Icons.filter_list_off, color: Colors.white),
              onPressed: _clearFilter,
              tooltip: 'Clear filter',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3A3A3A), Color(0xFF2A2A2A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Budget column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Budget',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        currencyFormat.format(
                            10000), // Replace with your budget value from model
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Total Expenses column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Expenses',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        currencyFormat.format(totalexpenses),
                        style: TextStyle(
                          color: Colors.red[300],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Safe to Spend column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Safe to Spend',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        currencyFormat.format(-totalexpenses),
                        style: TextStyle(
                          color: (10000 - totalexpenses) >= 0
                              ? Colors.green[300]
                              : Colors.red[300],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Chart with elevation
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              padding: EdgeInsets.all(15),
              child: SfCircularChart(
                backgroundColor: Colors.transparent,
                margin: EdgeInsets.zero,
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: TextStyle(color: Colors.white70),
                ),
                // tooltipBehavior: TooltipBehavior(
                //   enable: true,
                //   format: 'point.x: ${currencyFormat.format("point.y")}',
                // ),
                // onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
                //   // Allow clicking on chart segments to filter
                //   if (args.position != null) {
                //     final pointIndex = args.pointIndex;
                //     if (pointIndex != null &&
                //         pointIndex >= 0 &&
                //         pointIndex < chartData.length) {
                //       _selectCategory(chartData[pointIndex].category);
                //     }
                //   }
                // },
                palette: categoryColors.values.toList(),
                series: [
                  DoughnutSeries<CategoryData, String>(
                    dataSource: chartData,
                    xValueMapper: (CategoryData data, _) =>
                        data.category.toString().split('.').last,
                    yValueMapper: (CategoryData expe, _) => expe.value,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      textStyle: TextStyle(color: Colors.white70, fontSize: 12),
                      useSeriesColor: true,
                    ),
                    innerRadius: '60%',
                    explode: true,
                    explodeIndex: chartData.indexWhere(
                        (data) => data.category.toString() == selectedCategory),
                    explodeOffset: '5%',
                    enableTooltip: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Expense list header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Expenses',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${filteredExpenses.length} items',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Expense list
            Expanded(
              child: filteredExpenses.isEmpty
                  ? Center(
                      child: Text(
                        'No expenses found',
                        style: TextStyle(color: Colors.white60),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = filteredExpenses[index];
                        final categoryName =
                            expense.category.toString().split('.').last;
                        final categoryColor =
                            categoryColors[expense.category] ?? Colors.grey;

                        // Format date
                        final formattedDate =
                            DateFormat('MMM dd, yyyy').format(expense.date);

                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3A3A3A),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: categoryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                _getCategoryIcon(expense.category),
                                color: categoryColor,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              expense.description,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              formattedDate,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  currencyFormat.format(expense.amount),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: categoryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    categoryName,
                                    style: TextStyle(
                                      color: categoryColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Icons.restaurant;
      case ExpenseCategory.travel:
        return Icons.flight;
      case ExpenseCategory.entertainment:
        return Icons.sports_esports;
      case ExpenseCategory.rent:
        return Icons.receipt;
      case ExpenseCategory.shopping:
        return Icons.shopping_basket_outlined;
      case ExpenseCategory.other:
        return Icons.more_horiz_sharp;
      default:
        return Icons.attach_money;
    }
  }
}

class CategoryData {
  final ExpenseCategory category;
  final double percentage;
  final double value;
  CategoryData(this.category, this.percentage, this.value);
}
