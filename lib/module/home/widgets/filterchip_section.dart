import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FilterChipsSection extends StatefulWidget {
  final List<String> filterOptions;

  const FilterChipsSection({
    Key? key,
    required this.filterOptions,
  }) : super(key: key);

  @override
  _FilterChipsSectionState createState() => _FilterChipsSectionState();
}

class _FilterChipsSectionState extends State<FilterChipsSection> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          _buildFilterChip('All'),
          ...widget.filterOptions.map(_buildFilterChip).toList(),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        label: Text(label),
        showCheckmark: false,
        selectedColor: Colors.black,
        side: const BorderSide(color: Colors.transparent),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedFilter = label;
          });
        },
        backgroundColor: isSelected ? Colors.black : _getUnselectedColor(label),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : _getUnselectedTextColor(label),
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

 Color _getUnselectedColor(String label) {
    switch (label.toLowerCase()) {
      case 'all':
      case 'unread':
        return Colors.grey[200]!;
      case 'approved':
        return Colors.green[100]!;
      case 'pending':
        return Colors.orange[100]!;
      case 'declined':
        return Colors.red[100]!;
      default:
        return Colors.blue[100]!;
    }
  }

  Color _getUnselectedTextColor(String label) {
    switch (label.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'declined':
        return Colors.red;
      default:
        return Colors.black; 
    }
  }
}