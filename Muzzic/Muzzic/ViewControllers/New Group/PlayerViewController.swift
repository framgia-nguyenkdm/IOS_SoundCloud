//
//  PlayerViewController.swift
//  Muzzic
//
//  Created by khuc.d.m.nguyen on 4/16/18.
//  Copyright © 2018 khuc.d.m.nguyen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

class PlayerViewController: UIViewController {
    @IBOutlet private weak var songImg: UIImageView!
    @IBOutlet private weak var songNameLabel: UILabel!
    @IBOutlet private weak var songSingerLabel: UILabel!
    @IBOutlet private weak var songCurrentTimeLabel: UILabel!
    @IBOutlet private weak var songEndTimeLabel: UILabel!
    @IBOutlet private weak var mySlider: UISlider!

    @IBOutlet private weak var shuffleButton: UIButton!
    @IBOutlet private weak var playPauseButton: UIButton!

    fileprivate var player: AVPlayer?
    fileprivate var playerItem: AVPlayerItem?
    fileprivate var timeObserver: Any?
    var trackIndex = 0
    var songs = [Song]()
    var shuffleType = Shuffle.random

    override func viewDidLoad() {
        super.viewDidLoad()

        bindUISongDetailAndPlayTrack(index: trackIndex)
        configBackgroundMode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    @IBAction func tapNext(_ sender: Any) {
        showNextSong()
    }

    @IBAction func tapPlayPause(_ sender: Any) {
        playOrPauseSong()
    }

    @IBAction func tapPrevious(_ sender: Any) {
        showPreviousSong()
    }

    @IBAction func tapDownload(_ sender: Any) {
        downloadSong()
    }

    @IBAction func tapShuffle(_ sender: Any) {
        changeShuffleType()
    }

    @IBAction func changeTimeSlider(_ sender: Any) {
        let seconds: Int64 = Int64(mySlider.value)
        let targetTime: CMTime = CMTimeMake(seconds, 1)

        player?.seek(to: targetTime)
        if player?.rate == 0 {
            player?.play()
        }
    }

    @IBAction func tapDismissView(_ sender: Any) {
        dismissViewPlayer()
    }
}
// MARK: - AVPlayer config
extension PlayerViewController {
    func playAudioWithPath(urlStr: String) {
        if let url = URL(string: urlStr) {
            // Check time observer and remove if needed
            if let ob = self.timeObserver {
                if player?.rate == 1.0 {
                    player?.removeTimeObserver(ob)
                    player?.pause()
                }
            }
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)

            player?.play()
            configTimeSlider()
            playPauseButton.setImage(UIImage(named: "icon_pause"), for: .normal)

            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerDidFinishPlaying(note:)),
                                                   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                   object: player?.currentItem)
        }
        // MARK: Observe the change of duration time
        self.timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1),
                                        queue: DispatchQueue.main, using: { (progressTime) in
            if self.player?.currentItem?.status == .readyToPlay {
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsStr = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minutesStr = String(format: "%02d", Int(seconds / 60))
                self.songCurrentTimeLabel.text  = "\(minutesStr):\(secondsStr)"

                self.mySlider.value = Float(CMTimeGetSeconds(self.player!.currentItem!.currentTime()))
            }
        })
    }

    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        playNextSong()
    }

    func configTimeSlider() {
        mySlider.minimumValue = 0
        let duration: CMTime = (playerItem?.asset.duration)!
        let seconds: Float64 = CMTimeGetSeconds(duration)
        mySlider.maximumValue = Float(seconds)

        let secondsStr = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
        let minutesStr = String(format: "%02d", Int(seconds / 60))
        self.songEndTimeLabel.text  = "\(minutesStr):\(secondsStr)"
    }

    func configBackgroundMode() {
        let audiSession = AVAudioSession.sharedInstance()
        do {
            try audiSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {

        }
    }
}

// MARK: - AVPlayer Notification
extension PlayerViewController {

    func configNotification(trackIndex: Int) {
        let currentSong = songs[trackIndex]
        let artwork = MPMediaItemArtwork(boundsSize: #imageLiteral(resourceName: "icon_disk").size) { (_ ) -> UIImage in
            return #imageLiteral(resourceName: "icon_disk")
        }

        let duration: CMTime = (playerItem?.asset.duration)!
        let seconds: Float64 = CMTimeGetSeconds(duration)
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: currentSong.name,
            MPMediaItemPropertyArtist: currentSong.singer,
            MPMediaItemPropertyPlaybackDuration: seconds,
            MPMediaItemPropertyArtwork: artwork ]

        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
    }

    override func remoteControlReceived(with event: UIEvent?) {
        if let event = event {
            if event.type == .remoteControl {
                switch event.subtype {
                case .remoteControlPlay:
                    player?.play()
                case .remoteControlPause:
                    player?.pause()
                case .remoteControlNextTrack:
                    showNextSong()
                case .remoteControlPreviousTrack:
                    showPreviousSong()
                default :
                    print("Its oke")
                }
            }
        }
    }
}

// MARK: - AVPlayer Actions
extension PlayerViewController {

    func bindUISongDetailAndPlayTrack(index: Int) {
        let currentSong = songs[index]
        print("\(index)---\(currentSong.name)")
        self.songNameLabel.text = currentSong.name
        self.songSingerLabel.text = currentSong.singer
        self.songImg.loadImgFrom(urlLink: currentSong.imageLink)

        let urlStr = currentSong.stream + "?client_id=\(UserProfile.myClientID)"
        playAudioWithPath(urlStr: urlStr)
        configNotification(trackIndex: index)
    }

    func changeShuffleType() {
        switch shuffleType {
        case .loop1:
            shuffleButton.setImage(UIImage(named: "icon_repeat"), for: .normal)
            shuffleType = .loopAll
        case .loopAll:
            shuffleButton.setImage(UIImage(named: "icon_non_repeat"), for: .normal)
            shuffleType = .nonLoop
        case .nonLoop:
            shuffleButton.setImage(UIImage(named: "icon_shuffle"), for: .normal)
            shuffleType = .random
        case .random:
            shuffleButton.setImage(UIImage(named: "icon_repeat1"), for: .normal)
            shuffleType = .loop1
        }
        print("Shuffle type: \(shuffleType)")
    }

    func playNextSong() {
        switch shuffleType {
        case .loopAll, .nonLoop:
            trackIndex += 1
            if trackIndex >= songs.count {
                if shuffleType == Shuffle.nonLoop {
                    dismissViewPlayer()
                } else {
                    trackIndex = 0
                }
            }
        case .random:
            var randomNumb = Int(arc4random_uniform(UInt32(songs.count)))
            while randomNumb == trackIndex {
                randomNumb = Int(arc4random_uniform(UInt32(songs.count)))
            }
            trackIndex = randomNumb
        case .loop1:
            break
        }

        if trackIndex < songs.count {
            bindUISongDetailAndPlayTrack(index: trackIndex)
        }
    }

    func showNextSong() {
        switch shuffleType {
        case .loop1, .loopAll, .nonLoop:
            trackIndex += 1
            if trackIndex == songs.count {
                trackIndex = 0
            }
        case .random:
            var randomNumb = Int(arc4random_uniform(UInt32(songs.count)))
            while randomNumb == trackIndex {
                randomNumb = Int(arc4random_uniform(UInt32(songs.count)))
            }
            trackIndex = randomNumb
        }
        bindUISongDetailAndPlayTrack(index: trackIndex)
    }

    func showPreviousSong() {
        switch shuffleType {
        case .loop1, .loopAll, .nonLoop:
            trackIndex -= 1
            if trackIndex == 0 {
                trackIndex = songs.count - 1
            }
        case .random:
            var randomNumb = Int(arc4random_uniform(UInt32(songs.count)))
            while randomNumb == trackIndex {
                randomNumb = Int(arc4random_uniform(UInt32(songs.count)))
            }
            trackIndex = randomNumb
        }
        bindUISongDetailAndPlayTrack(index: trackIndex)
    }

    func playOrPauseSong() {
        if player?.rate == 0 {
            player?.play()
            let pausedImg = UIImage(named: "icon_pause")
            playPauseButton.setImage(pausedImg, for: .normal)
        } else {
            player?.pause()
            let playdImg = UIImage(named: "icon_play")
            playPauseButton.setImage(playdImg, for: .normal)
        }
    }

    func downloadSong() {

    }

    func dismissViewPlayer() {
        self.dismiss(animated: true) {
            self.player?.pause()
            self.player = nil
            NotificationCenter.default.removeObserver(self)
        }
    }
}
