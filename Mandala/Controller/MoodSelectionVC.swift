//
//  ViewController.swift
//  Mandala
//
//  Created by Abdulaziz Alfayaa on 07/01/2022.
//

import UIKit

class MoodSelectionVC: UIViewController {
    
    @IBOutlet var moodSelector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!
    @IBOutlet var appVersion: UILabel!
    
    var moodsConfigurable: MoodsConfigurable!
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton.setTitle(nil, for: .normal)
                addMoodButton.backgroundColor = nil
                return
            }
            addMoodButton.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton.backgroundColor = currentMood.color
        }
    }
    
    @IBAction private func moodSelectionChanged(_ sender: ImageSelector){
        let selectedIndex = sender.selectedIndex
        
        currentMood = moods[selectedIndex]
//        print("Current Mood: \(currentMood?.name)")

    }
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            
            moodSelector.images = moods.map({$0.image})
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        moods = [.normal, .happy, .sad, .angry, .fun]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
        if let version = Bundle.main.version, let appDisplayName = Bundle.main.displayName {
            appVersion.text = "\(appDisplayName) v\(version)"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addMoodTapped(_ sender: UIButton){
        guard let currentMood = currentMood else {
            return
        }
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        
        moodsConfigurable.add(newMoodEntry)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure("View controller expected to conform to MoodsConfigurable protocol")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    

}

