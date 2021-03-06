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
        
        // Setting up UIScrollView.
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Set UIScrollView constraints.
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        scrollView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        // Setting up UIStackView.
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10

        // Set UIStackView constraints.
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Add constraint to block horizontal scroll.
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 10).isActive = true
        
        // Setting up symbols for labels.
        let config = UIImage.SymbolConfiguration(pointSize: 17, weight: .regular, scale: .medium)
        let checkMark = UIImage(systemName: "checkmark.circle", withConfiguration: config)
        let xMark = UIImage(systemName: "xmark.circle", withConfiguration: config)
        let circle = UIImage(systemName: "circle", withConfiguration: config)
        let circleFill = UIImage(systemName: "circle.fill", withConfiguration: config)
        
        // Setting up labels.
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
        
        let weightLabel = UILabel()
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        let weightString = NSMutableAttributedString(string: "Weight: \(breed?.weight["metric"] ?? "Unknown")")
        weightString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: 7))
        weightLabel.attributedText = weightString
        weightLabel.sizeToFit()
        
        let originLabel = UILabel()
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        let originString = NSMutableAttributedString(string: "Origin: \(breed!.origin), \(breed!.countryCode)")
        originString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: 7))
        originLabel.attributedText = originString
        originLabel.sizeToFit()
        
        let experimentalLabel = UILabel()
        experimentalLabel.translatesAutoresizingMaskIntoConstraints = false
        let experimentalString = NSMutableAttributedString(string: "Experimental: ")
        experimentalString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: experimentalString.length))
        if breed?.experimental == 1 {
            experimentalString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            experimentalLabel.attributedText = experimentalString
        } else {
            experimentalString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            experimentalLabel.attributedText = experimentalString
        }
        experimentalLabel.sizeToFit()
        
        let hairlessLabel = UILabel()
        hairlessLabel.translatesAutoresizingMaskIntoConstraints = false
        let hairlessString = NSMutableAttributedString(string: "Hairless: ")
        hairlessString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: hairlessString.length))
        if breed?.hairless == 1 {
            hairlessString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            hairlessLabel.attributedText = hairlessString
        } else {
            hairlessString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            hairlessLabel.attributedText = hairlessString
        }
        hairlessLabel.sizeToFit()
        
        let naturalLabel = UILabel()
        naturalLabel.translatesAutoresizingMaskIntoConstraints = false
        let naturalString = NSMutableAttributedString(string: "Natural: ")
        naturalString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: naturalString.length))
        if breed?.natural == 1 {
            naturalString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            naturalLabel.attributedText = naturalString
        } else {
            naturalString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            naturalLabel.attributedText = naturalString
        }
        naturalLabel.sizeToFit()
        
        let rareLabel = UILabel()
        rareLabel.translatesAutoresizingMaskIntoConstraints = false
        let rareString = NSMutableAttributedString(string: "Rare: ")
        rareString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: rareString.length))
        if breed?.rare == 1 {
            rareString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            rareLabel.attributedText = rareString
        } else {
            rareString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            rareLabel.attributedText = rareString
        }
        rareLabel.sizeToFit()
        
        let rexLabel = UILabel()
        rexLabel.translatesAutoresizingMaskIntoConstraints = false
        let rexString = NSMutableAttributedString(string: "Rex: ")
        rexString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: rexString.length))
        if breed?.rex == 1 {
            rexString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            rexLabel.attributedText = rexString
        } else {
            rexString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            rexLabel.attributedText = rexString
        }
        rexLabel.sizeToFit()
        
        let suppressedTailLabel = UILabel()
        suppressedTailLabel.translatesAutoresizingMaskIntoConstraints = false
        let suppressedTailString = NSMutableAttributedString(string: "Suppressed tail: ")
        suppressedTailString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: suppressedTailString.length))
        if breed?.suppressedTail == 1 {
            suppressedTailString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            suppressedTailLabel.attributedText = suppressedTailString
        } else {
            suppressedTailString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            suppressedTailLabel.attributedText = suppressedTailString
        }
        suppressedTailLabel.sizeToFit()
        
        let shortLegsLabel = UILabel()
        shortLegsLabel.translatesAutoresizingMaskIntoConstraints = false
        let shortLegsString = NSMutableAttributedString(string: "Short legs: ")
        shortLegsString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: shortLegsString.length))
        if breed?.shortLegs == 1 {
            shortLegsString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            shortLegsLabel.attributedText = shortLegsString
        } else {
            shortLegsString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            shortLegsLabel.attributedText = shortLegsString
        }
        shortLegsLabel.sizeToFit()
        
        let hypoallergenicLabel = UILabel()
        hypoallergenicLabel.translatesAutoresizingMaskIntoConstraints = false
        let hypoallergenicString = NSMutableAttributedString(string: "Hypoallergenic: ")
        hypoallergenicString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: hypoallergenicString.length))
        if breed?.hypoallergenic == 1 {
            hypoallergenicString.append(NSAttributedString(attachment: NSTextAttachment(image: checkMark!)))
            hypoallergenicLabel.attributedText = hypoallergenicString
        } else {
            hypoallergenicString.append(NSAttributedString(attachment: NSTextAttachment(image: xMark!)))
            hypoallergenicLabel.attributedText = hypoallergenicString
        }
        hypoallergenicLabel.sizeToFit()
        
        let adaptabilityLabel = UILabel()
        adaptabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        let adaptabilityString = NSMutableAttributedString(string: "Adaptability: ")
        adaptabilityString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: adaptabilityString.length))
        if breed!.adaptability % 5 == 0 {
            for _ in 1...5 {
                adaptabilityString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            adaptabilityLabel.attributedText = adaptabilityString
        } else {
            for i in 1...5 {
                if i <= breed!.adaptability % 5 {
                    adaptabilityString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    adaptabilityString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            adaptabilityLabel.attributedText = adaptabilityString
        }
        adaptabilityLabel.sizeToFit()
        
        let affectionLevelLabel = UILabel()
        affectionLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        let affectionLevelString = NSMutableAttributedString(string: "Affection level: ")
        affectionLevelString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: affectionLevelString.length))
        if breed!.affectionLevel % 5 == 0 {
            for _ in 1...5 {
                affectionLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            affectionLevelLabel.attributedText = affectionLevelString
        } else {
            for i in 1...5 {
                if i <= breed!.affectionLevel % 5 {
                    affectionLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    affectionLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            affectionLevelLabel.attributedText = affectionLevelString
        }
        affectionLevelLabel.sizeToFit()
        
        let childFriendlyLabel = UILabel()
        childFriendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        let childFriendlyString = NSMutableAttributedString(string: "Child friendly: ")
        childFriendlyString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: childFriendlyString.length))
        if breed!.childFriendly % 5 == 0 {
            for _ in 1...5 {
                childFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            childFriendlyLabel.attributedText = childFriendlyString
        } else {
            for i in 1...5 {
                if i <= breed!.childFriendly % 5 {
                    childFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    childFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            childFriendlyLabel.attributedText = childFriendlyString
        }
        childFriendlyLabel.sizeToFit()
        
        let dogFriendlyLabel = UILabel()
        dogFriendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        let dogFriendlyString = NSMutableAttributedString(string: "Dog friendly: ")
        dogFriendlyString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: dogFriendlyString.length))
        if breed!.dogFriendly % 5 == 0 {
            for _ in 1...5 {
                dogFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            dogFriendlyLabel.attributedText = dogFriendlyString
        } else {
            for i in 1...5 {
                if i <= breed!.dogFriendly % 5 {
                    dogFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    dogFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            dogFriendlyLabel.attributedText = dogFriendlyString
        }
        dogFriendlyLabel.sizeToFit()
        
        let strangerFriendlyLabel = UILabel()
        strangerFriendlyLabel.translatesAutoresizingMaskIntoConstraints = false
        let strangerFriendlyString = NSMutableAttributedString(string: "Stranger friendly: ")
        strangerFriendlyString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: strangerFriendlyString.length))
        if breed!.strangerFriendly % 5 == 0 {
            for _ in 1...5 {
                strangerFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            strangerFriendlyLabel.attributedText = strangerFriendlyString
        } else {
            for i in 1...5 {
                if i <= breed!.strangerFriendly % 5 {
                    strangerFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    strangerFriendlyString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            strangerFriendlyLabel.attributedText = strangerFriendlyString
        }
        strangerFriendlyLabel.sizeToFit()
        
        let energyLevelLabel = UILabel()
        energyLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        let energyLevelString = NSMutableAttributedString(string: "Energy level: ")
        energyLevelString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: energyLevelString.length))
        if breed!.energyLevel % 5 == 0 {
            for _ in 1...5 {
                energyLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            energyLevelLabel.attributedText = energyLevelString
        } else {
            for i in 1...5 {
                if i <= breed!.energyLevel % 5 {
                    energyLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    energyLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            energyLevelLabel.attributedText = energyLevelString
        }
        energyLevelLabel.sizeToFit()
        
        let groomingLabel = UILabel()
        groomingLabel.translatesAutoresizingMaskIntoConstraints = false
        let groomingString = NSMutableAttributedString(string: "Grooming: ")
        groomingString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: groomingString.length))
        if breed!.grooming % 5 == 0 {
            for _ in 1...5 {
                groomingString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            groomingLabel.attributedText = groomingString
        } else {
            for i in 1...5 {
                if i <= breed!.grooming % 5 {
                    groomingString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    groomingString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            groomingLabel.attributedText = groomingString
        }
        groomingLabel.sizeToFit()
        
        let healthIssuesLabel = UILabel()
        healthIssuesLabel.translatesAutoresizingMaskIntoConstraints = false
        let healthIssuesString = NSMutableAttributedString(string: "Health issues: ")
        healthIssuesString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: healthIssuesString.length))
        if breed!.healthIssues % 5 == 0 {
            for _ in 1...5 {
                healthIssuesString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            healthIssuesLabel.attributedText = healthIssuesString
        } else {
            for i in 1...5 {
                if i <= breed!.healthIssues % 5 {
                    healthIssuesString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    healthIssuesString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            healthIssuesLabel.attributedText = healthIssuesString
        }
        healthIssuesLabel.sizeToFit()
        
        let intelligenceLabel = UILabel()
        intelligenceLabel.translatesAutoresizingMaskIntoConstraints = false
        let intelligenceString = NSMutableAttributedString(string: "Intelligence: ")
        intelligenceString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: intelligenceString.length))
        if breed!.intelligence % 5 == 0 {
            for _ in 1...5 {
                intelligenceString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            intelligenceLabel.attributedText = intelligenceString
        } else {
            for i in 1...5 {
                if i <= breed!.intelligence % 5 {
                    intelligenceString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    intelligenceString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            intelligenceLabel.attributedText = intelligenceString
        }
        intelligenceLabel.sizeToFit()
        
        let sheddingLevelLabel = UILabel()
        sheddingLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        let sheddingLevelString = NSMutableAttributedString(string: "Shedding level: ")
        sheddingLevelString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: sheddingLevelString.length))
        if breed!.sheddingLevel % 5 == 0 {
            for _ in 1...5 {
                sheddingLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            sheddingLevelLabel.attributedText = sheddingLevelString
        } else {
            for i in 1...5 {
                if i <= breed!.sheddingLevel % 5 {
                    sheddingLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    sheddingLevelString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            sheddingLevelLabel.attributedText = sheddingLevelString
        }
        sheddingLevelLabel.sizeToFit()
        
        let socialNeedsLabel = UILabel()
        socialNeedsLabel.translatesAutoresizingMaskIntoConstraints = false
        let socialNeedsString = NSMutableAttributedString(string: "Social needs: ")
        socialNeedsString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: socialNeedsString.length))
        if breed!.socialNeeds % 5 == 0 {
            for _ in 1...5 {
                socialNeedsString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            socialNeedsLabel.attributedText = socialNeedsString
        } else {
            for i in 1...5 {
                if i <= breed!.socialNeeds % 5 {
                    socialNeedsString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    socialNeedsString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            socialNeedsLabel.attributedText = socialNeedsString
        }
        socialNeedsLabel.sizeToFit()
        
        let vocalisationLabel = UILabel()
        vocalisationLabel.translatesAutoresizingMaskIntoConstraints = false
        let vocalisationString = NSMutableAttributedString(string: "Vocalisation: ")
        vocalisationString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: vocalisationString.length))
        if breed!.vocalisation % 5 == 0 {
            for _ in 1...5 {
                vocalisationString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
            }
            vocalisationLabel.attributedText = vocalisationString
        } else {
            for i in 1...5 {
                if i <= breed!.vocalisation % 5 {
                    vocalisationString.append(NSAttributedString(attachment: NSTextAttachment(image: circleFill!)))
                } else {
                    vocalisationString.append(NSAttributedString(attachment: NSTextAttachment(image: circle!)))
                }
            }
            vocalisationLabel.attributedText = vocalisationString
        }
        vocalisationLabel.sizeToFit()
        
        let wikipediaUrlLabel = UILabel()
        wikipediaUrlLabel.translatesAutoresizingMaskIntoConstraints = false
        wikipediaUrlLabel.numberOfLines = 0
        wikipediaUrlLabel.text = "URL" // Dirty hack.
        wikipediaUrlLabel.sizeToFit()
        
        let textView = UITextView()
        let attributedString = NSMutableAttributedString(string: "To find more please visit the Wikipedia page.")
        if let url = breed?.wikipediaUrl {
            attributedString.addAttribute(.link, value: url, range: NSRange(location: 0, length: attributedString.mutableString.length))
        } else {
            attributedString.addAttribute(.link, value: "https://en.wikipedia.org/wiki/\(breed?.name.replacingOccurrences(of: " ", with: "_") ?? "https://en.wikipedia.org/wiki")", range: NSRange(location: 0, length: attributedString.mutableString.length))
        }
        textView.attributedText = attributedString
        textView.isEditable = false
        textView.sizeToFit()
        wikipediaUrlLabel.addSubview(textView)
        wikipediaUrlLabel.isUserInteractionEnabled = true
        
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = breed?.description
        descriptionLabel.sizeToFit()
        
        // Add labels to UIStackView.
        stackView.addArrangedSubview(altNameLabel)
        stackView.addArrangedSubview(temperamentLabel)
        stackView.addArrangedSubview(lifeSpanLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(experimentalLabel)
        stackView.addArrangedSubview(hairlessLabel)
        stackView.addArrangedSubview(naturalLabel)
        stackView.addArrangedSubview(rareLabel)
        stackView.addArrangedSubview(rexLabel)
        stackView.addArrangedSubview(suppressedTailLabel)
        stackView.addArrangedSubview(shortLegsLabel)
        stackView.addArrangedSubview(hypoallergenicLabel)
        stackView.addArrangedSubview(adaptabilityLabel)
        stackView.addArrangedSubview(affectionLevelLabel)
        stackView.addArrangedSubview(childFriendlyLabel)
        stackView.addArrangedSubview(dogFriendlyLabel)
        stackView.addArrangedSubview(strangerFriendlyLabel)
        stackView.addArrangedSubview(energyLevelLabel)
        stackView.addArrangedSubview(groomingLabel)
        stackView.addArrangedSubview(healthIssuesLabel)
        stackView.addArrangedSubview(intelligenceLabel)
        stackView.addArrangedSubview(sheddingLevelLabel)
        stackView.addArrangedSubview(socialNeedsLabel)
        stackView.addArrangedSubview(vocalisationLabel)
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
