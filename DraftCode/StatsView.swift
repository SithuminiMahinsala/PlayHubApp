import SwiftUI
import Charts

// Helper struct for charting data
struct ScoreData: Identifiable {
    let id = UUID()
    let mode: String
    let score: Int
    let color: Color
}

struct StatsView: View {
    @AppStorage("tapFrenzyHighScore") private var tapScore = 0
    @AppStorage("lightItUpHighScore") private var lightScore = 0
    @AppStorage("quizRushHighScore") private var quizScore = 0
    
    var chartData: [ScoreData] {
        [
            ScoreData(mode: "Tap Frenzy", score: tapScore, color: .blue),
            ScoreData(mode: "Light It Up", score: lightScore, color: .orange),
            ScoreData(mode: "Quiz Rush", score: quizScore, color: .purple)
        ]
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Total Score Card
                VStack(spacing: 10) {
                    Text("Total Combined Score")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text("\(tapScore + lightScore + quizScore)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.primary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // SwiftUI Charts Bar Chart
                VStack(alignment: .leading, spacing: 15) {
                    Text("High Scores by Mode")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal)
                    
                    Chart(chartData) { item in
                        BarMark(
                            x: .value("Game Mode", item.mode),
                            y: .value("High Score", item.score)
                        )
                        .foregroundStyle(item.color)
                        .annotation(position: .top) {
                            Text("\(item.score)")
                                .font(.caption)
                                .bold()
                        }
                    }
                    .frame(height: 250)
                    .padding()
                    .background(Color.secondary.opacity(0.05))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
            .navigationTitle("Player Stats")
        }
    }
}