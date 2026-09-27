enum AgentSender {
  boss('Boss (Principal)'),
  friday('Agent 2: F.R.I.D.A.Y.'),
  cis('Agent 1: Chief Investment Strategist'),
  forensicLead('Agent 3: Fundamental & Forensic Lead'),
  quantLead('Agent 4: Market Structure & Quant Lead'),
  forensicAuditor('Agent 5: Forensic Auditor'),
  financialModeler('Agent 6: Financial Modeler'),
  concallScraper('Agent 7: Concall Scraper'),
  peerAnalyst('Agent 8: Valuation Analyst');

  final String displayName;
  const AgentSender(this.displayName);
}

class AgentChatMessage {
  final String id;
  final AgentSender sender;
  final String message;
  final DateTime timestamp;
  final Map<String, dynamic>? telemetryData; // e.g. simulation outputs or checklists

  const AgentChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
    this.telemetryData,
  });
}
