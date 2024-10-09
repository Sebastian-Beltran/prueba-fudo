import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:prueba_fudo/core/constants/palette.dart';

class CustomDropDownSearch<T> extends StatelessWidget {
  const CustomDropDownSearch({
    required this.items,
    required this.onChanged,
    required this.itemBuilder,
    this.itemAsString,
    super.key,
  });

  final void Function(T?) onChanged;
  final List<T> items;
  final Widget Function(BuildContext, T, bool, bool)? itemBuilder;
  final String Function(T)? itemAsString;
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      key: key,
      items: (filter, infiniteScrollProps) => items,
      compareFn: (i, s) => i == s,
      onChanged: onChanged,
      itemAsString: itemAsString,
      decoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: 'Search user',
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 147, 147, 147)),
          hintStyle: const TextStyle(color: Colors.red),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromARGB(255, 238, 238, 238),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Palette.primary,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 238, 238, 238),
              width: 1.5,
            ),
          ),
        ),
      ),
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        itemBuilder: itemBuilder,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
