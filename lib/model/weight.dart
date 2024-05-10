class WeightEntry {
  final int id;
  final double weight;
  final DateTime date;
  final String? note;

  WeightEntry({
    required this.id,
    required this.weight,
    required this.date,
    this.note,
  });

  factory WeightEntry.fromSqfliteDatabase(Map<String, dynamic> data) =>  WeightEntry(
    id: data['id']?.toInt() ?? 0,
    weight: data['weight'] ?? '',
    date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    note: data['note'],
  );
}