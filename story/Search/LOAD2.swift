//
//  LOAD2.swift
//  story
//
//  Created by 李彤 on 2023/10/28.
//

import UIKit

class LOAD2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: false)
        DataProvider().loadSearchData()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ timer in
            print(dataArrary)
            self.performSegue (withIdentifier: "load2", sender: self)
        }
    }
}
