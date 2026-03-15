String generateSampleId({
  required String name,
  required String? sex,
  required String height,
  required String weight,
}) {
  final parts = name.trim().split(RegExp(r'\s+'));
  final initials =
      parts.where((p) => p.isNotEmpty).take(2).map((p) => p[0]).join().toUpperCase();
  final sexTag = (sex ?? 'NA').substring(0, 1).toUpperCase();
  final heightDigits = height.replaceAll(RegExp(r'[^0-9]'), '');
  final weightDigits = weight.replaceAll(RegExp(r'[^0-9]'), '');
  final safeInitials = initials.isEmpty ? 'ID' : initials;

  return '$safeInitials-$sexTag-${heightDigits.padLeft(3, '0')}-${weightDigits.padLeft(3, '0')}';
}
