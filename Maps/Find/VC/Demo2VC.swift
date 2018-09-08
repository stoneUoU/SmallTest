//
//  Demo2VC.swift
//  Maps
//
//  Created by test on 2017/12/21.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
import MethodSDK
enum PatterLockType {
    case set, login, verify
}
class Demo2VC:BaseToolVC{
    internal let passwordLength = 4
    internal var setTime = 0
    internal var password: String? = nil

    let touchView: CirclesView = CirclesView()
    let infoView: CircleInfoView = CircleInfoView()
    var tipsLabel: UILabel = UILabel()
    var type: PatterLockType

    let firstSetTipText = "绘制解锁图案"
    let atLeast4PointTipText = "至少连接4个点，请重新输入"
    let redrawTipText = "再次绘制解锁图案"
    let differentFromPreTipText = "与上一次绘制不一致，请重新绘制"
    let successTipText = "绘制成功"

    convenience init() {
        self.init(type: .set)
    }

    init(type theType: PatterLockType) {
        type = theType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        type = .set
        super.init(coder: aDecoder)
    }
    //声明导航条
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp(centerVals: "设置手势密码", rightVals: "提交")
        self.setUpUI()
        self.view.backgroundColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension Demo2VC{
    func setUpUI(){
        self.view.addSubview(infoView)
        infoView.snp.makeConstraints{
            (make) in
            make.top.equalTo(self.view.snp.top).offset(StatusBarAndNavigationBarH + PublicFunc.setHeight(size: 44))
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.infoView.bounds.width)
            make.height.equalTo(self.infoView.bounds.height)
        }

        tipsLabel.textColor = Color.grayColor
        tipsLabel.font = UIFont.systemFont(ofSize: 15)
        tipsLabel.textAlignment = .center
        tipsLabel.text = type == .set ? firstSetTipText : ""
        self.view.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints{
            (make) in
            make.top.equalTo(self.infoView.snp.bottom).offset(PublicFunc.setHeight(size: 24))
            make.left.equalTo(0)
            make.width.equalTo(ScreenInfo.width)
            make.height.equalTo(15)
        }

        self.view.addSubview(touchView)
        touchView.snp.makeConstraints{
            (make) in
            make.top.equalTo(self.tipsLabel.snp.bottom).offset( PublicFunc.setHeight(size: 24))
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.touchView.bounds.width)
            make.height.equalTo(self.touchView.bounds.height)
        }

        touchView.getPasswordClosure = { [unowned self](password) in
            self.infoView.clean();
            if self.type == .set {
                if (password.characters.count < self.passwordLength) && (self.setTime == 0) {
                    self.touchView.clean()
                    self.showError(self.atLeast4PointTipText)
                } else {
                    self.infoView.fillCircles(withNumber: password)
                    if self.setTime == 0 {
                        self.password = password
                        self.tipsLabel.text = self.redrawTipText
                        self.tipsLabel.textColor =  Color.grayColor
                        self.setTime += 1
                        self.touchView.clean()
                    } else {
                        if self.password! == password {
                            StToastSDK().showToast(text:"手势密码设置成功",type:Pos)
                            self.showSucc(self.successTipText)
                            // TODO: Save password here
                            keychain.set(self.password!, forKey: "GestureWord")
                            
                            PublicFunc.popToPrevCtrl(selfCtrl: self);
                            STLog(self.password!)
                        } else {
                            self.showError(self.differentFromPreTipText)
                            self.touchView.showError()
                        }
                    }
                }
            }
        }

    }
    func showError(_ text: String) {
        let center = tipsLabel.center
        tipsLabel.text = text
        tipsLabel.textColor = Color.destructiveColor
        UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                self.tipsLabel.center = CGPoint(x: center.x - 10, y: center.y)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2, animations: {
                self.tipsLabel.center = CGPoint(x: center.x + 10, y: center.y)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
                self.tipsLabel.center = CGPoint(x: center.x - 10, y: center.y)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
                self.tipsLabel.center = CGPoint(x: center.x + 10, y: center.y)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                self.tipsLabel.center = CGPoint(x: center.x, y: center.y)
            })
        }, completion: nil)
    }
    func showSucc(_ text: String) {
        let center = tipsLabel.center
        tipsLabel.text = text
        tipsLabel.textColor = Color.grayColor
    }
    //手势代码：
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    @objc override func toRight(_ tapGes: UITapGestureRecognizer) {
        STLog("我来完成了")
    }
}