//
//  PersonViewController.swift
//  StarWars
//
//  Created by LAURA JELENICH on 9/24/20.
//

import UIKit

class PersonViewController: UIViewController {
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textView = [UITextView]()
    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        fetchPerson()
    }
    
    func fetchPerson() {
        guard let id = numberTextField.text else { return }
        PersonController.shared.fetchPerson(id: id) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let person):
                    for url in person.films {
                        PersonController.fetchFilm(url: url) { (result) in
                            switch result {
                            
                            case .success(let film):
                                DispatchQueue.main.async {
                                    self.detailTextView.text = "Hello I'm \(person.name). You may have seem me in \(film.title)"
                                    print(film.title)
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

