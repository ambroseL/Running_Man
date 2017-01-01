//
//  SocialGroupController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/25.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class SocialGroupViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UIPopoverPresentationControllerDelegate {

    var activiesTiltles = ["减肥的同学请进","跑步求带走，男女不限","俱乐部活动，欢迎大家参与"]
    var activitiesOrganizers = ["Ella", "Maria", "Stefan"]
    var detailedDescriptions = ["明晚约跑，地点嘉实...","今天下午or晚上...","明晚同济夜跑将在..."]
    
    var identifiersForEachDiscoverySection = [["ActivitiesImageCell"],["RecentActivitiesTitleCell","RecentActivitiesCell"],["HotActivitiesTitleCell","HotActivitiesCell"]]
    
    var identifiersForEachMineSection = [["MineOrganizedActivitiesTitleCell","MineOrganizedActivitiesCell"],["MineParticipatedActivitiesTitleCell","MineParticipatedActivitiesCell"]]
    
    //活动时间
    var activitiesDate = ["2016-12-12","2016-12-17","2016-12-18","2016-12-19","2016-12-16","2016-12-30"]
    //活动状态，真为已结束，假为未开始
    var activitiesState = [true,true,true,true,true,false]
    
    //用于轮播的图片
    var imageSources = ["SocialBackground","Weatherbackground","CheckOut"]
    
    @IBOutlet var discoveryTableView:UITableView!
    @IBOutlet var mineTableView:UITableView!
    @IBOutlet var tabPanel: UIView!
    @IBOutlet var discoveryActivitiesButton: UIButton!
    @IBOutlet var mineActivitiesButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    
    //用于滚动视图
    var imageScrollView:UIScrollView! = UIScrollView()
    var pageController:UIPageControl! = UIPageControl()
    var timer:Timer! = Timer()
    var mainImageView: UIImageView! = UIImageView()
    var leftImageView: UIImageView! = UIImageView()
    var rightImageView: UIImageView! = UIImageView()
    var isScrolling:Bool = false
    
    let scrollBar = UIView()
    
    var startContentOffsetX:CGFloat = 0.0
    var willEndContentOffsetX:CGFloat = 0.0
    var endContentOffsetX:CGFloat = 0.0
    
    
    func initTableView(tableView:UITableView){
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        //采用自适应布局
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func initScroll(){
        //初始化要用到的参数
        let WIDTH = self.view.frame.width
        let HEIGHT = self.view.frame.height - 60 - 30 - 49
        
        //添加 tab 标签面板底部条
        self.view.addSubview(self.scrollBar)
        self.scrollBar.backgroundColor = UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0)
        self.scrollBar.frame.size.width = WIDTH / 6
        self.scrollBar.frame.size.height = 1
        self.scrollBar.center = CGPoint(x:self.discoveryActivitiesButton.center.x,y:97)
        
        //设置 scrollView delegate
        self.scrollView.delegate = self
        
        //设置 scrollView contentSize
        self.scrollView.contentSize = CGSize(width:WIDTH * 2, height:HEIGHT)
        
        //设置两个 tableView 大小位置
        self.discoveryTableView.frame = CGRect(x:8, y:0, width:WIDTH - 16, height:HEIGHT)
        self.mineTableView.frame = CGRect(x:WIDTH + 8, y:0, width:WIDTH - 16, height:HEIGHT)
      
    }
    
    func initSwipeGesture(){
        //初始化主视图的手势
        let swipe2Left = UISwipeGestureRecognizer()
        swipe2Left.direction = UISwipeGestureRecognizerDirection.left
        swipe2Left.addTarget(self, action: #selector(self.tableMoveLeft))
        
        let swipe2Right = UISwipeGestureRecognizer()
        swipe2Right.direction = UISwipeGestureRecognizerDirection.right
        swipe2Right.addTarget(self, action: #selector(self.tableMoveRight))
        self.scrollView.addGestureRecognizer(swipe2Left)
        self.scrollView.addGestureRecognizer(swipe2Right)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        initTableView(tableView: discoveryTableView)
        initTableView(tableView: mineTableView)
        initScroll()
        initSwipeGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if tableView == discoveryTableView{
            return 3
        }
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView == discoveryTableView{
            return section == 0 ? 1:4
        }
        return 4
    }
    
    //添加定时器
    func addTimer2ImageScroll(){
        if self.timer != nil{
            return
        }
        let timer:Timer = Timer(timeInterval: 2.0, target: self, selector: #selector(autoTurn2NextImage), userInfo: nil, repeats: true)
        self.timer = timer
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    //移除定时器
    func removeTimerFromImageScroll(){
        self.timer.invalidate()
        self.timer = nil
    }
    
    func imageMove2Left(){
        isScrolling = true
        if self.pageController.currentPage - 1 < 0{
            self.pageController.currentPage = imageSources.count - 1
        }else{
            self.pageController.currentPage -= 1
        }
        updateImageData()
        if timer != nil && timer.isValid{
            removeTimerFromImageScroll()
        }
    }
    
    func imageMove2Right(){
        isScrolling = true
        if self.pageController.currentPage == imageSources.count - 1{
            self.pageController.currentPage = 0
        }else{
            self.pageController.currentPage += 1
        }
        updateImageData()
        if timer != nil && timer.isValid{
            removeTimerFromImageScroll()
        }
    }
    
    func autoTurn2NextImage(){
        var currentPage: Int = self.pageController.currentPage
        if currentPage == imageSources.count - 1{
            currentPage = 0
        }else{
            currentPage += 1
        }
        self.pageController.currentPage = currentPage
        self.updateImageData()
    }
    
    func updateImageData(){
        let pageIndex: Int = self.pageController.currentPage
        if  pageIndex == 0{
            leftImageView.image = UIImage(named:imageSources.last!)
            mainImageView.image = UIImage(named:imageSources[pageIndex])
            rightImageView.image = UIImage(named:imageSources[pageIndex + 1])
            
        }else if pageIndex == imageSources.count - 1{
            leftImageView.image = UIImage(named:imageSources[pageIndex - 1])
            mainImageView.image = UIImage(named:imageSources[pageIndex])
            rightImageView.image = UIImage(named:imageSources.first!)
        }else{
            leftImageView.image = UIImage(named:imageSources[pageIndex - 1])
            mainImageView.image = UIImage(named:imageSources[pageIndex])
            rightImageView.image = UIImage(named:imageSources[pageIndex + 1])
        }
        imageScrollView.contentOffset = CGPoint(x: self.view.frame.size.width,y: 0)
        if isScrolling == true {
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.addTimer2ImageScroll()
                self.isScrolling = false
            }
        }
    }
    
    //初始化轮播图手势
    func initGestureForImage(){
        
        let swipe2LeftInSubview =  UISwipeGestureRecognizer()
        swipe2LeftInSubview.direction = UISwipeGestureRecognizerDirection.left
        swipe2LeftInSubview.addTarget(self, action: #selector(self.imageMove2Left))
        
        let swipe2RightInSubview = UISwipeGestureRecognizer()
        swipe2RightInSubview.direction = UISwipeGestureRecognizerDirection.right
        swipe2RightInSubview.addTarget(self, action: #selector(self.imageMove2Right))
        
        self.imageScrollView.addGestureRecognizer(swipe2LeftInSubview)
        self.imageScrollView.addGestureRecognizer(swipe2RightInSubview)
    }
    
    func setActivitiesImageCell(cell:ActivitiesImageCell){
        
        //初始化对应scroll view
        let WIDTH = self.view.frame.width
        cell.imageScrollView.delegate = self
        cell.imageScrollView.isPagingEnabled = true
        cell.imageScrollView.showsHorizontalScrollIndicator = false
        cell.imageScrollView.contentOffset = CGPoint(x:WIDTH, y:0);
        
        //后续工作：添加点击事件
        
        //初始化轮播图片
        let imageW: CGFloat = cell.imageScrollView.frame.width
        let imageH: CGFloat = cell.imageScrollView.frame.height
        let imageY: CGFloat = 0
        

        self.leftImageView.frame = CGRect(x:0,y:imageY,width:imageW,height:imageH)
        self.mainImageView.frame = CGRect(x:imageW.multiplied(by: CGFloat(1)),y:imageY,width:imageW,height:imageH)
        self.rightImageView.frame = CGRect(x:imageW.multiplied(by: CGFloat(2)),y:imageY,width:imageW,height:imageH)
        cell.imageScrollView.addSubview(leftImageView)
        cell.imageScrollView.addSubview(mainImageView)
        cell.imageScrollView.addSubview(rightImageView)
        
        //设置pageController
        cell.pageControl.frame = CGRect(x: 0, y: 0, width: WIDTH, height: 20)
        cell.pageControl.center = CGPoint(x:WIDTH / 2, y:imageScrollView.frame.height - 20);
        
        //设置pageController 的页数
        cell.pageControl.numberOfPages = self.imageSources.count;
        cell.pageControl.currentPage = 0;
        
        self.imageScrollView = cell.imageScrollView
        imageScrollView.delegate = self
        self.pageController = cell.pageControl
        
        initGestureForImage()
        updateImageData()
        addTimer2ImageScroll()
    }
    
    func setRecentActivitiesCell(cell:RecentActivitiesCell,rowIndex:Int){
        cell.activitiesTitleLabel.text = activiesTiltles[rowIndex]
        cell.activitiesDescriptionLabel.text = detailedDescriptions[rowIndex]
        cell.userProfileButton.imageView?.image = UIImage(named:"Boy")
        cell.organizerName.text = activitiesOrganizers[rowIndex]
    }
    
    func setHotActivitiesCell(cell:HotActivitiesCell,rowIndex:Int){
        cell.activitiesTitleLabel.text = activiesTiltles[rowIndex]
        cell.activitiesDescriptionLabel.text = detailedDescriptions[rowIndex]
        cell.userProfileButton.imageView?.image = UIImage(named:"Boy")
        cell.organizerName.text = activitiesOrganizers[rowIndex]
    }
    
    func setMineParticipatedActivitiesCell(cell:MineParticipatedActivitiesCell,rowIndex:Int){
        cell.activitiesTitleLabel.text = activiesTiltles[rowIndex]
        cell.activitiesDescriptionLabel.text = detailedDescriptions[rowIndex]
        cell.activityDate.text = activitiesDate[rowIndex]
        cell.activityState.text = activitiesState[rowIndex]==true ? "已结束" : "待开始"
    }
    
    func setMineOrganizedActivitiesCell(cell:MineOrganizedActivitiesCell,rowIndex:Int){
        cell.activitiesTitleLabel.text = activiesTiltles[rowIndex]
        cell.activitiesDescriptionLabel.text = detailedDescriptions[rowIndex]
        cell.activityDate.text = activitiesDate[rowIndex]
        cell.activityState.text = activitiesState[rowIndex]==true ? "已结束" : "待开始"
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == discoveryTableView{
            let cellIdentifier = identifiersForEachDiscoverySection[indexPath.section][indexPath.row > 0 ? 1:0]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            switch cellIdentifier{
            case "ActivitiesImageCell":
                setActivitiesImageCell(cell: cell as! ActivitiesImageCell)
                break
            case "HotActivitiesCell":
                setHotActivitiesCell(cell: cell as! HotActivitiesCell, rowIndex: indexPath.row-1)
                break
            case "RecentActivitiesCell":
                setRecentActivitiesCell(cell: cell as! RecentActivitiesCell, rowIndex: indexPath.row-1)
                break
            default:
                break
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else {
                let cellIdentifier = identifiersForEachMineSection[indexPath.section][indexPath.row > 0 ? 1:0]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                
                switch cellIdentifier{
                case "MineOrganizedActivitiesCell":
                    setMineOrganizedActivitiesCell(cell: cell as! MineOrganizedActivitiesCell, rowIndex: indexPath.row-1)
                    break
                case "MineParticipatedActivitiesCell":
                    setMineParticipatedActivitiesCell(cell: cell as! MineParticipatedActivitiesCell, rowIndex: indexPath.row-1)
                    break
                default:
                    break
                }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
        }
    }
    
    //设置section与header间的距离
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(10.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断当前 scrollView 是我们项目中的 ScrollView 而非那两个 tableView
        if scrollView == self.scrollView {
            //改变 scrollBar x 坐标，达成同步滑动效果。
            let offsetX = scrollView.contentOffset.x
            //对应修改 btn 文字颜色
            if offsetX > self.view.frame.width / 2 {
                self.discoveryActivitiesButton.setTitleColor(UIColor.black, for: .normal)
                self.mineActivitiesButton.setTitleColor(UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0), for: .normal)
                self.scrollBar.center = CGPoint(x:mineActivitiesButton.center.x,y:97)
            } else {
                self.discoveryActivitiesButton.setTitleColor(UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0), for: .normal)
                self.mineActivitiesButton.setTitleColor(UIColor.black, for: .normal)
                self.scrollBar.center = CGPoint(x:discoveryActivitiesButton.center.x,y:97)
            }
        }
    }
    
    //tableView右移
    func tableMoveRight(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            self.scrollView.contentOffset.x = 0
        }, completion: nil)
    }
    
    //tableView左移
    func tableMoveLeft(){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            self.scrollView.contentOffset.x = self.view.frame.width
        }, completion: nil)
    }
    
    @IBAction func discoveryActivitiesButtonPressed(sender: UIButton) {
        //点击按钮时，通过动画移动到对应 tableView
        tableMoveRight()
    }
    
    @IBAction func mineActivitiesButtonPressed(sender: UIButton) {
        //点击按钮时，通过动画移动到对应 tableView
        tableMoveLeft()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView{
            endContentOffsetX = scrollView.contentOffset.x;
            if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
                self.discoveryActivitiesButton.setTitleColor(UIColor.black, for: .normal)
                self.mineActivitiesButton.setTitleColor(UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0), for: .normal)
                
            } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
                self.discoveryActivitiesButton.setTitleColor(UIColor(red: 208/255.0, green: 2/255.0, blue: 27/255.0, alpha: 1.0), for: .normal)
                self.mineActivitiesButton.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PopOver" {
            let popoverViewController = segue.destination
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.preferredContentSize   = CGSize(width:120, height:80)
            let popoverPresentationViewController = popoverViewController.popoverPresentationController
            popoverPresentationViewController?.permittedArrowDirections = .up
            popoverPresentationViewController?.delegate = self
            
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    //生成定时提示消息
    func alert(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alc.view.tintColor = UIColor.gray
        present(alc, animated: true, completion: nil)
        
        //设置定时器，间隔1s
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            alc.dismiss(animated: false, completion: nil)
        }
    }
    
    //设置可编辑行操作按钮
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        if tableView == mineTableView{
            // 完成按钮
            let finishAction = UITableViewRowAction(style:UITableViewRowActionStyle.default, title: "完成",handler: { (action, indexPath) -> Void in
                
                // Delete the row from the data source self.restaurantNames.remove(at: indexPath.row) self.restaurantLocations.remove(at: indexPath.row) self.restaurantTypes.remove(at: indexPath.row) self.restaurantIsVisited.remove(at: indexPath.row) self.restaurantImages.remove(at: indexPath.row)
                
                //self.tableView.deleteRows(at: [indexPath], with: .fade)
            })
            
             finishAction.backgroundColor = UIColor(red: 0/255.0, green: 118.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            
            // 删除按钮
            let deleteAction = UITableViewRowAction(style:UITableViewRowActionStyle.default, title: "删除",handler: { (action, indexPath) -> Void in
                
                // Delete the row from the data source
                //            self.restaurantNames.remove(at: indexPath.row)
                //            self.restaurantLocations.remove(at: indexPath.row)
                //            self.restaurantTypes.remove(at: indexPath.row)
                //            self.restaurantIsVisited.remove(at: indexPath.row)
                //            self.restaurantImages.remove(at: indexPath.row)
                //self.tableView.deleteRows(at: [indexPath], with: .fade)
                
            })
            
            let cancelAction = UITableViewRowAction(style:UITableViewRowActionStyle.default, title: "取消",handler: { (action, indexPath) -> Void in
                
                // Delete the row from the data source
                //            self.restaurantNames.remove(at: indexPath.row)
                //            self.restaurantLocations.remove(at: indexPath.row)
                //            self.restaurantTypes.remove(at: indexPath.row)
                //            self.restaurantIsVisited.remove(at: indexPath.row)
                //            self.restaurantImages.remove(at: indexPath.row)
                //self.tableView.deleteRows(at: [indexPath], with: .fade)
                
            })
            
            cancelAction.backgroundColor = UIColor(red: 255/255.0, green: 150.0/255.0, blue: 0/255.0, alpha: 1.0)
            
            if(indexPath.row > 0){
                if indexPath.section == 0 {
                    return [finishAction,deleteAction]
                }else{
                    return [finishAction,cancelAction]
                }
            }
        }
        return nil
    }
    
    //设置可编辑行
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView == discoveryTableView || indexPath.row == 0{
            return UITableViewCellEditingStyle.none
        }
        return UITableViewCellEditingStyle.delete
    }
    
    
}


