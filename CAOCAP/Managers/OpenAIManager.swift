//
//  OpenAIManager.swift
//  CAOCAP
//
//  Created by الشيخ عزام on 17/08/2024.
//

import Foundation
import OpenAI


/// `OpenAIManager` is a singleton class responsible for managing interactions with the OpenAI API.
/// It securely loads the API key from an external `OpenAI-info.plist` file and provides methods to interact with the API, such as generating text completions.
class OpenAIManager {
    
    /// The shared singleton instance of `OpenAIManager`, allowing for centralized management of API requests.
    static let shared = OpenAIManager()
    
    /// The API key used to authenticate requests to the OpenAI API. This key is loaded from the `OpenAI-info.plist` file.
    private let openAI: OpenAI
    
    /// Private initializer to enforce the singleton pattern. This initializer loads the API key from the
    /// `OpenAI-info.plist` file located in the app's main bundle.
    private init() {
        // Attempt to find and load the `OpenAI-info.plist` file from the app bundle.
        guard let path = Bundle.main.path(forResource: "OpenAI-Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("API Key not found in OpenAI-info.plist")
        }
        openAI = OpenAI(apiToken: key)
    }
    
    /// Generates a completion from the OpenAI API based on the provided prompt.
    ///
    /// - Parameters:
    ///   - prompt: The text prompt to send to the OpenAI API for generating a completion.
    ///   - completion: A closure that is called with the API's response, which is either a generated completion string or `nil` in case of an error.
    func generateCompletion(for prompt: String, completion: @escaping (String?) -> Void) {
        let query = CompletionsQuery(model: .gpt3_5Turbo, prompt: prompt, temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
        
        openAI.completions(query: query) { result in
            switch result {
            case .success(let response):
                print("Generated text: \(response.choices.first?.text ?? "")")
                completion(response.choices.first?.text ?? "")
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
}
