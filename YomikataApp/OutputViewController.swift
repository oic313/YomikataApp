//
//  OutputViewController.swift
//  YomikataApp
//
//  Created by K.N on 2019/10/08.
//  Copyright © 2019 K.N. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {

    @IBOutlet weak var outputTextView: UITextView!
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outputTextView.text = self.text
    }

    @IBAction func returnButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
