//
//  ConfigurableView.swift
//  SeSAC4RecapAssignment
//
//  Created by Minho on 1/29/24.
//

protocol ConfigurableView {
    func configureHierarchy() // MARK: 부모 뷰에 서브뷰 붙이기
    func configureLayout() // MARK: 뷰 요소에 대한 제약 정의
    func configureView() // MARK: 뷰 요소에 대한 속성 정의
}
