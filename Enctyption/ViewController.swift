//
//  ViewController.swift
//  Enctyption
//
//  Created by Hong Hoa on 11/4/16.
//  Copyright © 2016 nhd. All rights reserved.
//

import UIKit
import RNCryptor

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let file = "file.txt" //this is the file. we will write to and read from it
        
        let encryptFile = "encrypt.txt"
        
        let decryptFile = "decrypt.txt"
        
        let text = "some text" //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            let encryptPath = dir.appendingPathComponent(encryptFile)
            let decryptPath = dir.appendingPathComponent(decryptFile)
            
            //writing
//            do {
//                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
//            }
//            catch {/* error handling here */}
            
            //reading
            do {
                let plainText = try String(contentsOf: path, encoding: String.Encoding.utf8)
                
                let data = plainText.data(using: .utf8)
                let password = "Secret password"
                let ciphertext = RNCryptor.encrypt(data: data! as Data, withPassword: password)
                
                
                
                do {
                    try ciphertext.write(to: encryptPath)
                }
                catch {/* error handling here */}
                
            }
            catch {/* error handling here */}
            
            //reading
            do {
                let cipherData = try Data(contentsOf: encryptPath)
                
                //let data = ciphertext.data(using: .utf8)
                let password = "Secret password"
                
                // Decryption
                do {
                    let originalData = try RNCryptor.decrypt(data: cipherData , withPassword: password)
                    let plainText = String(data: originalData, encoding: String.Encoding.utf8)
                    
                    do {
                        try plainText?.write(to: decryptPath, atomically: false, encoding: String.Encoding.utf8)
                    }
                    catch {/* error handling here */}
                    // ...
                } catch {
                    print(error)
                }
                
            }
            catch {/* error handling here */}
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

