import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Income', 'Expense', 'Transfer'];

  // 샘플 데이터
  final List<Transaction> _transactions = [
    Transaction(
      title: 'Coffee Shop',
      description: 'Morning coffee',
      amount: 5.99,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isIncome: false,
      category: 'Expense',
    ),
    Transaction(
      title: 'Salary',
      description: 'Monthly salary',
      amount: 5000.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      isIncome: true,
      category: 'Income',
    ),
    Transaction(
      title: 'Transfer to Savings',
      description: 'Monthly savings',
      amount: 1000.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
      isIncome: false,
      category: 'Transfer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          // 카테고리 필터
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(category),
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                    backgroundColor: Colors.white.withOpacity(0.1),
                    selectedColor: Theme.of(context).colorScheme.primary,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                ).animate().fadeIn().slideX();
              },
            ),
          ),

          // 거래 내역 목록
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                if (_selectedCategory != 'All' &&
                    transaction.category != _selectedCategory) {
                  return const SizedBox.shrink();
                }
                return Card(
                  color: Colors.white.withOpacity(0.1),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      // 상세 정보를 보여주는 바텀 시트
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.grey[900],
                        builder: (context) => _TransactionDetails(transaction),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: transaction.isIncome
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      child: Icon(
                        transaction.isIncome
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: transaction.isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      transaction.description,
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    trailing: Text(
                      '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            transaction.isIncome ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).animate().fadeIn().slideX();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionDetails extends StatelessWidget {
  final Transaction transaction;

  const _TransactionDetails(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Details',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _DetailRow('Title', transaction.title),
          _DetailRow('Description', transaction.description),
          _DetailRow('Amount',
              '\$${transaction.amount.toStringAsFixed(2)}'),
          _DetailRow('Date',
              '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}'),
          _DetailRow('Type', transaction.isIncome ? 'Income' : 'Expense'),
          _DetailRow('Category', transaction.category),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // 여기에 공유 기능 추가 가능
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Share Receipt'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
} 