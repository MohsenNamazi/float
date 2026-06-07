import 'package:flutter/material.dart';

import 'package:float/features/flashcards/domain/entities/fsrs_state.dart';

class RatingButtons extends StatelessWidget {
  const RatingButtons({super.key, required this.onRate});

  final void Function(FsrsRating rating) onRate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _RatingButton(
          rating: FsrsRating.again,
          color: const Color(0xFFE07070),
          onTap: () => onRate(FsrsRating.again),
        ),
        _RatingButton(
          rating: FsrsRating.hard,
          color: const Color(0xFFD4A842),
          onTap: () => onRate(FsrsRating.hard),
        ),
        _RatingButton(
          rating: FsrsRating.good,
          color: const Color(0xFF7BA05B),
          onTap: () => onRate(FsrsRating.good),
        ),
        _RatingButton(
          rating: FsrsRating.easy,
          color: const Color(0xFF5B9BD5),
          onTap: () => onRate(FsrsRating.easy),
        ),
      ],
    );
  }
}

class _RatingButton extends StatelessWidget {
  const _RatingButton({
    required this.rating,
    required this.color,
    required this.onTap,
  });

  final FsrsRating rating;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            border: Border.all(color: color.withAlpha(100), width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rating.label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
