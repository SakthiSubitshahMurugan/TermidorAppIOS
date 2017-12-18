//
//  TermicideType.swift
//  TermidorApp
//
//  Created by Subitsah, Sakthi on 12/7/17.
//  Copyright © 2017 Subitsah, Sakthi. All rights reserved.
//

import Foundation
public struct TermicideTypeData{
    var termicideTypeCode: String? = nil
    var termicideTypeName: String? = nil
    var dilutionRatio: String? = nil
    var injectionCountFactor: String? = nil
    init(TermicideTypeCode:String,TermicideTypeName:String,DilutionRatio:String,InjectionCountFactor:String){
        self.termicideTypeCode = TermicideTypeCode
        self.termicideTypeName = TermicideTypeName
        self.dilutionRatio = DilutionRatio
        self.injectionCountFactor = InjectionCountFactor
    }
}
