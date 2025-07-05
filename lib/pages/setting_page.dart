import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_weather_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        foregroundColor: Colors.grey,
      
      ),

      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dark Mode'),
        
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).isdarkMode,
             onChanged: (vaule)=> Provider.of<ThemeProvider>(context, listen: false).toggleTheme()
             ),
          ],
        ),
      ),
    );
  }
}