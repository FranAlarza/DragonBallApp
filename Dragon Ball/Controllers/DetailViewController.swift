//
//  DetailViewController.swift
//  Dragon Ball
//
//  Created by Fran Alarza on 11/7/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var heroDescription: UITextView!
    
    private var hero: Hero?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let hero = hero else {
            return
        }
        
        heroImage.downloadImage(from: hero.photo)
        heroName.text = hero.name
        heroDescription.text = hero.description
    }
    
    
    
    func setModel(model: Hero) {
        hero = model
    }


    @IBAction func onTapButton(_ sender: Any) {
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
