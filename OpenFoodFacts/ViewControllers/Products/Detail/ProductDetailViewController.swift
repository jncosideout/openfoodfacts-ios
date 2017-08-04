//
//  ProductDetailViewController.swift
//  OpenFoodFacts
//
//  Created by Andrés Pizá Bückmann on 14/04/2017.
//  Copyright © 2017 Andrés Pizá Bückmann. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Crashlytics

class ProductDetailViewController: ButtonBarPagerTabStripViewController {

    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        buttonBarView.register(UINib(nibName: "ButtonBarView", bundle: nil), forCellWithReuseIdentifier: "Cell")
        buttonBarView.backgroundColor = .white
        settings.style.selectedBarBackgroundColor = .white
        buttonBarView.selectedBar.backgroundColor = self.view.tintColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Answers.logContentView(withName: "Product's detail", contentType: "product_detail", contentId: product.barcode, customAttributes: ["product_name": product.name ?? ""])

        navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs = [UIViewController]()

        vcs.append(getSummaryVC())
//        vcs.append(getIngredientsVC())
//        vcs.append(getNutritionVC())
//        vcs.append(getNutritionTableVC())

        return vcs
    }

    // swiftlint:disable:next cyclomatic_complexity
    fileprivate func getSummaryVC() -> UIViewController {
        let summaryTitle = NSLocalizedString("product-detail.page-title.summary", comment: "Product detail, summary")

        var sections = [FormSection]()

        // Header
        let headerSection = FormSection(rows: [FormRow(value: product, cellType: HostedViewCell.self)])
        sections.append(headerSection)

        // Rows
        var rows = [FormRow]()
        if let barcode = product.barcode, !barcode.isEmpty {
            let localizedLabel = InfoRowKey.barcode.localizedString
            rows.append(FormRow(label: localizedLabel, value: barcode, cellType: InfoRowTableViewCell.self))
        }
        if let quantity = product.quantity, !quantity.isEmpty {
            let localizedLabel = InfoRowKey.quantity.localizedString
            rows.append(FormRow(label: localizedLabel, value: quantity, cellType: InfoRowTableViewCell.self))
        }
        if let array = product.packaging, !array.isEmpty {
            let localizedLabel = InfoRowKey.packaging.localizedString
            rows.append(FormRow(label: localizedLabel, value: array.joined(separator: ", "), cellType: InfoRowTableViewCell.self))
        }
        if let array = product.brands, !array.isEmpty {
            let localizedLabel = InfoRowKey.brands.localizedString
            rows.append(FormRow(label: localizedLabel, value: array.joined(separator: ", "), cellType: InfoRowTableViewCell.self))
        }
        if let manufacturingPlaces = product.manufacturingPlaces, !manufacturingPlaces.isEmpty {
            let localizedLabel = InfoRowKey.manufacturingPlaces.localizedString
            rows.append(FormRow(label: localizedLabel, value: manufacturingPlaces, cellType: InfoRowTableViewCell.self))
        }
        if let origins = product.origins, !origins.isEmpty {
            let localizedLabel = InfoRowKey.origins.localizedString
            rows.append(FormRow(label: localizedLabel, value: origins, cellType: InfoRowTableViewCell.self))
        }
        if let array = product.categories, !array.isEmpty {
            let localizedLabel = InfoRowKey.categories.localizedString
            rows.append(FormRow(label: localizedLabel, value: array.joined(separator: ", "), cellType: InfoRowTableViewCell.self))
        }
        if let array = product.labels, !array.isEmpty {
            let localizedLabel = InfoRowKey.labels.localizedString
            rows.append(FormRow(label: localizedLabel, value: array.joined(separator: ", "), cellType: InfoRowTableViewCell.self))
        }
        if let citiesTags = product.citiesTags, !citiesTags.isEmpty {
            let localizedLabel = InfoRowKey.citiesTags.localizedString
            rows.append(FormRow(label: localizedLabel, value: citiesTags, cellType: InfoRowTableViewCell.self))
        }
        if let array = product.stores, !array.isEmpty {
            let localizedLabel = InfoRowKey.stores.localizedString
            rows.append(FormRow(label: localizedLabel, value: array.joined(separator: ", "), cellType: InfoRowTableViewCell.self))
        }
        if let array = product.countries, !array.isEmpty {
            let localizedLabel = InfoRowKey.countries.localizedString
            rows.append(FormRow(label: localizedLabel, value: array.joined(separator: ", "), cellType: InfoRowTableViewCell.self))
        }

        let rowsSection = FormSection(rows: rows)
        sections.append(rowsSection)

        let form = Form(title: summaryTitle, sections: sections)
        return SummaryFormTableViewController(with: form)
    }

    fileprivate func getIngredientsVC() -> UIViewController {
//        let ingredientsTitle = NSLocalizedString("product-detail.page-title.ingredients", comment: "Product detail, ingredients")

        return UIViewController()

//        var ingredientsInfoRows = [InfoRow]()
//
//        if let ingredientsList = product.ingredientsList, !ingredientsList.isEmpty {
//            ingredientsInfoRows.append(InfoRow(label: .ingredientsList, value: ingredientsList))
//        }
//        if let allergens = product.allergens, !allergens.isEmpty {
//            ingredientsInfoRows.append(InfoRow(label: .allergens, value: allergens))
//        }
//        if let traces = product.traces, !traces.isEmpty {
//            ingredientsInfoRows.append(InfoRow(label: .traces, value: traces))
//        }
//        if let additives = product.additives?.map({ $0.value.uppercased() }).joined(separator: ", "), !additives.isEmpty {
//            ingredientsInfoRows.append(InfoRow(label: .additives, value: additives))
//        }
//        if let array = product.palmOilIngredients, !array.isEmpty {
//            ingredientsInfoRows.append(InfoRow(label: .palmOilIngredients, value: array.joined(separator: ", ")))
//        }
//        if let array = product.possiblePalmOilIngredients, !array.isEmpty {
//            ingredientsInfoRows.append(InfoRow(label: .possiblePalmOilIngredients, value: array.joined(separator: ", ")))
//        }
//
//        return ProductDetailPageViewController<IngredientHeaderTableViewCell, InfoRowTableViewCell>(product: product, localizedTitle: ingredientsTitle, infoRows: ingredientsInfoRows)
    }

    fileprivate func getNutritionVC() -> UIViewController {
        return UIViewController()
//        let nutritionTitle = NSLocalizedString("product-detail.page-title.nutrition", comment: "Product detail, nutrition")
//
//        var nutritionInfoRows = [InfoRow]()
//
//        if let servingSize = product.servingSize, !servingSize.isEmpty {
//            nutritionInfoRows.append(InfoRow(label: .servingSize, value: servingSize))
//        }
//        if let carbonFootprint = product.nutriments?.carbonFootprint, let unit = product.nutriments?.carbonFootprintUnit {
//            nutritionInfoRows.append(InfoRow(label: .carbonFootprint, value:(String(carbonFootprint) + " " + unit)))
//        }
//
//        return ProductNutritionViewController(product: product, localizedTitle: nutritionTitle, infoRows: nutritionInfoRows)
    }

    // swiftlint:disable:next cyclomatic_complexity
    fileprivate func getNutritionTableVC() -> UIViewController {
        return UIViewController()
//        let nutritionTableTitle = NSLocalizedString("product-detail.page-title.nutrition-table", comment: "Product detail, nutrition table")
//        var nutritionTableInfoRows = [InfoRow]()
//
//        let headerRow = InfoRow(label: .nutritionalTableHeader, value: NSLocalizedString("product-detail.nutrition-table.for-100g", comment: ""),
//                                secondaryValue: NSLocalizedString("product-detail.nutrition-table.for-serving", comment: ""))
//
//        nutritionTableInfoRows.append(headerRow)
//
//        if let energy = product.nutriments?.energy, let infoRow = energy.asInfoRow {
//            nutritionTableInfoRows.append(infoRow)
//        }
//        if let fats = product.nutriments?.fats {
//            for item in fats {
//                if let infoRow = item.asInfoRow {
//                    nutritionTableInfoRows.append(infoRow)
//                }
//            }
//        }
//        if let carbohydrates = product.nutriments?.carbohydrates {
//            for item in carbohydrates {
//                if let infoRow = item.asInfoRow {
//                    nutritionTableInfoRows.append(infoRow)
//                }
//            }
//        }
//        if let fiber = product.nutriments?.fiber, let infoRow = fiber.asInfoRow {
//            nutritionTableInfoRows.append(infoRow)
//        }
//        if let proteins = product.nutriments?.proteins {
//            for item in proteins {
//                if let infoRow = item.asInfoRow {
//                    nutritionTableInfoRows.append(infoRow)
//                }
//            }
//        }
//        if let salt = product.nutriments?.salt, let infoRow = salt.asInfoRow {
//            nutritionTableInfoRows.append(infoRow)
//        }
//        if let sodium = product.nutriments?.sodium, let infoRow = sodium.asInfoRow {
//            nutritionTableInfoRows.append(infoRow)
//        }
//        if let alcohol = product.nutriments?.alcohol, let infoRow = alcohol.asInfoRow {
//            nutritionTableInfoRows.append(infoRow)
//        }
//        if let vitamins = product.nutriments?.vitamins {
//            for item in vitamins {
//                if let infoRow = item.asInfoRow {
//                    nutritionTableInfoRows.append(infoRow)
//                }
//            }
//        }
//        if let minerals = product.nutriments?.minerals {
//            for item in minerals {
//                if let infoRow = item.asInfoRow {
//                    nutritionTableInfoRows.append(infoRow)
//                }
//            }
//        }
//
//        return ProductDetailPageViewController<NutritionTableHeaderTableViewCell, NutritionTableRowTableViewCell>(product: product,
//                                                                                                                  localizedTitle: nutritionTableTitle,
//                                                                                                                  infoRows: nutritionTableInfoRows)
    }
}
