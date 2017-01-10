//
//  MainPageControllerViewController.swift
//  RunnningMan
//
//  Created by 刘立冬 on 2016/12/23.
//  Copyright © 2016年 刘立冬. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {

    @IBOutlet var weatherImageView: UIImageView!
    
    @IBOutlet var temperatureInfoLabel: UILabel!
    @IBOutlet var weatherInfoLabel: UILabel!
    @IBOutlet var checkOutInfoLabel: UILabel!
    @IBOutlet var socialInfoLabel: UILabel!
    
    @IBOutlet var shownView:UIView!
    @IBOutlet var hiddenView:UIView!
    
    @IBOutlet var tableView:UITableView!

    var signatureTextField: UITextField!
    
    var weatherController:WeatherInfoServer!
    
     //Main Page部分内容
    var temperatureInfo = ""
    var weatherInfo = ""
    var socialInfo = ""
    var checkOutInfo = ""
    var weatherType = ""
    
    var hasCheckedOut: Bool = false
    var isPersanalPage: Bool = false
    var hasSchedule:Bool = false
    
    //User Info部分内容
    var userName: String = "No"/* 用户名 */
    var organizedNum: Int = 0/* 组织活动数量 */
    var participatedNum: Int = 0/* 参加活动数量 */
    var likeNum: Int = 0/* 点赞数量 */
    var sex: Bool = true/* 用户性别 */
    var userPerfileURL: String = "Boy"/* 用户头像图片URL */
    var signatureTextInfo: String = "不如跳舞，debug不如跳舞"
    var canEditSignature: Bool = false/* 是否可编辑签名，仅在编辑按钮激活后设为true */
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    //区分个人主页与他人主页的方法
    var isMine:Bool = true
    
    var identifiersForEachSection = [["BasicInfo"],["ReviewTile","ReviewInfo"]]
    
    var reviewsList = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster"]

    var reviewersList = ["Ambrose","Ambrose","Ambrose","Ambrose","Ambrose"]

    //更新信息
    func initInfoDemo(){
        temperatureInfo = "20°C"
        weatherInfo = "空气质量：XXX\t" + "湿度：XXX\n" + "穿衣指数: XXX\t" + "PM2.5：XXX"
        checkOutInfo = hasCheckedOut ? "今日已打卡":"今日未打卡"
        socialInfo = hasSchedule ? "15:00与Ambrose的约跑":"尚未约跑，快去圈里看看"
        weatherType = "Rainy"
        
        
        temperatureInfoLabel.text = temperatureInfo
        weatherInfoLabel.text = weatherInfo
        checkOutInfoLabel.text = checkOutInfo
        socialInfoLabel.text = socialInfo
        
        updateWeatherImage(weatherType: weatherType)
    }
    
    //修改天气显示图片颜色
    func renderWeatherImageColor(){
        weatherImageView.image = weatherImageView.image!.withRenderingMode(.alwaysTemplate)
        weatherImageView.tintColor = UIColor.white
    }
    
    
    //更新天气图片
    func updateWeatherImage(weatherType:String){
        weatherImageView.image = UIImage(named: weatherType)
        renderWeatherImageColor()
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
    
    //打卡按钮响应
    @IBAction func checkOutPractice(sender: AnyObject) {
        if hasCheckedOut {
            alert(message: "今日已打卡")
        }else{
            alert(message: "打卡成功")
            hasCheckedOut = true
            checkOutInfoLabel.text = "今日已打卡"
        }
        
    }
    
    //设置两个view间的翻转
    @IBAction func changeMainPageView(sneder: AnyObject){
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        if isPersanalPage{
            UIView.transition(from: hiddenView, to:shownView, duration: 0.5, options: transitionOptions, completion: nil)
            isPersanalPage = false
            
        }else{
            UIView.transition(from: shownView, to: hiddenView, duration: 0.5, options: transitionOptions, completion: nil)
            isPersanalPage = true
        }
        
        
    }
    
    //绘制底部线条
    func drawBottomeLine(textLabel: UILabel)->Void{
        let border = CALayer()
        let width = CGFloat(1.2)
        border.borderColor = UIColor(red: 240.0/255.0, green: 235.0/255.0, blue: 241.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: textLabel.frame.size.height - width, width:  textLabel.frame.size.width, height: textLabel.frame.size.height)
        border.borderWidth = width
        textLabel.layer.addSublayer(border)
        textLabel.layer.masksToBounds = true
    }
    
    //懒加载，用到的时候再开辟空间
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onPullToFresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        //采用自适应布局
        tableView.estimatedRowHeight = 170.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //添加下拉刷新
        tableView.addSubview(refreshControl)
        setLoadMore()

        //访问非个人主页
        if isMine == false{
            //隐藏回到主页按钮
            self.navigationItem.rightBarButtonItem = nil
            shownView.isHidden = true
            title = userName + "的主页"
            return
        }
        
        initInfoDemo()
        renderWeatherImageColor()
        initTouchGesture()
    }

    //更新review数据，demo
    //更新数据的数量需与当前table的cell数量相同
    func updateReviewData(){
        reviewsList.removeAll()
        reviewsList += ["Haigh's Chocolate", "Palomino Espresso","Cafe Deadend", "Homei", "Teakha"]
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
        
        //仅当可加载更多数据时使用
        reviewsList += ["For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso"]
        reviewersList += ["Ambrose","Ambrose","Ambrose","Ambrose","Ambrose"]
        
        hideFooterView()
        tableView.reloadData()
    }
    
    //滚动时发生变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //将顶栏设为白色
        UIApplication.shared.statusBarStyle = .lightContent
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    // MARK: - Table view data source
    //section的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return identifiersForEachSection.count
    }
    
    //每个section中的row数量
    //section2cell数量为评论数+留言板（1行）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 1:reviewsList.count + 1
    }
    
    //设置用户信息cell
    func setUserInfoCell(cell:UserInfoCell){
        cell.nameLabel?.text = userName
        cell.orgnizedNumLabel?.text = "\(organizedNum)"
        cell.participatedNumLabel?.text = "\(participatedNum)"
        cell.likeInfoNumLabel?.text = "\(likeNum)"
        cell.uerInfoImageView?.image = UIImage(named:userPerfileURL)
        drawBottomeLine(textLabel: cell.nameLabel)
        cell.signatureTextField.text = signatureTextInfo
       
        signatureTextField = cell.signatureTextField
        signatureTextField.delegate = self
        addToolBarForKeyboard(textField: signatureTextField)
        
        //访问非个人主页隐藏编辑签名按钮
        if isMine == false{
            cell.editSignatureButton.isHidden = true
        }

    }
    
    //设置评论cell
    func setReviewInfo(cell:DetailedReviewCell,rowIndex:Int){
        cell.reviewerPerfileButton?.setBackgroundImage(UIImage(named:"Girl"), for: .normal)
        cell.reviewTextLabel?.text = reviewsList[rowIndex]
        cell.reviewerNameLabel?.text = reviewersList[rowIndex]
    }
    
    func setReviewTitle(cell:ReviewTitleCell){
        if isMine == true{
            cell.addReviewButton.isHidden = true
        }
    }
    
    //重用
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = indexPath.row > 0 ? identifiersForEachSection[indexPath.section][1]:identifiersForEachSection[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        //initCellWithIdentifier(cell: cell, type: cellIdentifier)
        switch cellIdentifier{
            case "BasicInfo":
                setUserInfoCell(cell: cell as! UserInfoCell)
            case "ReviewInfo":
                setReviewInfo(cell: cell as! DetailedReviewCell, rowIndex: indexPath.row - 1)
            default:
                setReviewTitle(cell: cell as! ReviewTitleCell)
                break
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        // Configure the cell...
        return cell
    }
    
    //设置section与header间的距离
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(0.01)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "User2Others" {
            let destinationController = segue.destination as!MainPageViewController
            destinationController.isMine = false
        }
    }

    func alertInfo(message: String) {
        let alc = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alc.view.tintColor = UIColor.gray
        present(alc, animated: true, completion: nil)
        
        //设置定时器，间隔1s
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            alc.dismiss(animated: false, completion: nil)
        }
    }

    //编辑签名按钮的响应函数
    @IBAction func editSignatureText(){
        canEditSignature = true
        signatureTextField.performSelector(onMainThread: #selector(becomeFirstResponder), with: nil, waitUntilDone: false)
    }
    
    //textfield的代理函数，在编辑前调用
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return canEditSignature
    }
    
    //点击屏幕空白处时停止编辑
    func endEdit(){
        self.view.endEditing(true)
        canEditSignature = false
    }
    
    //初始化点击手势
    func initTouchGesture(){
        let tap =  UITapGestureRecognizer(target:self, action:#selector(self.endEdit))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func closeButtonPressed()
    {
        signatureTextField.resignFirstResponder()
    }
    
    func undoButtonPressed()
    {
        signatureTextField.resignFirstResponder()
        signatureTextField.text = signatureTextInfo
    }

    
    func addToolBarForKeyboard(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x:0, y:0, width:0, height:40)
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isOpaque = true
        toolBar.tintColor = UIColor(red: 235.0/255.0, green: 74.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        
        let toolBarButton = UIBarButtonItem(title: "取消", style:.plain, target: self, action: #selector(self.undoButtonPressed))
        
        let closeButton = UIBarButtonItem(title: "完成", style:.plain, target: self, action: #selector(self.closeButtonPressed))
        
        let spaceBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceBarButton.width = self.view.frame.width - toolBarButton.width - closeButton.width - 120
            
        toolBar.items = [toolBarButton, spaceBarButton, closeButton]
        
        textField.inputAccessoryView = toolBar
        
    }
}
