//
//  ViewController.swift
//  HW16
//
//  Created by Artem Mazurkevich on 21.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var sideMenuView: UIView?
    private var hamburgerButton: UIButton?
    private var sideMenuWidth: CGFloat?
    private var isSideMenuActive = false
    
    private let shadowRadius: CGFloat = 8
    private let hamburgerButtonSize: CGFloat = 46
    private let hamburgerHorizontalSpacing: CGFloat = 16
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSideMenu()
        setupHamburger()
    }
    
    private func setupSideMenu() {
        let sideMenuWidth = 0.6 * view.bounds.width
        self.sideMenuWidth = sideMenuWidth
        
        let customView = UIView(frame: CGRect(x: -sideMenuWidth - shadowRadius, y: 0, width: sideMenuWidth, height: view.bounds.height))
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 20
        customView.layer.shadowColor = UIColor.darkGray.cgColor
        customView.layer.shadowOpacity = 0.7
        customView.layer.shadowOffset = .zero
        customView.layer.shadowRadius = shadowRadius
        customView.layer.shouldRasterize = true
        customView.layer.rasterizationScale = UIScreen.main.scale
        
        sideMenuView = customView
        view.addSubview(customView)
    }
    
    private func setupHamburger() {
        let safeAreaValue = safeArea()
        let hamburgerButton = UIButton(frame: CGRect(x: safeAreaValue.left + hamburgerHorizontalSpacing, y: safeAreaValue.top + 20, width: hamburgerButtonSize, height: hamburgerButtonSize))
        hamburgerButton.imageView?.contentMode = .scaleAspectFit
        hamburgerButton.setImage(UIImage(named: "menu"), for: .normal)
        hamburgerButton.layer.cornerRadius = hamburgerButtonSize / 2
        hamburgerButton.backgroundColor = .systemYellow
        hamburgerButton.layer.zPosition = 10
        hamburgerButton.addTarget(self, action: #selector(onHamburgerButton), for: .touchUpInside)
        self.hamburgerButton = hamburgerButton
        view.addSubview(hamburgerButton)
    }
    
    @objc private func onHamburgerButton() {
        isSideMenuActive = !isSideMenuActive
        
        guard let sideMenuWidth = sideMenuWidth else {
            return
        }
        
        let sideViewTranslationX = isSideMenuActive ? sideMenuWidth + shadowRadius : 0
        let hamburgerTranslationX = isSideMenuActive ? sideMenuWidth - 2 * hamburgerHorizontalSpacing - hamburgerButtonSize : 0
        
        animateSideMenu(sideViewTranslationX: sideViewTranslationX, hamburgerTranslationX: hamburgerTranslationX)
    }
    
    private func animateSideMenu(sideViewTranslationX: CGFloat, hamburgerTranslationX: CGFloat) {
        guard let sideMenu = sideMenuView else {
            return
        }
        
        guard let hamburgerButton = hamburgerButton else {
            return
        }
        
        if isSideMenuActive {
            hamburgerButton.setImage(UIImage(named: "close"), for: .normal)
            self.blurView.isHidden = false
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            sideMenu.transform = CGAffineTransform(translationX: sideViewTranslationX, y: 0)
            hamburgerButton.transform = CGAffineTransform(translationX: hamburgerTranslationX, y: 0)
            self.blurView.alpha = self.isSideMenuActive ? 0.8 : 0.0
        } completion: { finish in
            if !self.isSideMenuActive {
                self.blurView.isHidden = true
                hamburgerButton.setImage(UIImage(named: "menu"), for: .normal)
            }
        }
    }
    
    private func safeArea() -> UIEdgeInsets {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let safeAreaValue = windowScene?.windows.first?.safeAreaInsets
        return safeAreaValue != nil ? safeAreaValue! : UIEdgeInsets()
    }
}

