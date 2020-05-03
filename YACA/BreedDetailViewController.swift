//
//  BreedDetailViewController.swift
//  YACA
//
//  Created by Dmitry Reshetnik on 03.05.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var breed: Breed?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = breed?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        
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
        
        stackView.addArrangedSubview(altNameLabel)
        stackView.addArrangedSubview(temperamentLabel)
        stackView.addArrangedSubview(lifeSpanLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(wikipediaUrlLabel)
        stackView.addArrangedSubview(descriptionLabel)
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
