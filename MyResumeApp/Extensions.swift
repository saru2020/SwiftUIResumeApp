//
//  Extensions.swift
//  MyResumeApp
//
//  Created by Saravanan on 02/12/19.
//  Copyright © 2019 Saravanan Vijayakumar. All rights reserved.
//

import UIKit

extension UIView {
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIView {
    
    // Export pdf from Save pdf in drectory and return pdf file path
    func exportAsPdfFromView() -> String {
        
        var size = self.bounds.size
        size.height = 2000
        let pdfPageFrame = CGRect(origin: self.bounds.origin, size: size)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageFrame, nil)
        UIGraphicsBeginPDFPageWithInfo(pdfPageFrame, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return "" }
        self.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
        savePDF(data: pdfData)
        return self.saveViewPdf(data: pdfData)
        
    }
    
    func savePDF(data: NSMutableData) {
        let fileManager = FileManager.default
        fileManager.createFile(atPath: "/Users/saravanan_vij/Desktop/exportedPdf.pdf", contents: data as Data, attributes: nil)
    }
    
    // Save pdf file in document directory
    func saveViewPdf(data: NSMutableData) -> String {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDirectoryPath = paths[0]
        let pdfPath = docDirectoryPath.appendingPathComponent("viewPdf.pdf")
        if data.write(to: pdfPath, atomically: true) {
            return pdfPath.path
        }
        return ""
    }
}
