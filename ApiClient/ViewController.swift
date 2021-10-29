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
//        NetworkRequest.callAPI(request: TestApiClient.getUserByID(id: 1)) { (response) in
//            guard var response = NetworkRequest.mapData(data: response, castTo: User.self) else {
//                return
//            }
//            print(response)
//        }
        NetworkRequest.callAPI(request: TestApiClient.getUsers) { (response) in
            guard var response = NetworkRequest.mapData(data: response, castTo: Users.self) else {
                return
            }
            print(response)
        }
    }
}

