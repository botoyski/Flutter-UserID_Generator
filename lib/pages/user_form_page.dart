import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/id_generator.dart';
import '../widgets/sample_id_dialog.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  static const String _idPhotoAsset = 'web/icons/i_dcxkcG_400x400.jpg';

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();

  String? _hairColor;
  String? _eyeColor;
  String? _sex;

  final List<String> _hairColors = const [
    'Black',
    'Brown',
    'Blonde',
    'Red',
    'Gray',
    'Other',
  ];

  final List<String> _eyeColors = const [
    'Brown',
    'Black',
    'Blue',
    'Green',
    'Hazel',
    'Gray',
    'Other',
  ];

  final List<String> _sexOptions = const [
    'Male',
    'Female',
    'Prefer not to say',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _showSampleIdDialog() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final sampleId = generateSampleId(
      name: _nameController.text,
      sex: _sex,
      height: _heightController.text,
      weight: _weightController.text,
    );

    await showDialog<void>(
      context: context,
      builder: (context) {
        return SampleIdDialog(
          idPhotoAsset: _idPhotoAsset,
          name: _nameController.text.trim(),
          sampleId: sampleId,
          height: _heightController.text,
          weight: _weightController.text,
          hairColor: _hairColor ?? '',
          eyeColor: _eyeColor ?? '',
          sex: _sex ?? 'N/A',
          address: _addressController.text.trim(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D6E6E),
        foregroundColor: Colors.white,
        title: const Text('Laboratory Exercise #4'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Information Form',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0B3D3D),
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Complete all fields to generate your sample ID.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _heightController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Height (cm)',
                                prefixIcon: Icon(Icons.straighten_rounded),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                final number = double.tryParse(value);
                                if (number == null || number <= 0) {
                                  return 'Invalid';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _weightController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Weight (kg)',
                                prefixIcon: Icon(Icons.monitor_weight_rounded),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Required';
                                }
                                final number = double.tryParse(value);
                                if (number == null || number <= 0) {
                                  return 'Invalid';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _hairColor,
                              decoration: const InputDecoration(
                                labelText: 'Hair Color',
                                prefixIcon: Icon(Icons.palette_rounded),
                                border: OutlineInputBorder(),
                              ),
                              items: _hairColors
                                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                                  .toList(),
                              onChanged: (value) => setState(() => _hairColor = value),
                              validator: (value) => value == null ? 'Please select a hair color.' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _eyeColor,
                              decoration: const InputDecoration(
                                labelText: 'Eye Color',
                                prefixIcon: Icon(Icons.remove_red_eye_rounded),
                                border: OutlineInputBorder(),
                              ),
                              items: _eyeColors
                                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                                  .toList(),
                              onChanged: (value) => setState(() => _eyeColor = value),
                              validator: (value) => value == null ? 'Please select an eye color.' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _sex,
                        decoration: const InputDecoration(
                          labelText: 'Sex',
                          prefixIcon: Icon(Icons.wc_rounded),
                          border: OutlineInputBorder(),
                        ),
                        items: _sexOptions
                            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                            .toList(),
                        onChanged: (value) => setState(() => _sex = value),
                        validator: (value) => value == null ? 'Please select sex.' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _addressController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.home_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your address.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _showSampleIdDialog,
                          icon: const Icon(Icons.badge_rounded),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Show Sample ID',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D6E6E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
