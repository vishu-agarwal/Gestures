//
//  ViewController.swift
//  Gestures
//
//  Created by DCS on 05/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let myImg: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        
        img.clipsToBounds = true
        img.image = UIImage(named: "plus")
        img.frame = CGRect(x: 100, y: 250, width: 150, height: 150 )
        return img
    }()
    
    private let imgpicker : UIImagePickerController = {
        let img = UIImagePickerController()
        img.allowsEditing = false
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Image-Gesture"
        view.addSubview(myImg)
        imgpicker.delegate = self
//        let alert = UIAlertController(title: "Note", message: "Please 1st select image  By click on [+] button !!", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alert,animated: true,completion: nil)
        
        //tap it
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapfunc))
        tapGes.numberOfTapsRequired = 3
        tapGes.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGes)
        
        //rotation
        
        let rotateGes = UIRotationGestureRecognizer(target: self, action: #selector(rotateFunc))
        view.addGestureRecognizer(rotateGes)
        
        // swipe
        
        let lSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipefunc))
        lSwipe.direction = .left
        view.addGestureRecognizer(lSwipe)
        
        let rSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipefunc))
        rSwipe.direction = .right
        view.addGestureRecognizer(rSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipefunc))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipefunc))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        //pangesture

     //   let panGes = UIPanGestureRecognizer(target: self, action:  #selector(panfunc))
     //   view.addGestureRecognizer(panGes)
        
        //pinchgesture
        
        let pinchGes = UIPinchGestureRecognizer(target: self, action: #selector(pinchfunc))
        view.addGestureRecognizer(pinchGes)

        // Do any additional setup after loading the view.
    }
    

}
extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedimg = info[.originalImage] as? UIImage{
            myImg.image = selectedimg
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    @objc private func tapfunc(_ gesture:UITapGestureRecognizer)
    {
        
        imgpicker.sourceType = .photoLibrary
        DispatchQueue.main.async{
            self.present(self.imgpicker,animated: true)
        }
        print("location::: \(gesture.location(in: view))")
        
    }
    
    @objc private func pinchfunc(_ gesture: UIPinchGestureRecognizer)
    {
        print ("Pinch")
        myImg.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    @objc private func rotateFunc(_ gesture: UIRotationGestureRecognizer)
    {
        print("Rotate")
        myImg.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func swipefunc(_ swipe: UISwipeGestureRecognizer)
    {
        if swipe.direction == .left {
            UIView.animate(withDuration: 0.3) {
                print("left")
                self.myImg.frame = CGRect(x: self.myImg.frame.origin.x - 30, y: self.myImg.frame.origin.y , width: 300, height: 300 )                }
        }
        else if swipe.direction == .right{
            UIImageView.animate(withDuration: 0.3) {
                self.myImg.frame = CGRect(x: self.myImg.frame.origin.x + 30, y: self.myImg.frame.origin.y, width: 300, height: 300 )                }
        }
        else if swipe.direction == .up{
            UIImageView.animate(withDuration: 0.3) {
                self.myImg.frame = CGRect(x: self.myImg.frame.origin.x, y: self.myImg.frame.origin.y - 30, width: 300, height: 300 )                }
        }
        else if swipe.direction == .down{
            UIImageView.animate(withDuration: 0.3) {
                self.myImg.frame = CGRect(x: self.myImg.frame.origin.x, y: self.myImg.frame.origin.y + 30, width: 300, height: 300 )                }
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "Direction not Detected !!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert,animated: true,completion: nil)        }
    }
    @objc private func panfunc(_ pan: UIPanGestureRecognizer)
    {
       let x = pan.location(in: view).x
        let y = pan.location(in: view).y

     myImg.center = CGPoint(x: x, y: y)
    }
}

