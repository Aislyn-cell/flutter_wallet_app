import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/credit_card.dart';
import '../widgets/feature_button.dart';
import 'transactions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      CreditCardData(
        number: '5282 3456 7890 1289',
        holderName: 'Roronoa Zoro',
        expiryDate: '09/25',
        color: Colors.green.shade400,
      ),
      CreditCardData(
        number: '4485 8857 7531 9514',
        holderName: 'Monkey D. Luffy',
        expiryDate: '12/25',
        color: Colors.orange.shade400,
      ),
      CreditCardData(
        number: '3755 9562 4789 1235',
        holderName: 'Nami',
        expiryDate: '03/26',
        color: Colors.purple.shade400,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ronald richards',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Welcome back, ronald!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn().slideX(),
            
            SizedBox(
              height: 240,
              child: Swiper(
                itemCount: cards.length,
                itemBuilder: (context, index) => CreditCard(
                  data: cards[index],
                ),
                scale: 0.8,
                viewportFraction: 0.85,
              ),
            ).animate().fadeIn().slideY(),

            const SizedBox(height: 32),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ).animate().fadeIn().slideX(),

            const SizedBox(height: 16),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FeatureButton(
                    icon: Icons.swap_horiz,
                    label: 'Transfer',
                    onTap: () {},
                  ),
                  FeatureButton(
                    icon: Icons.request_page,
                    label: 'Request',
                    onTap: () {},
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(),

            const SizedBox(height: 32),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent activity',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionsScreen(),
                        ),
                      );
                    },
                    child: const Text('View all'),
                  ),
                ],
              ),
            ).animate().fadeIn().slideX(),
          ],
        ),
      ),
    );
  }
} 