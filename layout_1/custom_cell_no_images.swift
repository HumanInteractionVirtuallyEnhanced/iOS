//
//  custom_cell_no_images.swift
//  layout_1
//
//  Created by Rijul Gupta on 3/20/15.
//  Copyright (c) 2015 Rijul Gupta. All rights reserved.
//


import UIKit



class custom_cell_no_images: UITableViewCell{
    
    @IBOutlet var heart_label: UILabel!
    @IBOutlet var comment_label: UILabel!
    @IBOutlet var author_label: UILabel!
    @IBOutlet var heart_icon: UIImageView!
    @IBOutlet var loc_label: UILabel!
    @IBOutlet var time_label:UILabel!
    @IBOutlet var userImage:UIImageView!
    @IBOutlet var shareButton:UIImageView!
    @IBOutlet var shareLabel:UILabel!
    
    @IBOutlet var buttonHolder:UIView!
    @IBOutlet var comHolder:UIView!
    @IBOutlet var comHolderHolder:UIView!
    
    @IBOutlet var replyButtonLabel: UILabel!
    @IBOutlet var replyButtonImage: UIImageView!
    @IBOutlet var replyNumLabel: UILabel!
    
    @IBOutlet var likerButtonLabel:UILabel!
    @IBOutlet var likerButtonHolder:UIView!
    
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    var comment_id = "nil"
    var user_id = "nil"
    var imageLink = "none"
    
    var urlLink = "none"
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        
        
        //        if(imageLink == "none"){
        //            //xcomImage.removeFromSuperview()
        //            //            /http://i.imgur.com/qG8Pg55.jpg
        //            let url = NSURL(string: "http://i.imgur.com/ckSBw57.jpg")
        //            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        //            comImage.image = UIImage(data: data!)
        //        }
        //        else{
        //
        //            let url = NSURL(string: imageLink)
        //            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        //            comImage.image = UIImage(data: data!)
        //
        //
        //        }
        
        self.comment_label.numberOfLines = 0
        self.comment_label.sizeToFit()
        
        
        
        userImage.layer.borderWidth=0.0
        userImage.layer.masksToBounds = false
        // postLabelHolder.layer.borderColor = color.CGColor//UIColor.blackColor().CGColor
        // userImage.frame = CGRectMake(20, 20, 40, 40)
        userImage.layer.cornerRadius = userImage.layer.frame.width/2
        userImage.clipsToBounds = true
        
       
        
        
        
        let color: UIColor = UIColor( red: CGFloat(51.0/255.0), green: CGFloat(51.0/255.0), blue: CGFloat(51.0/255.0), alpha: CGFloat(0.2) )
        
        let color2: UIColor = UIColor( red: CGFloat(200.0/255.0), green: CGFloat(200.0/255.0), blue: CGFloat(230.0/255.0), alpha: CGFloat(1.0) )
        
        comHolder.layer.borderWidth = 0.0
        comHolder.layer.borderColor = UIColor.blackColor().CGColor
        comHolder.layer.masksToBounds = false
        comHolder.layer.cornerRadius = 4
        comHolder.clipsToBounds = true
        
        
        comHolderHolder.layer.shadowColor = color2.CGColor
        comHolderHolder.layer.shadowOffset = CGSizeMake(0, 0)
        comHolderHolder.layer.shadowRadius = 2
        comHolderHolder.layer.shadowOpacity = 0.2
        
        
//        buttonHolder.layer.borderWidth=1.0
//        buttonHolder.layer.masksToBounds = false
//        buttonHolder.layer.borderColor = color.CGColor//UIColor.blackColor().CGColor
//        
//        
    }
    //
    //    override func prepareForReuse() {
    //        super.prepareForReuse()
    //        self.comImage = nil
    //
    //    }
    
    //    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        
        // Configure the view for the selected state
    }
    
}