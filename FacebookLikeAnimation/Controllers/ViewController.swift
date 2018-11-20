//
//  ViewController.swift
//  FacebookLikeAnimation
//
//  Created by MACBOOK PRO RETINA on 18/11/2018.
//  Copyright © 2018 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    let iconContainerView = UIView()
    let padding : CGFloat = 6
    let iconHeight: CGFloat = 38
    
    @IBOutlet weak var LikeImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
    }
    
    func SetupView() {
        iconContainerView.backgroundColor = UIColor.white
        LikeImg.tintColor = UIColor.gray
        let arrangedSubviews = [#imageLiteral(resourceName: "like"),#imageLiteral(resourceName: "love"),#imageLiteral(resourceName: "sad"),#imageLiteral(resourceName: "angry"),#imageLiteral(resourceName: "wow"),#imageLiteral(resourceName: "haha")].map({ (image) -> UIImageView in
            let imgView = UIImageView(image: image)
            imgView.layer.cornerRadius = iconHeight / 2
            imgView.isUserInteractionEnabled = true
            return imgView
        })
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        iconContainerView.addSubview(stackView)
        let numIcons = CGFloat(arrangedSubviews.count)
        let widthContainerView = numIcons * iconHeight + (numIcons + 1) * padding
        iconContainerView.frame = CGRect(x: 0, y: 0, width: widthContainerView, height: iconHeight + 2*padding)
        iconContainerView.layer.cornerRadius = iconContainerView.frame.height / 2
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.frame = iconContainerView.frame
        self.LikeImg.isUserInteractionEnabled = true
        self.LikeImg.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        self.LikeImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleNormalPress)))
        self.LikeImg.gestureRecognizers![0].delegate = self
        self.LikeImg.gestureRecognizers![1].delegate = self
    }

    
    @objc func handleNormalPress(gesture: UITapGestureRecognizer)
    {
        if (LikeImg.tintColor == UIColor.gray) {
            LikeImg.image = #imageLiteral(resourceName: "like-template")
            LikeImg.tintColor = UIColor.blue
        } else {
            LikeImg.image = #imageLiteral(resourceName: "like-template")
            LikeImg.tintColor = UIColor.gray
        }
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer)
    {
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            /*UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.iconContainerView.subviews.first
                stackView?.subviews.forEach({ (image)  in
                    if image.frame.origin.y != 6
                    {
                            self.LikeImg.image = image.asImage()
                        
                    }
                    image.transform = .identity
                })
                self.iconContainerView.transform = CGAffineTransform(translationX: self.iconContainerView.frame.origin.x, y: self.iconContainerView.frame.origin.y + 10)
                self.iconContainerView.alpha = 0
                
            },completion: { (_) in
                self.iconContainerView.removeFromSuperview()
            })*/
            
        } else if gesture.state == .changed {
            handleGestureChanges(gesture: gesture)
        }
    }
    
    func handleGestureChanges(gesture: UILongPressGestureRecognizer)
    {
        let hitTestView = iconContainerView.hitTest(gesture.location(in: iconContainerView), with: nil)
        if hitTestView is UIImageView {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                /*let stackView = self.iconContainerView.subviews.first
                stackView?.subviews.forEach({ (image)  in
                    image.transform = .identity
                })*/
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -10)
            })
        }
    }
    
    func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconContainerView)
        let pressedLocation = gesture.location(in: self.view)
        self.iconContainerView.transform = CGAffineTransform(translationX: LikeImg.frame.origin.x, y: pressedLocation.y)
        iconContainerView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.iconContainerView.alpha = 1
            self.iconContainerView.transform = CGAffineTransform(translationX: self.LikeImg.frame.origin.x, y: pressedLocation.y - self.iconContainerView.frame.height)
        })
    }
    
    


}



