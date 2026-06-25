import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/design_system.dart';

class RiskMeter extends StatelessWidget {
  final double percent;
  final String status;
  final String label;
  final Color color;
  final IconData icon;
  final String subtitle;
  final String heroTag;
  final double size;

  const RiskMeter({
    super.key,
    required this.percent,
    required this.status,
    required this.label,
    required this.color,
    required this.icon,
    required this.subtitle,
    required this.heroTag,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    final displayPercent = (percent * 100).clamp(0, 100).round();

    return Hero(
      tag: heroTag,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: percent.clamp(0.0, 1.0)),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          final baseColor = RiskMapper.colorForPercent(value);
          final gradient = RiskMapper.gradientForPercent(value);

          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: baseColor.withAlpha(46),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: size,
                  height: size,
                  child: Transform.rotate(
                    angle: -math.pi / 2,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return SweepGradient(
                          startAngle: 0.0,
                          endAngle: 2 * math.pi,
                          colors: [baseColor, baseColor.withAlpha(115)],
                        ).createShader(rect);
                      },
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 14,
                        backgroundColor: Colors.white.withAlpha(179),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: baseColor, size: 32),
                    const SizedBox(height: 8),
                    TweenAnimationBuilder<Color?>(
                      tween: ColorTween(begin: Colors.black54, end: baseColor),
                      duration: const Duration(milliseconds: 600),
                      builder: (context, col, _) => Text(
                        '$displayPercent%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: col,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: baseColor.withAlpha(242),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 18,
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
