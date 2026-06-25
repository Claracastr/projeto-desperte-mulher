import 'package:flutter/material.dart';

/// Design System: cores, temas e componentes base para UI acolhedora.
/// Segue a paleta e regras definidas pelo pedido do usuário.

class DSColors {
  DSColors._();

  // Paleta principal
  static const Color primary = Color(0xFF7FB3D5); // Azul Serenity
  static const Color primaryLight = Color(0xFFAED6F1); // Azul Céu Claro
  static const Color accent = Color(0xFF76D7C4); // Verde Água
  static const Color background = Color(0xFFFAFCFD); // Branco Gelo
  static const Color card = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF6C7A89);

  // Grupo de seções (cores de destaque)
  static const Color group1 = Color(0xFFAED6F1); // Info gerais
  static const Color group2 = Color(0xFFA3E4D7); // Situação atual
  static const Color group3 = Color(0xFFD7BDE2); // Rede de apoio
  static const Color group4 = Color(0xFFFAD7A0); // Segurança e bem-estar
  static const Color group5 = Color(0xFF7FB3D5); // Avaliação final

  // Medidor de risco (de baixo->alto)
  static const Color riskVeryLow = Color(0xFF76D7C4);
  static const Color riskLow = Color(0xFF82E0AA);
  static const Color riskModerate = Color(0xFFF7DC6F);
  static const Color riskHigh = Color(0xFFF8C471);
  static const Color riskVeryHigh = Color(0xFFEC7063);
  static const Color riskCritical = Color(0xFFCD6155);

  // Outros
  static const Color stepInactive = Color(0xFFD6DBDF);
}

class DSTextStyles {
  DSTextStyles._();

  static const TextStyle headline = TextStyle(
    color: DSColors.textPrimary,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle title = TextStyle(
    color: DSColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    color: DSColors.textPrimary,
    fontSize: 15,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    color: DSColors.textSecondary,
    fontSize: 13,
  );
}

class DSTheme {
  DSTheme._();

  static ThemeData lightTheme(
      [Brightness platformBrightness = Brightness.light]) {
    final base = ThemeData.light();
    return base.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: DSColors.background,
      primaryColor: DSColors.primary,
      colorScheme: base.colorScheme.copyWith(
        primary: DSColors.primary,
        secondary: DSColors.accent,
        surface: DSColors.background,
        onPrimary: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: DSColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineLarge: DSTextStyles.headline,
        titleLarge: DSTextStyles.title,
        bodyLarge: DSTextStyles.body,
        bodyMedium: DSTextStyles.body,
        bodySmall: DSTextStyles.caption,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DSColors.primary,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size.fromHeight(48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DSColors.primary,
          side: const BorderSide(color: DSColors.primary),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      cardTheme: CardTheme(
        color: DSColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
    );
  }

  static ThemeData darkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F1720),
    );
  }
}

/// Decorações e utilitários visuais
class DSWidgets {
  DSWidgets._();

  static BoxDecoration questionCardDecoration({Color? color}) {
    return BoxDecoration(
      color: color ?? DSColors.card,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  static const double cardRadius = 20.0;

  /// Selection overlay color (15% opacity of primary)
  static Color selectionColor(BuildContext context) =>
      DSColors.primary.withAlpha(38);

  /// Stepper colors
  static Color stepActive = DSColors.primary;
  static Color stepCompleted = DSColors.accent;
  static Color stepInactive = DSColors.stepInactive;

  static LinearGradient progressGradient = const LinearGradient(
    colors: [DSColors.primary, DSColors.accent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

/// Mapeamento de cores para o medidor de risco.
class RiskMapper {
  RiskMapper._();

  /// Retorna a cor correspondente ao percentual (0.0 - 1.0)
  static Color colorForPercent(double p) {
    final percent = p.clamp(0.0, 1.0);
    if (percent <= 0.10) return DSColors.riskVeryLow;
    if (percent <= 0.25) return DSColors.riskLow;
    if (percent <= 0.50) return DSColors.riskModerate;
    if (percent <= 0.75) return DSColors.riskHigh;
    if (percent <= 0.90) return DSColors.riskVeryHigh;
    return DSColors.riskCritical;
  }

  /// Retorna um gradiente suave para o medidor (usa cor base e próximo tom)
  static Gradient gradientForPercent(double p) {
    final c = colorForPercent(p);
    return LinearGradient(colors: [c.withAlpha(217), c.withAlpha(128)]);
  }
}

/// Widgets utilitários prontos para uso no app
class QuestionCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets padding;
  const QuestionCard(
      {super.key,
      required this.child,
      this.color,
      this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: DSWidgets.questionCardDecoration(color: color),
      child: child,
    );
  }
}

class SelectableOption extends StatefulWidget {
  final Widget child;
  final bool selected;
  final VoidCallback? onTap;
  const SelectableOption(
      {super.key, required this.child, this.selected = false, this.onTap});

  @override
  State<SelectableOption> createState() => _SelectableOptionState();
}

class _SelectableOptionState extends State<SelectableOption>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 160),
        lowerBound: 0.0,
        upperBound: 0.03);
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  void _onTap() {
    widget.onTap?.call();
    _ctl.forward().then((_) => _ctl.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final scale = 1 - _ctl.value;
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..scale(
              widget.selected ? 1.02 : scale, widget.selected ? 1.02 : scale),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: widget.selected
              ? DSWidgets.selectionColor(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: widget.child,
      ),
    );
  }
}

/// Notas rápidas de acessibilidade (para desenvolvedores)
/// - Use tamanhos de fonte responsivos (MediaQuery.textScaleFactor).
/// - Verifique contraste com `DSColors.textPrimary` e `background`.
/// - Para modo escuro, adapte `card` e `background` para tons mais escuros.
