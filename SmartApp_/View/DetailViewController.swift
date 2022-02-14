//
//  DetailViewController.swift
//  SmartApp_
//
//  Created by MOKSHA on 08/02/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var DetailsPosterimgview: UIImageView!
    var urlstring = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "Color")
        if self.urlstring != nil {
            self.DetailsPosterimgview.loadRemoteImageFrom(urlString:self.urlstring)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    
}

public extension UIColor {

    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
        }
        else {
            self.init(cgColor: light.cgColor)
        }
    }
}
