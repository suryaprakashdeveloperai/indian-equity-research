import 'package:flutter_test/flutter_test.dart';
import '../../lib/domain/models/decision_scorecard.dart';

void main() {
  group('DecisionScorecard Tests', () {
    test('Weights must sum exactly to 100.0%', () {
      const scorecard = DecisionScorecard(
        finalVerdictSignedByAgent1: 'STRONG BUY',
        cisCapitalAllocationSize: '10.0%',
        items: [
          ScorecardItem(
            category: 'Business Quality & Moat',
            weightPercent: 20.0,
            score: 4.5,
            primaryEvidence: 'High moat',
            responsibleAgent: 'Agent 8',
          ),
          ScorecardItem(
            category: 'Financial Strength & Balance Sheet',
            weightPercent: 20.0,
            score: 4.8,
            primaryEvidence: 'Clean cash flows',
            responsibleAgent: 'Agent 6',
          ),
          ScorecardItem(
            category: 'Growth Visibility & Orders',
            weightPercent: 20.0,
            score: 4.5,
            primaryEvidence: 'Order book',
            responsibleAgent: 'Agent 7',
          ),
          ScorecardItem(
            category: 'Management Quality & Forensics',
            weightPercent: 15.0,
            score: 5.0,
            primaryEvidence: '0% pledge',
            responsibleAgent: 'Agent 5',
          ),
          ScorecardItem(
            category: 'Valuation Asymmetry',
            weightPercent: 15.0,
            score: 4.0,
            primaryEvidence: 'Low P/E',
            responsibleAgent: 'Agent 4',
          ),
          ScorecardItem(
            category: 'Risk-Reward Profile',
            weightPercent: 10.0,
            score: 4.5,
            primaryEvidence: 'High asymmetry',
            responsibleAgent: 'Agent 1',
          ),
        ],
      );

      final totalWeight = scorecard.items.fold<double>(0.0, (acc, item) => acc + item.weightPercent);
      expect(totalWeight, equals(100.0));
      expect(scorecard.totalWeightedScore, closeTo(4.55, 0.05));
      expect(scorecard.totalScorePercentage, closeTo(91.0, 1.0));
    });
  });
}
