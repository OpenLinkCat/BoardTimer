//
//  SingleTimerView.swift
//  BoardTimer
//
//  Created by Tiago Maia Lopes on 11/15/17.
//  Copyright © 2017 Tiago Maia Lopes. All rights reserved.
//

import UIKit

enum Theme {
  case white
  case dark
  
  static let colors = [
    white: (bg: UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1),
            labels: UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)),
    dark: (bg: UIColor(red: 52.0/255.0, green: 73.0/255.0, blue: 94.0/255.0, alpha: 1),
           labels: UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1) ),
  ]
  
  func getColors() -> (bg: UIColor, labels: UIColor) {
    return Theme.colors[self]!
  }
}

@IBDesignable
class SingleTimerView: UIView {

  // MARK: Properties
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var progressView: CircleProgressBar!
  @IBOutlet weak var movesLabel: UILabel!
  
  var theme: Theme! {
    didSet {
      apply(theme: theme)
    }
  }
  
  // MARK: Object life cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    if theme == nil {
      theme = .white
    }
  }
  
  // MARK: Imperatives
  
  private func apply(theme: Theme = .white) {
    
    func setColors(for theme: Theme) {
      let colors = theme.getColors()
      
      backgroundColor = colors.bg
      timeLabel.textColor = colors.labels
      progressView.tint = colors.labels
      movesLabel.textColor = colors.labels.faded(by: 0.3)
    }
    
    setColors(for: theme)
  }
  
  func setText(_ time: String) {
    timeLabel.text = time
  }
  
  func setProgress(_ progress: Float) {
    progressView.progress = progress
    progressView.setNeedsDisplay()
  }
  
  func animateIn() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0,
                   options: .curveEaseIn,
                   animations: { [unowned self] in
                    self.timeLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    self.progressView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    self.timeLabel.alpha = 1
                    self.movesLabel.alpha = 1
    })
  }
  
  func animateOut() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0,
                   options: .curveEaseIn,
                   animations: { [unowned self] in
                    self.timeLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    self.progressView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    self.timeLabel.alpha = 0.5
                    self.movesLabel.alpha = 0.5
    })
  }
  
  func animateInitial() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0,
                   options: .curveEaseIn,
                   animations: { [unowned self] in
                    self.timeLabel.transform = .identity
                    self.progressView.transform = .identity
                    self.timeLabel.alpha = 1
                    self.movesLabel.alpha = 1
    })

  }

}