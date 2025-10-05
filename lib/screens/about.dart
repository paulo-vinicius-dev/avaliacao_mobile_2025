import 'package:flutter/material.dart';
import 'package:avaliacao_mobile_2025/widgets/member_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 1, 27, 1),
      appBar: AppBar(title: Text('Sobre o App'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Aplicativo de registro e review de suas experiências em jogos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Grupo de Desenvolvimento',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            BuildMemberCard(
              name: 'Elder Rafael de Oliveira Ribeiro',
              imageUrl:
                  'https://images.steamusercontent.com/ugc/1879716425116025737/11723F2216821EB402732AD65E7F315EF7B7A98C/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
            ),
            BuildMemberCard(
              name: 'Paulo Vinicius Oliveira da Costa',
              imageUrl:
                  'https://images.steamusercontent.com/ugc/1879716425116025737/11723F2216821EB402732AD65E7F315EF7B7A98C/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
            ),
            BuildMemberCard(
              name: 'Joâo Ryan de Aguiar Juriti',
              imageUrl:
                  'https://images.steamusercontent.com/ugc/1879716425116025737/11723F2216821EB402732AD65E7F315EF7B7A98C/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false',
            ),
            SizedBox(height: 30),
            Divider(color: Colors.white30),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Versão 1.0.0 • © 2025 PlayLegacy (nome aleatório)',
                style: TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
