//
//  WatchStream.swift
//  CTAProjectTests
//
//  Created by Tomoya Tanaka on 2022/02/28.
//

import RxSwift
import RxTest

struct WatchStream<Element> {
    let scheduler: TestScheduler
    let observer: TestableObserver<Element>
    let disposeBag = DisposeBag()

    init<O: ObservableType>(_ observable: O,
                            scheduler: TestScheduler = .init(initialClock: 0))
    where O.Element == Element {
        self.scheduler = scheduler
        self.observer = scheduler.createObserver(Element.self)
        observable
            .subscribe(observer)
            .disposed(by: disposeBag)
    }

    var value: Element? {
        return observer.events.last.flatMap { $0.value }?.element
    }
}
