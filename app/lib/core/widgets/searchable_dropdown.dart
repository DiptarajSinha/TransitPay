import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final List<String> items;
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;

  const SearchableDropdown({
    super.key,
    required this.items,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final _controller = TextEditingController();
  bool _isOpened = false;
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    if (widget.value != null) {
      _controller.text = widget.value!;
    }
  }

  void _onSearch(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: LayerLink(),
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search or Select...',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
              filled: true,
              fillColor: Colors.black.withValues(alpha: 0.3),
              suffixIcon: Icon(_isOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: Colors.white54),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF6366f1), width: 1.5)),
            ),
            onChanged: _onSearch,
            onTap: () => setState(() => _isOpened = true),
          ),
        ),
        if (_isOpened)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a1a),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return ListTile(
                    dense: true,
                    title: Text(item, style: const TextStyle(color: Colors.white)),
                    onTap: () {
                      _controller.text = item;
                      widget.onChanged(item);
                      setState(() => _isOpened = false);
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
