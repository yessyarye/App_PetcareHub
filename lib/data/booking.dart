class Booking {
  final String ownerName;
  final String petName;
  final String petType;
  final String serviceType;
  final DateTime selectedDate;

  Booking({
    required this.ownerName,
    required this.petName,
    required this.petType,
    required this.serviceType,
    required this.selectedDate,
  });
}
