//
//  UIViewController+disposeBag.swift
//  core
//
//  Created by Daniel Christopher on 2/9/20.
//  Copyright © 2020 Plank Media. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public extension UIViewController {

    fileprivate func doLocked(_ closure: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        closure()
    }

    fileprivate struct AssociatedKeys {
        static var DisposeBag = "rxDisposeBag"
    }

    public var rxDisposeBag: DisposeBag {
        get {
            var disposeBag: DisposeBag!
            doLocked {
                let lookup = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBag) as? DisposeBag

                if let lookup = lookup {
                    disposeBag = lookup
                } else {
                    let newDisposeBag = DisposeBag()
                    self.rxDisposeBag = newDisposeBag
                    disposeBag = newDisposeBag
                }
            }
            return disposeBag
        }

        set {
            doLocked {
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

public extension UIView {

    fileprivate func doLocked(_ closure: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        closure()
    }

    fileprivate struct AssociatedKeys {
        static var DisposeBag = "rxDisposeBag"
    }

    public var rxDisposeBag: DisposeBag {
        get {
            var disposeBag: DisposeBag!
            doLocked {
                let lookup = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBag) as? DisposeBag

                if let lookup = lookup {
                    disposeBag = lookup
                } else {
                    let newDisposeBag = DisposeBag()
                    self.rxDisposeBag = newDisposeBag
                    disposeBag = newDisposeBag
                }
            }
            return disposeBag
        }

        set {
            doLocked {
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
