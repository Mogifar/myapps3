import 'package:flutter/foundation.dart';

/// Data model representing a single flight option.
///
/// Fields are [final] for immutability. A [const] constructor is not used
/// here because [DateTime] values cannot be compile-time constants.
class FlightModel {
  const FlightModel({
    required this.id,
    required this.airlineName,
    required this.airlineCode,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.currency,
    required this.isNonStop,
    required this.stops,
  });

  final String id;
  final String airlineName;    // e.g. "IndiGo"
  final String airlineCode;    // e.g. "6E"
  final String flightNumber;   // e.g. "6E 101"
  final String departureAirport; // e.g. "DEL"
  final String arrivalAirport;   // e.g. "EWR"
  final DateTime departureTime;
  final DateTime arrivalTime;
  final Duration duration;
  final double price;
  final String currency;       // e.g. "USD"
  final bool isNonStop;
  final int stops;             // 0 = non-stop, 1 = one-stop, etc.

  /// Formatted departure time (HH:mm)
  String get formattedDepartureTime =>
      '${departureTime.hour.toString().padLeft(2, '0')}:${departureTime.minute.toString().padLeft(2, '0')}';

  /// Formatted arrival time (HH:mm)
  String get formattedArrivalTime =>
      '${arrivalTime.hour.toString().padLeft(2, '0')}:${arrivalTime.minute.toString().padLeft(2, '0')}';

  /// Human-readable duration (e.g. "15h 30m")
  String get formattedDuration {
    final totalMinutes = duration.inMinutes;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  /// Mock flight data used to populate the search results screen.
  static List<FlightModel> get mockFlights => [
        FlightModel(
          id: 'F101',
          airlineName: 'IndiGo',
          airlineCode: '6E',
          flightNumber: '6E 101',
          departureAirport: 'DEL',
          arrivalAirport: 'EWR',
          departureTime: DateTime(2026, 10, 22, 6, 30),
          arrivalTime: DateTime(2026, 10, 22, 22, 0),
          duration: const Duration(hours: 15, minutes: 30),
          price: 125,
          currency: 'USD',
          isNonStop: true,
          stops: 0,
        ),
        FlightModel(
          id: 'F102',
          airlineName: 'IndiGo',
          airlineCode: '6E',
          flightNumber: '6E 205',
          departureAirport: 'DEL',
          arrivalAirport: 'EWR',
          departureTime: DateTime(2026, 10, 22, 14, 15),
          arrivalTime: DateTime(2026, 10, 23, 6, 45),
          duration: const Duration(hours: 16, minutes: 30),
          price: 275,
          currency: 'USD',
          isNonStop: false,
          stops: 1,
        ),
        FlightModel(
          id: 'F103',
          airlineName: 'Air India',
          airlineCode: 'AI',
          flightNumber: 'AI 127',
          departureAirport: 'DEL',
          arrivalAirport: 'EWR',
          departureTime: DateTime(2026, 10, 23, 8, 0),
          arrivalTime: DateTime(2026, 10, 23, 23, 55),
          duration: const Duration(hours: 15, minutes: 55),
          price: 340,
          currency: 'USD',
          isNonStop: true,
          stops: 0,
        ),
      ];
}
