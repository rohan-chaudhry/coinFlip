//
//  MessagesViewController.swift
//  coinFlip MessagesExtension
//
//  Created by Rohan Chaudhry on 8/20/24.
import UIKit
import Messages


// MARK: OG code

class MessagesViewController: MSMessagesAppViewController {

    private var flipButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        // Initialize the button if it's not already created
        if flipButton == nil {
            flipButton = UIButton(type: .system)
            flipButton.setTitle("Flip Coin", for: .normal)
            flipButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            flipButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            flipButton.addTarget(self, action: #selector(flipCoin), for: .touchUpInside)
            view.addSubview(flipButton)
        }
    }
    
    @objc private func flipCoin() {
        let result = Bool.random() ? "Heads" : "Tails"
        sendCoinFlipResult(result)
    }
    
    private func sendCoinFlipResult(_ result: String) {
        // Create the message layout
        let message = MSMessage()
        let layout = MSMessageTemplateLayout()
        
        // Use caption for the result
        layout.caption = "Coin Flip Result: \(result)"
        
        // Set the layout for the message
        message.layout = layout
        
        // Prepare the message
        let conversation = activeConversation
        conversation?.insert(message, completionHandler: { error in
            if let error = error {
                print("Error inserting message: \(error)")
            }
        })
        
        // Dismiss the view controller
        dismiss()
    }
    
    override func didBecomeActive(with conversation: MSConversation) {
        super.didBecomeActive(with: conversation)
        // Ensure the button is set up when the app becomes active
        setupView()
    }
    
    override func willResignActive(with conversation: MSConversation) {
        super.willResignActive(with: conversation)
        // Handle any necessary cleanup here
    }
}
