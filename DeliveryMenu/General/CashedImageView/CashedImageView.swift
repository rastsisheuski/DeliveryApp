//
//  CashedImageView.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 13.11.22.
//

//import Foundation
//import UIKit
//
//class CachedImageView: UIImageView {
//    
//    var imageURL: String?
//    
//// MARK: -
//// MARK: - Public Methods
//    
//    func load(url: String?) {
//        imageURL = url
//        // проверяем валидность урла и может ли он быть передан в качестве аргумента
//        guard let urlString = url, let url = URL(string: urlString) else {
//            image = nil
//            return
//        }
//        // проверяем была ли эта картинка закэширована по данному урлу
//        if let imageResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
//            image = UIImage(data: imageResponse.data)
//            return
//        }
//        // если не закэширована она была ранее, то мы грузим её с нета
//        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
//        // асинхронно проверяем действительно ои нам пришли данные (data - это сама картинка, а response - это ответ от сервера, он потом будет нужен для сохранения картинка в кэш)
//            DispatchQueue.main.async {
//                guard let data = data, let response = response else { return }
//                self?.saveImageInCache(response: response, data: data)
//            }
//        }.resume()
//    }
//

//// MARK: -
//// MARK: - Private Methods
//    
//    private func saveImageInCache(response: URLResponse, data: Data) {
//        guard let url = response.url else { return }
//        // сохраняем наш объект
//        let cachedResponse = CachedURLResponse(response: response, data: data)
//        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
//        
//        if response.url?.absoluteString == imageURL {
//            image = UIImage(data: data)
//        }
//    }
//}
