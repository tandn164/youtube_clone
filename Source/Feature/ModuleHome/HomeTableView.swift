//
//  HomeTableView.swift
//  YoutubeClone
//
//  Created by Đức Tân Nguyễn on 07/06/2021.
//

import UIKit

class HomeTableView: AppTableView {
        
    override func viewDidAppear(_ data: Any? = nil) {
                
        register(HomeHeaderTableViewCell.nib(),
                 forCellReuseIdentifier: HomeHeaderTableViewCell.nibName())
        register(HomeVideosByCategoryTableViewCell.nib(),
                 forCellReuseIdentifier: HomeVideosByCategoryTableViewCell.nibName())
        tableFooterView = UIView()
        backgroundView = nil
        tableFooterView?.isHidden = true
        estimatedSectionFooterHeight = CGFloat.leastNormalMagnitude
        sectionFooterHeight = CGFloat.leastNormalMagnitude
        super.viewDidAppear(data)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sectionLoading {
            return self.createLoadingCell(indexPath)
        } else {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeHeaderTableViewCell.nibName()) as? HomeHeaderTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeVideosByCategoryTableViewCell.nibName()) as? HomeVideosByCategoryTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
