//
//  LiveStreamButton.swift
//  FammiActor
//

import UIKit

class LiveStreamButton: XibView {

    @IBOutlet weak var liveStreamLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        liveStreamLabel.text = ""
    }
    
    //MARK: Actions
    @IBAction func onLiveClicked(_ sender: UIButton) {
    }
}
