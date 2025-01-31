import 'package:flutter/material.dart';
import '../../../model/lesson.dart';

class LessonCard extends StatefulWidget {
  final Lesson lesson;
  final VoidCallback onTap;
  final bool isCompleted;
  final bool isLocked;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.onTap,
    required this.isCompleted,
    required this.isLocked,
  });

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLocked ? null : widget.onTap,
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      child: SizedBox(
        width: 70,
        height: 65,
        child: Stack(
          children: [
            // 影の部分
            Positioned(
              left: 0,
              top: 28.50,
              child: Container(
                width: 70,
                height: 16, 
                decoration: BoxDecoration(
                  color: !isPressed ? (widget.isLocked ? const Color(0xFFAAAAAA) : const Color(0x33000000)) : Colors.transparent,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
              ),
            ),
            // メインのボタン
            AnimatedPositioned(
              duration: const Duration(milliseconds: 100),
              left: 0,
              top: isPressed ? 8 : 0,
              child: Container(
                width: 70,
                height: 57,
                decoration: ShapeDecoration(
                  color: widget.isLocked
                      ? const Color(0xFF888888)
                      : (widget.isCompleted ? const Color(0xFF58CC02) : const Color(0xFF58CC02)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(31.75),
                  ),
                  shadows: !isPressed ? [
                    BoxShadow(
                      color: widget.isLocked
                          ? const Color(0xFF888888)
                          : const Color(0xFF58CC02),
                      blurRadius: 0,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                    const BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 0,
                      offset: Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ] : null,
                ),
                child: Center(
                  child: _buildButtonContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (widget.isCompleted) {
      return Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Center(
          child: Icon(
            Icons.star,
            color: Color(0xFF58CC02),
            size: 24,
          ),
        ),
      );
    }
    
    if (widget.isLocked) {
      return const Icon(
        Icons.lock,
        color: Colors.white,
        size: 28,
      );
    }

    // アクティブなボタン
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
