//
//  ActivityListViewContoller.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/28.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class ActivityListViewContoller: UITableViewController {

    
    //复用界面对应的标题
    var barTitles = ["搜索结果","最新发布","热门活动","参加的活动","发布的活动"]
    
    //对应的identityfiers
    var identifiersForEachSection = ["RecentActivitiesCell","RecentActivitiesCell","HotActivitiesCell","MineOrganizedActivitiesCell","MineParticipatedActivitiesCell"]
    
    //demo用
    var activiesTiltles = ["减肥的同学请进","跑步求带走，男女不限","俱乐部活动，欢迎大家参与"]
    var activitiesOrganizers = ["Ella", "Maria", "Stefan"]
    var detailedDescriptions = ["明晚约跑，地点嘉实...","今天下午or晚上...","明晚同济夜跑将在..."]
    
    
    //借助.rawValue作为barTitles的index
    enum titleType:Int {
        case SEARCH = 0
        case RECENT = 1
        case HOT = 2
        case PARTICIPATED = 3
        case ORGANIZED = 4
    }
    
    //需其他controller传值，默认为search
    var displayType:titleType = .SEARCH
    
    //符合要求的活动数，加入数据库后应为一对象数组
    var activitiesNum: Int = 3
    
    //刷新提示
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      initTableView(tableView: self.tableView)
        self.navigationItem.title = barTitles[displayType.rawValue]
        //添加下拉刷新
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onPullToFresh), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        setLoadMore()

    }
    
    func initTableView(tableView:UITableView){
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        //采用自适应布局
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activitiesNum
    }

    //设置section与header间的距离
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(0.01)
    }
    
    
    //隐藏底部刷新提示
    func hideFooterView(){
        self.tableView.tableFooterView?.isHidden = true
        indicator.stopAnimating()
    }

    
    //显示底部刷新提示
    func showFooterView(){
        self.tableView.tableFooterView?.isHidden = false
        indicator.startAnimating()
        
    }
    
    //初始化下拉刷新部件
    func setLoadMore(){
        let loadMoreText:UILabel = UILabel.init(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height*0.1))
        loadMoreText.text = "上拉加载更多"
        loadMoreText.textAlignment = NSTextAlignment.center
        loadMoreText.font = UIFont.systemFont(ofSize: 14.0)
        tableView.tableFooterView = loadMoreText
        //加载indicator
        indicator.frame = CGRect(x:0, y:-30, width:self.view.frame.size.width, height:self.view.frame.size.height*0.1)
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        tableView.tableFooterView?.addSubview(indicator)
        hideFooterView()
    }

    //更新review数据，demo
    //更新数据的数量需与当前table的cell数量相同
    func updateReviewData(){
//        reviewsList.removeAll()
//        reviewsList += ["Haigh's Chocolate", "Palomino Espresso","Cafe Deadend", "Homei", "Teakha"]
    }
    
    //下拉刷新时调用的方法
    func onPullToFresh(fresh:UIRefreshControl){
        print("refresh\n")
        updateReviewData()
        tableView.reloadData()
        fresh.endRefreshing()
        
    }
    
    //下拉加载更数据
    func loadMoreData(){
        
//        //仅当可加载更多数据时使用
//        reviewsList += ["For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso"]
//        reviewersList += ["Ambrose","Ambrose","Ambrose","Ambrose","Ambrose"]
        
        hideFooterView()
        tableView.reloadData()
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
//        cell.activitiesTitleLabel.text = activiesTiltles[rowIndex]
//        cell.activitiesDescriptionLabel.text = detailedDescriptions[rowIndex]
//        cell.activityDate.text = activitiesDate[rowIndex]
//        cell.activityState.text = activitiesState[rowIndex]==true ? "已结束" : "待开始"
    }
    
    func setMineOrganizedActivitiesCell(cell:MineOrganizedActivitiesCell,rowIndex:Int){
//        cell.activitiesTitleLabel.text = activiesTiltles[rowIndex]
//        cell.activitiesDescriptionLabel.text = detailedDescriptions[rowIndex]
//        cell.activityDate.text = activitiesDate[rowIndex]
//        cell.activityState.text = activitiesState[rowIndex]==true ? "已结束" : "待开始"
    }
    
    //重用
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = identifiersForEachSection[displayType.rawValue]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        //初始化cell...
        //调用以上各种setCell方法
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        // Configure the cell...
        return cell
    }
    
    //滚动时发生变化
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //如果没有新数据或者没有隐藏内容
        if tableView.tableFooterView?.isHidden == false{
            return
        }
        //回去scroll滚动y值
        let offsetY:CGFloat = scrollView.contentOffset.y;
        //获取最大高度
        let maxHeigth:CGFloat = max(0,scrollView.contentSize.height - scrollView.frame.size.height + 50);
        
        if (offsetY >= maxHeigth) {
            let when = DispatchTime.now() + 1
            self.showFooterView()
            //加载数据，正常情况下无需定时，此处是为了模拟延时效果
            DispatchQueue.main.asyncAfter(deadline: when) {
                //加载更多数据
                self.loadMoreData()
            }
        }
    }
    
}
