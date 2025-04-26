import 'package:flutter/material.dart';

class CreditCardData {
  final String number;
  final String holderName;
  final String expiryDate;
  final Color color;

  const CreditCardData({
    required this.number,
    required this.holderName,
    required this.expiryDate,
    required this.color,
  });
}

class CreditCard extends StatelessWidget {
  final CreditCardData data;

  const CreditCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: data.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: data.color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.credit_card,
                size: 32,
                color: Colors.white.withOpacity(0.8),
              ),
              Icon(
                Icons.credit_score,
                size: 32,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.number,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Holder',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.holderName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expires',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.expiryDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 