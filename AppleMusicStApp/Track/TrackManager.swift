//
//  TrackManager.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import AVFoundation

class TrackManager { // 곡들을 로딩, 세팅 ..
    // TODO: 프로퍼티 정의하기 - 트랙들, 앨범들, 오늘의 곡(헤더뷰)
    var tracks : [AVPlayerItem] = []
    var albums : [Album] = []
    var todaysTrack: AVPlayerItem?
    
    // TODO: 생성자 정의하기
    init() {
        // 트랙 로딩
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
        
//
//        let playerItem = AVPlayerItem(url:URL) // local URL / 스트리밍되는 주소
    }

    // TODO: 트랙 로드하기
    func loadTracks() -> [AVPlayerItem] {
        // 파일을 읽어서 AVPlayerItem 객체로 가져옴
        // 파일들의 위치(url)
        // Bundle : 이 앱 내의 바운더리 = 앱 내의 mp3 파일들
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        

//      (1)
        let items = urls.map{url-> AVPlayerItem in
            let item = AVPlayerItem(url:url)
            return item
        }
        
//        (2)
//        var items: [AVPlayerItem]=[]
//        for url in urls{
//            let item = AVPlayerItem(url:url)
//            items.append(item)
//        }

//        (3)
//        let items = urls.map { url in
//            return AVPlayerItem(url:url)
//        }
//
// (1)-(3) 모두 동일
        
        return items
    }
    
    // TODO: 인덱스에 맞는 트랙 로드하기
    func track(at index: Int) -> Track? {
        let playerItem = tracks[index]
        // playerItem -> track
        let track = playerItem.convertToTrack()
        return track
    }

    // TODO: 앨범 로딩메소드 구현
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList : [Track] = tracks.compactMap{ $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList, by: { (track) in track.albumName }) //앨범 이름 별로 트랙들을 나눈 것
        var albums:[Album] = []
        for (key,value) in albumDics{
            let title = key
            let tracks = value
            let album = Album(title:title,tracks:tracks)
            albums.append(album)
        }
          return albums
    }

    // TODO: 오늘의 트랙 랜덤으로 선책
    func loadOtherTodaysTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
}
