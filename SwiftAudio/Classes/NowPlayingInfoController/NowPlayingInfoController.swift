//
//  MediaInfoController.swift
//  SwiftAudio
//
//  Created by Jørgen Henrichsen on 15/03/2018.
//

import Foundation
import MediaPlayer


public class NowPlayingInfoController: NowPlayingInfoControllerProtocol {
    
    private var _infoCenter: NowPlayingInfoCenter
    private var _info: [String: Any] = [:]
    
    var infoCenter: NowPlayingInfoCenter {
        return self._infoCenter
    }
    
    var info: [String: Any] {
        return self._info
    }
    
    public required init() {
        self._infoCenter = MPNowPlayingInfoCenter.default()
    }
    
    public required init(infoCenter: NowPlayingInfoCenter) {
        self._infoCenter = infoCenter
    }
    
    public func set(keyValues: [NowPlayingInfoKeyValue]) {
        DispatchQueue.main.async { [weak self] in
            keyValues.forEach { (keyValue) in
                self!._info[keyValue.getKey()] = keyValue.getValue()
            }
            self!._infoCenter.nowPlayingInfo = self!._info
        }
    }
    
    public func set(keyValue: NowPlayingInfoKeyValue) {
        DispatchQueue.main.async { [weak self] in
            self!._info[keyValue.getKey()] = keyValue.getValue()
            self!._infoCenter.nowPlayingInfo = self!._info
        }
    }
    
    public func clear() {
        self._info = [:]
        self._infoCenter.nowPlayingInfo = self._info
    }
}
