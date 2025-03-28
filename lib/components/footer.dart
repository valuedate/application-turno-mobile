import 'package:flutter/material.dart';
import 'package:turno/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  // Function to open URLs inside the app
  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Fale Connosco (Contact Us)
        InkWell(
          onTap: () => _launchURL(context, 'https://turno.pt/talkwithus'),
          child: Text(
            "Fale Connosco",
            style: ThemeStyle.textStyle(
              fontSize: 13,
              color: ThemeStyle.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // Termos e Condições (Terms and Conditions)
        InkWell(
          onTap: () => _launchURL(context, 'https://turno.pt/terms'),
          child: Text(
            "Termos e Condições",
            style: ThemeStyle.textStyle(
              fontSize: 13,
              color: ThemeStyle.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // Official Website
        InkWell(
          onTap: () => _launchURL(context, 'https://turno.pt'),
          child: Text(
            "turno.cloud",
            style: ThemeStyle.textStyle(
              fontSize: 13,
              color: ThemeStyle.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
