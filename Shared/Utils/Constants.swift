//
//  Constants.swift
//  WatchCloud
//
//  Created by Bogdan Dovgopol on 11/5/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

import Foundation
import UIKit

struct Storyboard {
    static let AuthStoryboard = "Auth"
    static let HomeStoryboard = "Home"
}

struct StoryboardId {
    static let Auth = "auth"
    static let Home = "home"
}

struct AppImages {
    static let Check = "check"
    static let Cross = "cross"
    static let EmptyHearth = "hearth_empty"
    static let FilledHearth = "hearth_filled"
}

struct AppColors {
    static let Blue = #colorLiteral(red: 0.168627451, green: 0.6666666667, blue: 0.9803921569, alpha: 1)
    static let OffWhite = #colorLiteral(red: 0.968627451, green: 0.9764705882, blue: 0.9843137255, alpha: 1)
    static let darkishGray = #colorLiteral(red: 0.3058823529, green: 0.3215686275, blue: 0.3294117647, alpha: 1)
}

struct Identifiers {
    static let CategoryCell = "CategoryCell"
    static let ProductCell = "ProductCell"
    static let WishProductCell = "WishProductCell"
    static let CartItemCell = "CartItemCell"
}

struct Segues {
    static let ToProducts = "toProductsVC"
    static let ToProductDetails = "toProductDetailsVC"
    static let ToAddCategory = "toAddCategoryVC"
    static let ToEditCategory = "toEditCategoryVC"
    static let ToAddEditProduct = "toAddEditProductVC"
    static let ToProductDetailsFromWishList = "toProductDetailsFromWishList"
}
