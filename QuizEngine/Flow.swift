//
//  Flow.swift
//  QuizEngine
//
//  Created by Shadrach Mensah on 25/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question:String, answerCallback:@escaping (String)-> Void)
}


class Flow{
    
    let router:Router
    let questions:[String]
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start(){
        if let first = questions.first{
            router.routeTo(question:first){ [weak self] _ in
                guard let strongSelf = self else {return}
                let indexofFirst = strongSelf.questions.firstIndex(of: first)!
                strongSelf.router.routeTo(question: strongSelf.questions[indexofFirst + 1], answerCallback: {_ in})
            }
        }
    }
}
