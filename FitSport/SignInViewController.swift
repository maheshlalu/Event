//
//  TutorialViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    var window: UIWindow?
    
    var tutorialPageViewController: SignInPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(SignInViewController.didChangePageControlValue), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorialPageViewController = segue.destination as? SignInPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }

    @IBAction func didTapNextButton(_ sender: UIButton) {
        tutorialPageViewController?.scrollToNextViewController()
    }
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }

    @IBOutlet weak var googlePlusSignIn: UIButton!
    
    @IBAction func googlePlusSignInAction(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.setUpSidePanl()
        
//        var mainView: UIStoryboard!
//        mainView = UIStoryboard(name: "Main", bundle: nil)
//        let viewcontroller : UIViewController = mainView.instantiateViewController(withIdentifier: "eventCell") as! EventsViewController
//        self.window!.rootViewController = viewcontroller
//        
//        var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var myVC = (storyboard.instantiateViewController(withIdentifier: "myViewCont") as! MyNewViewController)
        
    }
}

extension SignInViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: SignInPageViewController,
        didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: SignInPageViewController,
        didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}
