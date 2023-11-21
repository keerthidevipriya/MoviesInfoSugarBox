//
//  CellProtocol.swift
//  MoviesInfoSugarBox
//
//  Created by Keerthi Devipriya(kdp) on 21/11/23.
//

import UIKit

protocol CellModelProtocol {
    var reusableIdentifier: String {get set}
    
    var height: CGFloat {get set}
    var estimatedhHeight: CGFloat {get set}
    
}

protocol ConfigurableView {
    func configure(_ cellModel: CellModelProtocol)
}

protocol ReusableView {
    static var identifier: String {get}
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView {
    static var nibName:String {get}
}

extension NibLoadableView {
     static var nibName:String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView, NibLoadableView {
}

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cell: T.Type) where T: NibLoadableView {
        register(UINib(nibName: cell.nibName, bundle: Bundle(for: cell.self)), forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Could not dequeue cell with identifier: \(T.identifier)")
    }
    
    func dequeueReusableCell_<T: UITableViewCell>(withIdentifier identifer: String, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as? T {
            return cell
        }
        fatalError("Not able to deque for \(identifer)")
    }
}

extension UICollectionViewCell: ReusableView, NibLoadableView {
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
        register(UINib(nibName: T.nibName, bundle: Bundle(for:T.self)), forCellWithReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath:IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Could not dequeue cell with identifier: \(T.identifier)")
    }
    
    func dequeueReusableCell_<T: UICollectionViewCell>(withIdentifier identifer: String, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath) as? T {
            return cell
        }
        fatalError("Not able to deque for \(identifer)")
    }
}


