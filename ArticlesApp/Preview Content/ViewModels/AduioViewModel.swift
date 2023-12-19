//
//  AduioViewModel.swift
//  ArticlesApp
//
//  Created by ghada Mohammad on 03/06/1445 AH.
//

import Foundation
import AVFoundation
class Audieo: ObservableObject{
    @Published  var audioPlayer: AVAudioPlayer?
    func fetchAudio(text: String) {
        let parameters = """
      {
          "model": "tts-1",
          "input": "\(text)",
          "voice": "alloy"
      }
      """
        
        guard let url = URL(string: "https://api.openai.com/v1/audio/speech") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = parameters.data(using: .utf8)
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                if let audioPlayer = try? AVAudioPlayer(data: data) {
                    self.audioPlayer = audioPlayer
                    self.audioPlayer?.prepareToPlay()
                    self.audioPlayer?.play()
                } else {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Error Response: \(responseString)")
                    }
                }
            }
        }
        
        task.resume()
    }
    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
