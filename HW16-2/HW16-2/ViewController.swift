//
//  ViewController.swift
//  HW16-2
//
//  Created by Artem Mazurkevich on 25.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onPresentSimpleAlert(_ sender: Any) {
        presentAlert(title: "Simple alert", message: "Nunc volutpat augue et diam semper, non auctor libero lacinia.", okButtonText: "OK")
    }
    
    @IBAction func onPresentAdvancedAlert(_ sender: Any) {
        presentAlert(title: "Advanced alert", message: "Nunc volutpat augue et diam semper, non auctor libero lacinia.", okButtonText: "OK", cancelButtonText: "Cancel")
    }
}

