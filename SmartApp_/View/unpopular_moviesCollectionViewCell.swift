//
//  unpopular_moviesCollectionViewCell.swift
//  SmartApp_Demo
//
//  Created by MOKSHA on 05/02/22.
//

import UIKit

class unpopular_moviesCollectionViewCell: UICollectionViewCell , UIGestureRecognizerDelegate {

    @IBOutlet weak var Details: UIView!
    @IBOutlet weak var Posterimgview: UIImageView!
    @IBOutlet weak var Movietitlelbl: UILabel!
    @IBOutlet weak var Overviewlbl: UILabel!
    var pan: UIPanGestureRecognizer!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
           pan.delegate = self
           self.addGestureRecognizer(pan)
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) {
        let p: CGPoint = pan.translation(in: self)
        let width = self.contentView.frame.width
        let height = self.contentView.frame.height
        self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
       }

    }
    
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
         self.setNeedsLayout()
       } else {
         if abs(pan.velocity(in: self).x) > 500 {
           let collectionView: UICollectionView = self.superview as! UICollectionView
           let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
           collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
         } else {
           UIView.animate(withDuration: 0.2, animations: {
             self.setNeedsLayout()
             self.layoutIfNeeded()
           })
         }
       }
     }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
    }
}
