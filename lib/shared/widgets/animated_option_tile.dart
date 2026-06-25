import 'package:flutter/material.dart';
import '../../core/models/answer.dart';

class AnimatedOptionTile extends StatefulWidget {
  final Answer answer;
  final bool selected;
  final VoidCallback onTap;

  const AnimatedOptionTile({
    super.key,
    required this.answer,
    required this.selected,
    required this.onTap,
  });

  @override
  State<AnimatedOptionTile> createState() => _AnimatedOptionTileState();
}

class _AnimatedOptionTileState extends State<AnimatedOptionTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1 - _controller.value;
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.selected ? const Color(0x2E4DD0E1) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: widget.selected
                      ? const Color(0xFF4DD0E1)
                      : Colors.grey.shade300,
                  width: widget.selected ? 1.8 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: widget.selected ? 18 : 10,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.answer.label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            widget.selected ? FontWeight.w700 : FontWeight.w500,
                        color: widget.selected
                            ? const Color(0xFF1A374D)
                            : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: widget.selected
                          ? const Color(0xFF4DD0E1)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      widget.selected ? Icons.check : Icons.circle_outlined,
                      size: 20,
                      color: widget.selected ? Colors.white : Colors.grey,
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
