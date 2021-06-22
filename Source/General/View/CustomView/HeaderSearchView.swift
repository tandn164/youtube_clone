//
//  HeaderSearchView.swift
//  FammiUser
//
//  Created by DuyPc on 12/17/20.
//  Copyright © 2020 SotaTek. All rights reserved.
//

import UIKit

class HeaderSearchView:  XibView {
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textTitleHeader: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func setTitleHeader(title: String) {
        self.textTitleHeader.text = title
    }
    
    func setupNavBarByScroll(contentOffset: CGFloat) {
        backgroundColor = AppResources.Color.prinkNavbar.withAlphaComponent(contentOffset)
        if contentOffset >= 0.25 {
            setupNavButtons(status: false)
        } else {
            setupNavButtons(status: true)
        }
    }
    
    func setupNavButtons(status: Bool) {
        if status {
            
        } else {
            
        }
    }
    
    @IBAction func onProfileButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
    }
}
