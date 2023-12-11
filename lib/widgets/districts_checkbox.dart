import 'package:flutter/material.dart';
import '../lists/district.dart';
import '../styles/colors.dart';

List<String> selectedDistricts = [];

class DropdownWithCheckboxes extends StatefulWidget {
  const DropdownWithCheckboxes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DropdownWithCheckboxesState createState() => _DropdownWithCheckboxesState();
}

class _DropdownWithCheckboxesState extends State<DropdownWithCheckboxes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height / 17,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: primaryBlue,
                ),
                hint: Text(
                  'Select Districts',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 3,
                      ),
                    ],
                    fontSize: 17,
                    color: const Color.fromARGB(255, 95, 94, 94),
                  ),
                ),
                dropdownColor: const Color.fromARGB(201, 255, 255, 255),
                items: districts.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return CheckboxListTile(
                          title: Text(district),
                          value: selectedDistricts.contains(district),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  selectedDistricts.add(district);
                                } else {
                                  selectedDistricts.remove(district);
                                }
                              }
                            });
                          },
                        );
                      },
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {},
                isExpanded: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
