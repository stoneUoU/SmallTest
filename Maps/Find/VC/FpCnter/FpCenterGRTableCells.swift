//
//  FpCenterTableCells.swift
//  Gfoods
//
//  Created by test on 2017/9/5.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
let fpM = 15;
class FpCenterGRTableCells: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        super . init(style: style, reuseIdentifier: reuseIdentifier)
        //懒加载创建label_accountSetCtrl界面
        self.setupAccountUI()
    }
    
    lazy var  mainView:UIView = {
        let  mainView =  UIView()
        mainView.backgroundColor = UIColor.white
        mainView.layer.cornerRadius = 5
        mainView.layer.masksToBounds = true
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.colorWithCustom(243, g: 245, b: 248,alpha: 1).cgColor
        return mainView
    }()
    lazy var  icon_img:UIImageView = {
        let  icon_img =  UIImageView()
        icon_img.layer.cornerRadius = PublicFunc.setHeight(size: 22.5)
        //实现效果
        icon_img.clipsToBounds = true
        return icon_img
    }()
    lazy var  name:UILabel = {
        let  name =  UILabel()
        name.font=UIFont.UiFontSize(size: 16)//调整文字大小
        return name
        
    }()

    func setupAccountUI() {
        self.contentView .addSubview(self.mainView)
        mainView .addSubview(self.icon_img)
        mainView .addSubview(self.name)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(self.contentView)
            make.width.equalTo(ScreenInfo.width - CGFloat(fpM*2))
            make.height.equalTo(PublicFunc.setHeight(size: 65))
        }
        icon_img.snp.makeConstraints{ (make) in
            make.centerY.equalTo(self.mainView)
            make.left.equalTo(self.mainView.snp.left).offset(10)
            make.width.height.equalTo(PublicFunc.setHeight(size: 45))
        }
        
        name.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.mainView)
            make.left.equalTo(icon_img.snp.right).offset(25)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
