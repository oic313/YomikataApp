//
//  InputViewController.swift
//  YomikataApp
//
//  Created by K.N on 2019/10/08.
//  Copyright © 2019 K.N. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InputViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    var result: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeButton.isEnabled = false
        inputTextView.delegate = self
        inputTextView.text = ""
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        HttpRequest()
    }
    
    private func HttpRequest() {
        if let text = inputTextView.text{
            let url = "https://labs.goo.ne.jp/api/hiragana"
            let headers: HTTPHeaders = [
                "Contenttype": "application/json"
            ]
            let parameters:[String: Any] = [
                "app_id": "ひらがな化APIのアプリケーションID",
                "sentence": text,
                "output_type": "hiragana"
            ]

            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let text = "\(json["converted"])"
                    
                    if text != "null"{
                        self.result = text
                        //segueを呼び出す
                        self.performSegue(withIdentifier: "toOutput", sender: nil)
                    }else{
                        self.inputTextView.text = "ひらがな化APIのアプリケーションIDに誤りがあります。\n開発者にお問い合わせください。"
                    }
                    
                }else{
                    self.inputTextView.text = "ネットワークに接続してください"
                }
            }
        }
    }
    
    //segueが呼ばれた時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        //segueのidentifireがtoResultだった場合の処理
        if identifier == "toOutput"{
            //segue.destinationで遷移先のクラスを取得できる
            let resultVC = segue.destination as! OutputViewController
            resultVC.text = self.result
        }
    }
    
    //inputTextViewの外を押したら、キーボードを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.inputTextView.isFirstResponder) {
            self.inputTextView.resignFirstResponder()
        }
    }
    
    //改行時キーボードを閉じる処理
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            inputTextView.resignFirstResponder()
            return false
        }
        return true
    }

    //inputTextView変更時
    func textViewDidChange(_ textView: UITextView) {
        let text = inputTextView.text ?? ""
        changeButton.isEnabled = !text.isEmpty
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
