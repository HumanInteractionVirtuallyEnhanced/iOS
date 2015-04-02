//
//  MyProfileViewController.swift
//  layout_1
//
//  Created by Rijul Gupta on 3/12/15.
//  Copyright (c) 2015 Rijul Gupta. All rights reserved.
//


import UIKit


//http://graph.facebook.com/xUID/picture?width=720&height=720
class MyProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FBLoginViewDelegate, UIGestureRecognizerDelegate {
    
    
    @IBOutlet var fbLoginView : FBLoginView!
    @IBOutlet var profilePic: UIImageView!
    
    //@IBOutlet var loadingScreen: UIImageView!
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var navBar:UINavigationBar!
    @IBOutlet var navTitle:UINavigationItem!
    @IBOutlet var postLabelHolder: UIView!
    
    
    @IBOutlet var locLable:UILabel!
    @IBOutlet var timeLabel:UILabel!
    @IBOutlet var followersName:UILabel!
    @IBOutlet var followersLabel:UILabel!
    @IBOutlet var followingName:UILabel!
    @IBOutlet var followingLabel:UILabel!
    //let transportItems = ["Bus","Helicopter","Truck","Boat","Bicycle","Motorcycle","Plane","Train","Car","Scooter","Caravan"]
    
    let leftHandItems: [String] = ["","Last Check In", "Posts", "Followers", "Following"]
    
    var rightHandItems: [String] = ["","@This Place", "250", "92", "99"]
    
     var theJSON: NSDictionary!
    var hasLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //titleItem.title = "TESTING"
        
        var url = NSBundle.mainBundle().URLForResource("loader", withExtension: "gif")
        var imageData = NSData(contentsOfURL: url!)
        
        // Returns an animated UIImage
        
       //self.navBar.topItem.title = "SDKFJ"

     navTitle.title = "My Profile"
        //var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("reload_table"), userInfo: nil, repeats: false)
        
        
        
       tableView.tableFooterView = UIView(frame: CGRectZero)
        
        self.tableView.rowHeight = tableView.frame.height/5
        
        
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        
        let color: UIColor = UIColor( red: CGFloat(255.0/255.0), green: CGFloat(217.0/255.0), blue: CGFloat(0.0/255.0), alpha: CGFloat(1.0) )
        
        postLabelHolder.layer.borderWidth=2.0
        postLabelHolder.layer.masksToBounds = false
        postLabelHolder.layer.borderColor = color.CGColor//UIColor.blackColor().CGColor
        
        //profilePic.layer.cornerRadius = 13
        postLabelHolder.clipsToBounds = true
        
        
        let followingTap = UITapGestureRecognizer(target: self, action:Selector("showFollowing"))
        // 4
        followingTap.delegate = self
        followingLabel.userInteractionEnabled = true
        followingLabel.addGestureRecognizer(followingTap)
        followingName.userInteractionEnabled = true
        followingName.addGestureRecognizer(followingTap)
        
        
        
        let followersTap = UITapGestureRecognizer(target: self, action:Selector("showFollowers"))
        // 4
        followersTap.delegate = self
        followersLabel.userInteractionEnabled = true
        followersLabel.addGestureRecognizer(followersTap)
        followersName.userInteractionEnabled = true
        followersName.addGestureRecognizer(followersTap)
        
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        getUserPicture()
        self.getUserInfo()
        // removeLoadingScreen()
    }
    
    func getUserPicture(){
    
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbid = defaults.stringForKey("saved_fb_id") as String!
        
        let url = NSURL(string: "http://graph.facebook.com/\(fbid)/picture?width=200&height=200")
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        profilePic.image = UIImage(data: data!)
        

//        
    }
    
//    func removeLoadingScreen(){
//        
//        UIView.animateWithDuration(0.3, animations: {
//            //            self.myFirstLabel.alpha = 1.0
//            //            self.myFirstButton.alpha = 1.0
//            //            self.mySecondButton.alpha = 1.0
//            self.loadingScreen.alpha = 0.0
//        })
//        
//    }
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        
//        println("SLKDJF:LSKDJF:LKDJSF:KLSDFLKJ")
//        
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func did_press_karma(){
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let karmaView = mainStoryboard.instantiateViewControllerWithIdentifier("karma_scene_id") as KarmaViewController
        

        self.presentViewController(karmaView, animated: true, completion: nil)
        
    }
    
    func did_press_logout(){
        
        FBSession.activeSession().closeAndClearTokenInformation()
        let defaults = NSUserDefaults.standardUserDefaults()
        //let fbid = defaults.stringForKey("saved_fb_id") as String!
        defaults.removeObjectForKey("saved_fb_id")
        
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        //let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("test_view_switcher") as UIViewController
        let mainView = mainStoryboard.instantiateViewControllerWithIdentifier("fb_login_scene_id") as UIViewController
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        self.presentViewController(mainView, animated: false, completion: nil)
        
    }
    
    
    
    //pragma mark - table view

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //make sure the json has loaded before we do anything
       return 5
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("profile_cell") as profile_cell

        return cell
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
     
    }
    
    
    
    //User info buttons
    
    func showFollowers(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let friendView = mainStoryboard.instantiateViewControllerWithIdentifier("user_friends_scene_id") as UserFriendsViewController
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbid = defaults.stringForKey("saved_fb_id") as String!
        
        
        friendView.ajaxRequestString = "followers"
        friendView.userFBID = fbid
        // self.dismissViewControllerAnimated(true, completion: nil)
        
        self.presentViewController(friendView, animated: true, completion: nil)
    }
    
    func showFollowing(){
        
        println("SLDKFJLS:DKFJLS:DKFSDF")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let friendView = mainStoryboard.instantiateViewControllerWithIdentifier("user_friends_scene_id") as UserFriendsViewController
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbid = defaults.stringForKey("saved_fb_id") as String!
        
        
        friendView.ajaxRequestString = "following"
        friendView.userFBID = fbid
        // self.dismissViewControllerAnimated(true, completion: nil)
        
        self.presentViewController(friendView, animated: true, completion: nil)
        
    }
    //AJAX
    
    func getUserInfo(){
        
        let url = NSURL(string: "http://groopie.pythonanywhere.com/mobile_get_user_info")
        //START AJAX
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let fbid = defaults.stringForKey("saved_fb_id") as String!
        
        var params = ["fb_id":fbid] as Dictionary<String, String>
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
            
            
            
            //self.theJSON = NSJSONSerialization.JSONObjectWithData(json, options:.MutableLeaves, error: &err) as? NSDictionary
            
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                println(err!.localizedDescription)
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                
                
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                
                
                
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    
                    
//                    self.rightHandItems[1] = ""
                    // let leftHandItems: [String] = ["","Last Check In", "Posts", "Followers", "Following"]
                    self.rightHandItems[1] = parseJSON["results"]![0]["lastLoc"] as String! ?? ""
                    self.rightHandItems[2] = parseJSON["results"]![0]["comments"] as String! ?? ""
                    self.rightHandItems[3] = parseJSON["results"]![0]["followers"] as String! ?? ""
                    self.rightHandItems[4] = parseJSON["results"]![0]["following"] as String! ?? ""
           
                   
   
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.locLable!.text = parseJSON["results"]![0]["lastLoc"] as String! ?? ""
                        self.timeLabel!.text = ""
                        self.followersLabel!.text = parseJSON["results"]![0]["followers"] as String! ?? ""
                        self.followingLabel!.text = parseJSON["results"]![0]["following"] as String! ?? ""
                        self.tableView.reloadData()
                    })
//
                    

                 //   self.reload_table()
                    
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                 //   self.showErrorScreen("top")
                }
            }
        })
        task.resume()
        //END AJAX
        
        
        
    }

    
    
    
    
    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {

    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){

        // getMyFriends()
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        did_press_logout()
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    
    

    
    
}