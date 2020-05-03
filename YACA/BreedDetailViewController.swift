//
//  BreedDetailViewController.swift
//  YACA
//
//  Created by Dmitry Reshetnik on 03.05.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {
    var breed: Breed?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = breed?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let altNameLabel = UILabel()
        altNameLabel.translatesAutoresizingMaskIntoConstraints = false
        if let altName = breed?.altNames {
            altNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            altNameLabel.textColor = .darkGray
            altNameLabel.text = altName
        } else {
            altNameLabel.isHidden = true
        }
        altNameLabel.sizeToFit()
        
        let temperamentLabel = UILabel()
        temperamentLabel.translatesAutoresizingMaskIntoConstraints = false
        temperamentLabel.numberOfLines = 0
        let temperamentString = NSMutableAttributedString(string: "Temperament: \(breed!.temperament)")
        temperamentString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: 12))
        temperamentLabel.attributedText = temperamentString
        temperamentLabel.sizeToFit()
        
        let lifeSpanLabel = UILabel()
        lifeSpanLabel.translatesAutoresizingMaskIntoConstraints = false
        let lifeSpanString = NSMutableAttributedString(string: "Life span: \(breed!.lifeSpan)")
        lifeSpanString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: 10))
        lifeSpanLabel.attributedText = lifeSpanString
        lifeSpanLabel.sizeToFit()
        
        let originLabel = UILabel()
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        let originString = NSMutableAttributedString(string: "Origin: \(breed!.origin)")
        originString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: 7))
        originLabel.attributedText = originString
        originLabel.sizeToFit()
        
        let wikipediaUrlLabel = UILabel()
        wikipediaUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        wikipediaUrlLabel.numberOfLines = 0
        wikipediaUrlLabel.text = "URL"
        wikipediaUrlLabel.sizeToFit()
        
        let textView = UITextView()
        let attributedString = NSMutableAttributedString(string: "To find more please visit the Wikipedia page.")
        if let url = breed?.wikipediaUrl {
            attributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: attributedString.mutableString.length))
        } else {
            attributedString.addAttribute(.link, value: "https://en.wikipedia.org/wiki/\(breed?.name.replacingOccurrences(of: " ", with: "_") ?? "https://en.wikipedia.org/wiki")", range: NSRange(location: 0, length: attributedString.mutableString.length))
        }
        textView.attributedText = attributedString
        textView.sizeToFit()
        wikipediaUrlLabel.addSubview(textView)
        wikipediaUrlLabel.isUserInteractionEnabled = true
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = breed?.description
        descriptionLabel.sizeToFit()
        
        view.addSubview(altNameLabel)
        view.addSubview(temperamentLabel)
        view.addSubview(lifeSpanLabel)
        view.addSubview(originLabel)
        view.addSubview(wikipediaUrlLabel)
        view.addSubview(descriptionLabel)
        
        var previous: UILabel?
        
        for label in [altNameLabel, temperamentLabel, lifeSpanLabel, originLabel, descriptionLabel, wikipediaUrlLabel] {
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
