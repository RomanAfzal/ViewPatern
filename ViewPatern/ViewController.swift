//
//  ViewController.swift
//  ViewPatern
//
//  Created by RomanAfzal on 14/03/2024.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var testView: UIView!
  @IBOutlet weak var testView2: UIView!
  @IBOutlet weak var testView3: UIView!
  @IBOutlet weak var testView4: UIView!
  @IBOutlet weak var testView5: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()


    testView.backgroundColor = UIColor.polkaDotPattern(color: .blue, dotSize: 10, spacing: 5)

    testView2.backgroundColor = UIColor.red.patternStripes(barThickness: 20,orientation: .downDiagonal)
    testView3.backgroundColor = UIColor.red.patternStripes(barThickness: 20,orientation: .upDiagonal)
    testView4.backgroundColor = UIColor.red.patternStripes(barThickness: 20,orientation: .vertical)
    testView5.backgroundColor = UIColor.red.patternStripes(barThickness: 20,orientation: .horizontal)
  }


}





extension UIColor {
  static func polkaDotPattern(color: UIColor, dotSize: CGFloat, spacing: CGFloat) -> UIColor {
    let imageSize = CGSize(width: dotSize + spacing, height: dotSize + spacing)

    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    defer { UIGraphicsEndImageContext() }

    let context = UIGraphicsGetCurrentContext()!
    context.setFillColor(color.cgColor)

    let dotRect = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)

    for y in stride(from: 0, to: imageSize.height, by: dotSize + spacing) {
      for x in stride(from: 0, to: imageSize.width, by: dotSize + spacing) {
        context.fillEllipse(in: dotRect.offsetBy(dx: x, dy: y))
      }
    }

    return UIColor(patternImage: UIGraphicsGetImageFromCurrentImageContext()!)
  }

  enum StripeOrientation {
          case vertical
          case horizontal
          case upDiagonal
          case downDiagonal
      }
  func patternStripes(color2: UIColor = .white,barThickness t: CGFloat = 25.0 ,orientation:StripeOrientation) -> UIColor {
         let dim: CGFloat = t * 2.0 * sqrt(2.0)

         let img = UIGraphicsImageRenderer(size: .init(width: dim, height: dim)).image { context in

             // rotate the context and shift up
           if orientation == .horizontal{
             context.cgContext.rotate(by: CGFloat(Double.pi*0/180))
             context.cgContext.translateBy(x: 0.0, y: -2.0 * t)

           }else if orientation == .vertical{
             context.cgContext.rotate(by: CGFloat(Double.pi*90/180))
             context.cgContext.translateBy(x: 0.0, y: -2.0 * t)

           }else if orientation == .upDiagonal{
             context.cgContext.rotate(by: CGFloat(Double.pi*45/180))
             context.cgContext.translateBy(x: 0.0, y: -2.0 * t)

           }else if orientation == .downDiagonal{
             context.cgContext.rotate(by: CGFloat(Double.pi*135/180))
           context.cgContext.translateBy(x:-2.0 * t, y: -t*3)

           }else{

           }
//             context.cgContext.rotate(by: CGFloat(Double.pi*135/180))
//           context.cgContext.translateBy(x:-2.0 * t, y: -t*3)

           let bars: [(UIColor,UIBezierPath)] = [
               (self,  UIBezierPath(rect: .init(x: 0.0, y: 0.0, width: dim * 2.0, height: t)))
         ]


           bars.forEach {  $0.0.setFill(); $0.1.fill() }

           // move down and paint again
           context.cgContext.translateBy(x: 0, y: 2.0 * t)
             bars.forEach {  $0.0.setFill(); $0.1.fill() }
         }

         return UIColor(patternImage: img)
     }
}
