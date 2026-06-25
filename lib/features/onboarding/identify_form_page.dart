import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_routes.dart';
import '../../core/models/respondent.dart';
import '../../core/providers/questionnaire_provider.dart';

class IdentifyFormPage extends StatefulWidget {
  const IdentifyFormPage({super.key});

  @override
  State<IdentifyFormPage> createState() => _IdentifyFormPageState();
}

class _IdentifyFormPageState extends State<IdentifyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final provider = context.read<QuestionnaireProvider>();
      provider.startIdentified(
        Respondent(
          name: _nameController.text.trim(),
          age: _ageController.text.trim(),
          phone: _phoneController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
        ),
      );
      Navigator.pushReplacementNamed(context, AppRoutes.questionnaire);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identificação')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Para oferecer acolhimento mais efetivo, preencha seus dados caso queira ser identificada.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                _buildTextField('Nome', controller: _nameController),
                _buildTextField('Idade',
                    controller: _ageController,
                    keyboardType: TextInputType.number),
                _buildTextField('Telefone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone),
                _buildTextField('Cidade', controller: _cityController),
                _buildTextField('Estado', controller: _stateController),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }
}
