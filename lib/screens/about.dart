import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/widgets/member_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Text(
              'Aplicativo de registro e review de suas experiências em jogos',
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontSize: 18,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Grupo de Desenvolvimento',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const BuildMemberCard(
              name: 'Elder Rafael de Oliveira Ribeiro',
              imageUrl:
              'https://images.steamusercontent.com/ugc/1879716425116025737/11723F2216821EB402732AD65E7F315EF7B7A98C/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
            ),
            const BuildMemberCard(
              name: 'Paulo Vinicius Oliveira da Costa',
              imageUrl:
              'https://images.steamusercontent.com/ugc/1879716425116025737/11723F2216821EB402732AD65E7F315EF7B7A98C/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
            ),
            const SizedBox(height: 30),
            Divider(color: colorScheme.outlineVariant),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Versão 0.3.0 • © 2025 PlayLegacy',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}