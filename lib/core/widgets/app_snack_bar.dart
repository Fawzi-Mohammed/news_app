import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/theme/light_color.dart';

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final BorderRadius borderRadius = BorderRadius.circular(20);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: EdgeInsets.zero,
        content: ClipRRect(
          borderRadius: borderRadius,
          clipBehavior: Clip.antiAlias,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    LightColors.surface.withValues(alpha: 0.70),
                    LightColors.surface.withValues(alpha: 0.45),
                    LightColors.surface.withValues(alpha: 0.26),
                  ],
                  stops: const [0, 0.45, 1],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.60),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: LightColors.primary.withValues(alpha: 0.12),
                    blurRadius: 22,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -46,
                    left: -16,
                    right: -16,
                    height: 126,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topCenter,
                            radius: 1.05,
                            colors: [
                              Colors.white.withValues(alpha: 0.75),
                              Colors.white.withValues(alpha: 0.35),
                              Colors.white.withValues(alpha: 0.0),
                            ],
                            stops: const [0, 0.40, 1],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -54,
                    right: -22,
                    width: 150,
                    height: 150,
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.bottomRight,
                            radius: 1.1,
                            colors: [
                              LightColors.primary.withValues(alpha: 0.18),
                              LightColors.primary.withValues(alpha: 0.06),
                              LightColors.primary.withValues(alpha: 0.0),
                            ],
                            stops: const [0, 0.50, 1],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            style: AppTextStyles.fieldValue.copyWith(
                              color: LightColors.primary,
                            ),
                          ),
                        ),
                        if (actionLabel != null && onAction != null)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 1,
                                height: 26,
                                color: LightColors.primary.withValues(
                                  alpha: 0.16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  messenger.hideCurrentSnackBar();
                                  onAction();
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  actionLabel,
                                  style: AppTextStyles.fieldTitle.copyWith(
                                    color: LightColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: 1.2,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        height: 1,
                        color: LightColors.primary.withValues(alpha: 0.20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
