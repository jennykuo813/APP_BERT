//
//  LOAD.swift
//  story
//
//  Created by 李彤 on 2023/10/27.
//

import UIKit

class LOAD: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        DataProvider().loadData()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
            print(dataArrary)
            self.performSegue (withIdentifier: "load", sender: self)
        }
    }
}
