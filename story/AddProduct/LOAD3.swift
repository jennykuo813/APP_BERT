//
//  LOAD3.swift
//  story
//
//  Created by 李彤 on 2023/10/28.
//

import UIKit

class LOAD3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: false)
        NewDataProvider().loadNewData()
        DataProvider().loadData()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
            self.performSegue (withIdentifier: "load3", sender: self)
        }
    }
}
