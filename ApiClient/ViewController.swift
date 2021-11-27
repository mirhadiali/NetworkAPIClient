//
//  ViewController.swift
//  ApiClient
//
//  Created by Hadi on 02/10/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didTapTest(_ sender: Any) {
        AuthInteractor.shared.getUsers { (user, error) in
            print(user)
            print(error)
        }
    }
}
