import 'package:flutter/material.dart';
import 'package:webspark/core/route/route.dart';

class UrlHandlerScreen extends StatefulWidget {
  const UrlHandlerScreen({super.key});

  @override
  State<UrlHandlerScreen> createState() => _UrlHandlerScreenState();
}

class _UrlHandlerScreenState extends State<UrlHandlerScreen> {
  late final TextEditingController _urlController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Handler'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(labelText: 'Url'),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Please enter a url';
                }
                if(!Uri.parse(value).isAbsolute) {
                  return 'Please enter a valid url';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, RoutePath.urlHandlerDetails, arguments: {
                    'url': _urlController.text,
                  });
                }
              },
              child: const Text('Open Url'),
            ),
          ],
        ),
      ),
    );
  }
}
