//
//  TrendingTableView.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 08/06/2021.
//

import UIKit

class TrendingTableView: AppTableView {
    var trendingController: TrendingController?
        
    override func viewDidAppear(_ data: Any? = nil) {
                
        register(TrendingTableViewCell.nib(),
                 forCellReuseIdentifier: TrendingTableViewCell.nibName())
        tableFooterView = UIView()
        backgroundView = nil
        tableFooterView?.isHidden = true
        estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
        sectionFooterHeight = CGFloat.leastNormalMagnitude
        trendingController?.notifier.addObserver(self)
        super.viewDidAppear(data)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sectionLoading {
            return self.createLoadingCell(indexPath)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.nibName()) as? TrendingTableViewCell else {
                return UITableViewCell()
            }
            cell.data = trendingController?.items[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return Device.current.safeAreaInsets.top + 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if Float(scrollView.contentOffset.y / 166) >= 1.0 {
            notifyObservers(.vScrollViewDidScroll, data: CGFloat(1.0))
        } else {
            notifyObservers(.vScrollViewDidScroll, data: CGFloat(scrollView.contentOffset.y / 166))
        }
    }
}
