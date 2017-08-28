//
//  MainNavigationController.swift
//  mHealth
//
//  Created by Abe Rodriguez on 4/2/17.
//  Copyright © 2017 ___AbeRodriguez___. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "Pin", sender: self)
    }
}// End of MainNavigationController()
