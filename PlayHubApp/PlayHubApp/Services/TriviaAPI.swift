//
//  TriviaAPI.swift
//  PlayHubApp
//
//  Created by COBSCCOMP242P-001 on 2026-07-07.
//

import Foundation

class TriviaAPI {
    static let shared = TriviaAPI()
    private let urlString = "https://opentdb.com/api.php?amount=10&type=multiple"
    
    private init() {}
    
    // fetch 10 live trivia questions
    func fetchQuestions() async throws -> [TriviaQuestion] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
        return triviaResponse.results
    }
}
