//
//  Flow.swift
//  QuizEngine
//
//  Created by Shadrach Mensah on 25/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question:String)
}


class Flow{
    
    let router:Router
    let questions:[String]
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start(){
        if !questions.isEmpty{
             router.routeTo(question: "")
        }
    }
}
