import 'package:flutter/material.dart';
import 'search_results_page.dart';

/// Home / Search screen.
///
/// Matches the "Book Your Flight" layout:
/// trip-type tabs, From/To selectors, date pickers, traveller/class counters,
/// and a primary "Search Flights" CTA that navigates to the results page.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomIndex = 0;
  int _tripTypeIndex = 0; // 0: Round Trip, 1: One Way, 2: Multi-City

  final TextEditingController _fromController = TextEditingController(text: 'Delhi');
  final TextEditingController _toController = TextEditingController(text: 'Newark');

  DateTime? _departureDate;
  DateTime? _returnDate;

  int _passengers = 1;
  String _travelClass = 'Economy';

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isDeparture) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              surface: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  void _searchFlights() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchResultsPage()),
    );
  }

  Widget _buildTripTypeSelector() {
    const labels = ['Round Trip', 'One Way', 'Multi-City'];
    return ToggleButtons(
      isSelected: List.generate(3, (i) => i == _tripTypeIndex),
      onPressed: (index) => setState(() => _tripTypeIndex = index!),
      borderRadius: BorderRadius.circular(12),
      fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
      selectedBorderColor: Theme.of(context).colorScheme.primary,
      selectedColor: Theme.of(context).colorScheme.primary,
      children: labels
          .map((label) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(label),
              ))
          .toList(),
    );
  }

  Widget _buildLocationField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 20),
            hintText: label,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20, color: Colors.amber),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    date != null
                        ? '${date.month}/${date.day}/${date.year}'
                        : 'Select date',
                    style: TextStyle(
                      color: date != null
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTravellersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Travellers & Class',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildCounter('Passengers', _passengers),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDropdown(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCounter(String label, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 20),
                onPressed: _passengers > 1
                    ? () => setState(() => _passengers--)
                    : null,
                color: Colors.white70,
              ),
              Text('$value', style: const TextStyle(color: Colors.white)),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: () => setState(() => _passengers++),
                color: Colors.white70,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Class', style: TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _travelClass,
              dropdownColor: Theme.of(context).colorScheme.surface,
              style: const TextStyle(color: Colors.white),
              icon: const Icon(Icons.expand_more, color: Colors.amber),
              items: const [
                'Economy',
                'Premium Economy',
                'Business',
                'First',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _travelClass = val!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _searchFlights,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: const Text(
          'Search Flights',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedBottomIndex,
      onTap: (index) => setState(() => _selectedBottomIndex = index),
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.confirmation_num), label: 'Bookings'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MARK: Header
              Text(
                'Book Your Flight',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find the best flights to your destination',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 24),

              // MARK: Trip type tabs
              _buildTripTypeSelector(),
              const SizedBox(height: 24),

              // MARK: From / To fields
              Row(
                children: [
                  Expanded(
                    child: _buildLocationField(
                      label: 'From',
                      controller: _fromController,
                      icon: Icons.flight_takeoff,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildLocationField(
                      label: 'To',
                      controller: _toController,
                      icon: Icons.flight_land,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // MARK: Date selectors
              Row(
                children: [
                  Expanded(
                    child: _buildDateField(
                      label: 'Departure',
                      date: _departureDate,
                      onTap: () => _pickDate(context, true),
                    ),
                  ),
                  if (_tripTypeIndex == 0) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateField(
                        label: 'Return',
                        date: _returnDate,
                        onTap: () => _pickDate(context, false),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),

              // MARK: Travellers & Class
              _buildTravellersSection(),
              const SizedBox(height: 32),

              // MARK: Primary CTA
              _buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }
}
