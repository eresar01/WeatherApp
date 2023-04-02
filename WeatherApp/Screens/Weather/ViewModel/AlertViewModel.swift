//
//  AlertViewModel.swift
//  WeatherApp
//
//  Created by Yerem Sargsyan on 02.04.23.
//

import Foundation
import UIKit

struct AlertViewModel {
    
    func simpleAlert(_ target: UIViewController, title: String? = "", message: String? = "", firstActionTitle: String? = "", secondActionTitle: String? = "", completionFirst: (() -> Void)?, completionSecond: (() -> Void)?) {
        
        let alertController = UIAlertController (title: title, message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: firstActionTitle, style: .default) { (_) -> Void in
            completionFirst?()
        }
        
        alertController.addAction(action1)
        
        let action2 = UIAlertAction(title: secondActionTitle, style: .default) { (_) -> Void in
            completionSecond?()
        }
        
        alertController.addAction(action2)
        target.present(alertController, animated: true, completion: nil)
    }
}
