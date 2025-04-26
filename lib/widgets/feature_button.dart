import 'package:flutter/material.dart';

class FeatureButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<FeatureButton> createState() => _FeatureButtonState();
}

class _FeatureButtonState extends State<FeatureButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: _isPressed
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isPressed
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    size: 32,
                    color: _isPressed
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: _isPressed
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 