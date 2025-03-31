import 'package:expense_tracker/Screens/ProfileScreen.dart';
import 'package:expense_tracker/Screens/addexpenseScreen.dart';
import 'package:expense_tracker/Screens/analytics.dart';
import 'package:expense_tracker/Screens/walletScreen.dart';
import 'package:expense_tracker/widgets/recent_spends.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  // State variables
  String currentMonth = DateFormat.MMMM().format(DateTime.now());
  int amountSpent = 5000;
  int incomeAmount = 8500;
  int selectedIndex = 0;
  bool notificationPressed = false;

  // Screens for bottom navigation
  final List<Widget> _screens = [
    const HomeContent(),
    const AnalyticsScreen(),
    const Addexpensescreen(),
    const Walletscreen(),
    const Profilescreen()
  ];

  // Month navigation methods with error handling
  void _previousMonth() {
    try {
      setState(() {
        final now = DateFormat.MMMM().parse(currentMonth);
        final previous = DateTime(now.year, now.month - 1);
        currentMonth = DateFormat.MMMM().format(previous);
      });
    } catch (e) {
      print('Error navigating to previous month: $e');
    }
  }

  void _nextMonth() {
    try {
      setState(() {
        final now = DateFormat.MMMM().parse(currentMonth);
        final next = DateTime(now.year, now.month + 1);
        currentMonth = DateFormat.MMMM().format(next);
      });
    } catch (e) {
      print('Error navigating to next month: $e');
    }
  }

  // Improved bottom navigation handler
  void _onItemTapped(int index) {
    // Special handling for add expense screen
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Addexpensescreen()),
      );
      return;
    }

    // Update selected index for other screens
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFF2D2D2D),
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Extracted home content as a separate widget
class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // State variables
  String currentMonth = DateFormat.MMMM().format(DateTime.now());

  // Recent transactions data model
  final List<Map<String, dynamic>> recentTransactions = [
    {
      'icon': Icons.restaurant,
      'iconColor': Colors.orange,
      'title': 'Restaurant',
      'amount': '₹450',
      'time': '08:46 pm',
      'date': '17, Mar'
    },
    {
      'icon': Icons.shopping_bag,
      'iconColor': Colors.blue,
      'title': 'Shopping',
      'amount': '₹1200',
      'time': '05:59 pm',
      'date': '16, Mar'
    },
    {
      'icon': Icons.local_gas_station,
      'iconColor': Colors.red,
      'title': 'Fuel',
      'amount': '₹300',
      'time': '02:30 pm',
      'date': '16, Mar'
    },
    {
      'icon': Icons.movie,
      'iconColor': Colors.purple,
      'title': 'Movies',
      'amount': '₹225',
      'time': '07:15 pm',
      'date': '15, Mar'
    },
  ];

  // Month navigation methods with error handling
  void _previousMonth() {
    try {
      setState(() {
        final now = DateFormat.MMMM().parse(currentMonth);
        final previous = DateTime(now.year, now.month - 1);
        currentMonth = DateFormat.MMMM().format(previous);
      });
    } catch (e) {
      print('Error navigating to previous month: $e');
    }
  }

  void _nextMonth() {
    try {
      setState(() {
        final now = DateFormat.MMMM().parse(currentMonth);
        final next = DateTime(now.year, now.month + 1);
        currentMonth = DateFormat.MMMM().format(next);
      });
    } catch (e) {
      print('Error navigating to next month: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF4E4E4E),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          'Hi, User',
          style: GoogleFonts.poppins(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {
              //TdDO: navigation
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
              // TODO: NAvigationn
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(context),

              const SizedBox(height: 30),

              _buildRecentTransactionsHeader(),

              const SizedBox(height: 16),

              // Recent Transactions List
              _buildRecentTransactionsList(),

              const SizedBox(height: 30),

              _buildCategoriesHeader(),

              const SizedBox(height: 16),

              // Category Cards
              _buildCategoryCards(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 107, 107, 107),
            Color(0xFF4E4E4E),
            Color(0xFF3A3A3A),
            Color.fromARGB(255, 61, 61, 61),
            Color.fromARGB(255, 26, 26, 26),
            Color.fromARGB(192, 41, 173, 15),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(150),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Money Manager',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          size: 16, color: Colors.white),
                      onPressed: _previousMonth,
                    ),
                    Text(
                      currentMonth,
                      style: GoogleFonts.poppins(
                        color: Colors.greenAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.white),
                      onPressed: _nextMonth,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBalanceItem(
                  title: 'Income',
                  icon: Icons.arrow_downward_rounded,
                  iconColor: Colors.green,
                  amount: 8500,
                  amountColor: Colors.green,
                ),
                Container(
                  height: 70,
                  width: 1,
                  color: Colors.grey.withAlpha(150),
                ),
                _buildBalanceItem(
                  title: 'Expenses',
                  icon: Icons.arrow_upward_rounded,
                  iconColor: Colors.red,
                  amount: 5000,
                  amountColor: Colors.red,
                ),
                Container(
                  height: 70,
                  width: 1,
                  color: Colors.grey.withAlpha(150),
                ),
                _buildBalanceItem(
                  title: 'Balance',
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: Colors.white,
                  amount: 3500,
                  amountColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // method to build Recent Transactions Header
  Widget _buildRecentTransactionsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Implement view all transactions
          },
          child: Text(
            'View All',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.greenAccent,
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build Recent Transactions List
  Widget _buildRecentTransactionsList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentTransactions.length,
        itemBuilder: (context, index) {
          final transaction = recentTransactions[index];
          return RecentSpends(
            icon: transaction['icon'],
            iconColor: transaction['iconColor'],
            title: transaction['title'],
            amount: transaction['amount'],
            time: transaction['time'],
            date: transaction['date'],
          );
        },
      ),
    );
  }

  // Helper method to build Categories Header
  Widget _buildCategoriesHeader() {
    return Text(
      'Categories',
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  // Helper method to build Category Cards
  Widget _buildCategoryCards(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryCard(
                context, 'Food', Icons.restaurant, Colors.orange, '₹1,250'),
            _buildCategoryCard(
                context, 'Shopping', Icons.shopping_bag, Colors.blue, '₹2,130'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryCard(
                context, 'Transport', Icons.directions_car, Colors.red, '₹850'),
            _buildCategoryCard(
                context, 'Bills', Icons.receipt_long, Colors.purple, '₹770'),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceItem({
    required String title,
    required IconData icon,
    required Color iconColor,
    required int amount,
    required Color amountColor,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '₹$amount',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: amountColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon,
      Color color, String amount) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.44,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withAlpha(100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '25%',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
