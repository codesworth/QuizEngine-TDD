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
    func routeTo(result:[String:String])
}


class Flow{
    
    private let router:Router
    private let questions:[String]
    private var result:[String:String] = [:]
    init(questions:[String],router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start(){
        if let first = questions.first{
            router.routeTo(question:first, answerCallback: nextCallback(from: first))
            
        }else{
           router.routeTo(result: [:])
        }
        
    }
    
    func nextCallback(from question:String) -> Router.AnswerCallback{
        return {[weak self] in self?.routeNext(question,$0)}
    }
    
    
    private func routeNext(_ question:String,_ answer:String){
        if let currentQuestionIndex = questions.firstIndex(of: question){
            result.updateValue(answer, forKey: question)
            let nextIndex = currentQuestionIndex + 1
            if nextIndex < questions.endIndex{
                let nextquestion = questions[nextIndex]
                router.routeTo(question:nextquestion , answerCallback:nextCallback(from: nextquestion))
            }else{
               router.routeTo(result: result)
            }
            
        }
    }
}
