//
//  HomeViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SDWebImage
import SugarRecord
import UIView_TouchHighlighting
import REFrostedViewController

class HomeViewController: UIViewController {
    
    @IBOutlet weak var accountProfileImageView: UIImageView!
    @IBOutlet weak var menuToggleItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
        
        menuToggleItem.customView?.touchHighlightingStyle = .TransparentMask
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let account = try! defaultAccount()!
        accountProfileImageView.displayImage(account.user!.profileImageUrl, placeholder: UIImage(named: "Profile Image Default"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeClicked(sender: UIBarButtonItem) {
        ComposeController.show(self, identifier: "Compose")
    }
    
    @IBAction func menuToggleClicked(sender: UITapGestureRecognizer) {
           frostedViewController.presentMenuViewController()
    }
    
    @IBAction func panGestureRecognized(sender: UIPanGestureRecognizer) {
        frostedViewController.panGestureRecognized(sender)
    }
}