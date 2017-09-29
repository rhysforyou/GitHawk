//
//  AlertActions.swift
//  Freetime
//
//  Created by Ivan Magda on 25/09/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

typealias AlertActionBlock = (UIAlertAction) -> Void

// MARK: AlertActions -

struct AlertAction {
    
    // MARK: Properties
    
    let rootViewController: UIViewController?
    let title: String?
    let style: UIAlertActionStyle
    
    // MARK: - Init
    
    init(_ builder: AlertActionBuilder) {
        rootViewController = builder.rootViewController
        title = builder.title
        style = builder.style ?? .default
    }
    
    // MARK: - Public
    
    func get(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: self.title, style: self.style, handler: handler)
    }
    
    func share(_ items: [Any],
               activities: [UIActivity]?,
               buildActivityBlock: ((UIActivityViewController) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Send To", comment: ""), style: .default) { _ in
            guard let rootViewController = self.rootViewController else { return }
            
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: activities)
            buildActivityBlock?(activityController)
            
            rootViewController.present(activityController, animated: true)
        }
    }
    
    func openInSafari(url: URL) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Open in Safari", comment: ""), style: .default) { _ in
            guard let rootViewController = self.rootViewController else { return }
            
            let safariController = SFSafariViewController(url: url)
            rootViewController.present(safariController, animated: true)
        }
    }
    
    func view(repo repoViewController: RepositoryViewController) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Open Repository", comment: ""), style: .default) { _ in
            guard let rootViewController = self.rootViewController else { return }
            rootViewController.show(repoViewController, sender: nil)
        }
    }
    
    func view(owner ownerUrl: URL) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("View Owner's Profile", comment: ""), style: .default) { _ in
            guard let rootViewController = self.rootViewController else { return }
            rootViewController.presentSafari(url: ownerUrl)
        }
    }
    
    func newIssue(issueController: NewIssueTableViewController) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("New Issue", comment: ""), style: .default) { _ in
            guard let rootViewController = self.rootViewController else { return }
            let nav = UINavigationController(rootViewController: issueController)
            nav.modalPresentationStyle = .formSheet
            rootViewController.present(nav, animated: true)
        }
    }
    
    // MARK: - Static
    
    static func cancel(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Strings.cancel, style: .cancel, handler: handler)
    }
    
    static func ok(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Strings.ok, style: .default, handler: handler)
    }
    
    static func no(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Strings.no, style: .cancel, handler: handler)
    }
    
    static func yes(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Strings.yes, style: .default, handler: handler)
    }
    
    static func goBack(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Go back", comment: ""), style: .cancel, handler: handler)
    }
    
    static func discard(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Discard", comment: ""), style: .default, handler: handler)
    }
    
    static func toggleIssue(_ status: IssueStatus, handler: AlertActionBlock? = nil) -> UIAlertAction {
        let title = status == .open
            ? NSLocalizedString("Close", comment: "")
            : NSLocalizedString("Reopen", comment: "")
        
        return UIAlertAction(title: title, style: .default, handler: handler)
    }
    
    static func login(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: Strings.signin, style: .default, handler: handler)
    }
    
    static func markAll(_ handler: AlertActionBlock? = nil) -> UIAlertAction {
        return UIAlertAction(title: NSLocalizedString("Mark All Read", comment: ""), style: .default, handler: handler)
    }
    
}
