//
//  LOAD4.swift
//  story
//
//  Created by 李彤 on 2023/10/30.
//

import UIKit

class LOAD4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
            self.performSegue (withIdentifier: "goback", sender: self)
        }
    }

}
