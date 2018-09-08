//
//  STTableView.swift
//  Maps
//
//  Created by test on 2018/1/10.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

typealias DidChangeClosures = (UIScrollView, Bool) -> Void
import UIKit
class STTableView: UITableView {


    var changeClosures: DidChangeClosures!

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        dataSource = self
        delegate = self
    }

    func scrolldidChangeClosures(closures: @escaping DidChangeClosures) {
        changeClosures = closures
    }

}

extension STTableView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 28
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.text = "cell\(indexPath.row)"
        return cell!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let changeClosures = changeClosures else {
            return
        }
        changeClosures(scrollView, false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changeClosures(scrollView, true)
    }
}
