//
//  LoadMoreActivityIndicator.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/13/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import UIKit

class LoadMoreActivityIndicator {
    let spacingFromLastCell: CGFloat
    let spacingFromLastCellWhenLoadMore: CGFloat
    let activityIndicatorView: UIActivityIndicatorView
    weak var collectionView: UICollectionView!

    private var defaultY: CGFloat {
        return collectionView.contentSize.height + spacingFromLastCell
    }

    init(collectionView: UICollectionView, spacingFromLastCell: CGFloat, spacingFromLastCellWhenLoadMore: CGFloat) {
        self.collectionView = collectionView
        self.spacingFromLastCell = spacingFromLastCell
        self.spacingFromLastCellWhenLoadMore = spacingFromLastCellWhenLoadMore

        let size: CGFloat = 40
        let frame = CGRect(x: (collectionView.frame.width - size) / 2,
                           y: collectionView.contentSize.height + spacingFromLastCell,
                           width: size,
                           height: size)
        activityIndicatorView = UIActivityIndicatorView(frame: frame)
        activityIndicatorView.color = .black
        activityIndicatorView.isHidden = false
        activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        collectionView.addSubview(activityIndicatorView)
        activityIndicatorView.isHidden = isHidden
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var isHidden: Bool {
        return collectionView.contentSize.height < collectionView.frame.size.height
    }

    func scrollViewDidScroll(scrollView: UIScrollView, loadMoreAction: () -> Void) {
        let offsetY = scrollView.contentOffset.y
        activityIndicatorView.isHidden = isHidden
        if !isHidden && offsetY >= 0 {
            let contentDelta = scrollView.contentSize.height - scrollView.frame.size.height
            let offsetDelta = offsetY - contentDelta
            let newY = defaultY - offsetDelta
            if newY < collectionView.frame.height {
                activityIndicatorView.frame.origin.y = newY
            } else {
                if activityIndicatorView.frame.origin.y != defaultY {
                    activityIndicatorView.frame.origin.y = defaultY
                }
            }
            if !activityIndicatorView.isAnimating {
                if offsetY > contentDelta && offsetDelta >= spacingFromLastCellWhenLoadMore &&
                    !activityIndicatorView.isAnimating {
                    activityIndicatorView.startAnimating()
                    loadMoreAction()
                }
            }
            if scrollView.isDecelerating {
                if activityIndicatorView.isAnimating && scrollView.contentInset.bottom == 0 {
                    UIView.animate(withDuration: 0.3) { [weak self] in
                        if let bottom = self?.spacingFromLastCellWhenLoadMore {
                            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
                        }
                    }
                }
            }
        }
    }
    func loadMoreActionFinshed(scrollView: UIScrollView) {
        let contentDelta = scrollView.contentSize.height - scrollView.frame.size.height
        let offsetDelta = scrollView.contentOffset.y - contentDelta
        if offsetDelta >= 0 {
            // Animate hiding when activity indicator displaying
            UIView.animate(withDuration: 0.3) {
                scrollView.contentInset = UIEdgeInsets.zero
            }
        } else {
            // Hiding without animation when activity indicator displaying
            scrollView.contentInset = UIEdgeInsets.zero
        }
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = false
    }
}
