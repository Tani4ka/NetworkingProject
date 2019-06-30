//
//  RequestsViewController.swift
//  Les_11_Networking
//
//  Created by Tetiana Hranchenko on 6/21/19.
//  Copyright © 2019 Canux Corporation. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet weak var getUrlTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        getUrlTextField.delegate = self
    }

    @IBAction func postAction() {
        let dictionary = ["userId": 1, "id": 11, "title": "Twitter ok", "body": "I think not"]
            as [String: Any]

        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {

            let urll = NSURL(string: "http://jsonplaceholder.typicode.com/posts")!
            let request = NSMutableURLRequest(url: urll as URL)

            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if error != nil {
//                    print(error?.localizedDescription)
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        as? NSDictionary

                    if let parseJson = json {
//                        let result: String = parseJson["success"] as! String;
                        print("result: \(String(describing: response))")
                        print(parseJson)
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }
    }

    @IBAction func download() {
        // получить папку documents симулятора

        let documentsUrl: URL = FileManager.default.urls(for:
            .documentDirectory, in: .userDomainMask).first ?? URL(fileURLWithPath: "")

        // название файла который мы будем сохранять
        let destinationFileUrl = documentsUrl.appendingPathComponent("downloadFile.jpg")

        let fileUrl = URL(string: "https://www.w3schools.com/css/img_lights.jpg")

        // создание сессии
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self,
                                 delegateQueue: OperationQueue.main)

        let request = URLRequest(url: fileUrl!)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully download. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    // remove downloaded file
//                    try FileManager.default.removeItem(at: destinationFileUrl)
                } catch let writeError {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
//                print("Error took place with downloading a file. Error description: %@",
//                      error?.localizedDescription)
            }
        }
        task.resume()
    }
}

// URLSessionDownloadDelegate - можно отслеживать процесс скачивания
extension RequestsViewController: URLSessionDownloadDelegate {

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        print("finished")
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {

        print("bytesWritten \(bytesWritten), totalBytesExpectedToWrite \(totalBytesExpectedToWrite)")
    }
}

extension RequestsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\(String(describing: textField.text))")

        if let string = textField.text, let number = Int(string) {
            print(number)
            var urll = URL(string: Constants.Networking.posts)
            urll?.appendPathComponent("\(number)")

            if let getURL = urll {
                RequestManager.getUrl(urll: getURL)
            }
        }
        textField.text = nil
        textField.resignFirstResponder() // убрать клавиатуру

        return true
    }
}
