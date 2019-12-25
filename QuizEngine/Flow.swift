//
//  Flow.swift
//  QuizEngine
//
//  Created by Shadrach Mensah on 25/12/2019.
//  Copyright © 2019 Shadrach Mensah. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String)-> Void
    func routeTo(question:String, answerCallback:@escaping AnswerCallback)
}


class Flow{
    
    private let router:Router
    private let questions:[String]
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start(){
        if let first = questions.first{
            router.routeTo(question:first, answerCallback: routeNext(from: first))}
    }
    
    func routeNext(from question:String) -> Router.AnswerCallback{
        return {[weak self] _ in
            guard let sself = self else {return}
            if let currentQuestionIndex = sself.questions.firstIndex(of: question){
                if currentQuestionIndex + 1 < sself.questions.endIndex{
                    let nextquestion = sself.questions[currentQuestionIndex + 1]
                    sself.router.routeTo(question:nextquestion , answerCallback:sself.routeNext(from: nextquestion))
                }
            }
        }
    }
}
