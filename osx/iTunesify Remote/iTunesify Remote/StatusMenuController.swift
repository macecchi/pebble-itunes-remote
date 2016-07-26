import Cocoa

protocol StatusMenuControllerDelegate: class {
    func didSelect(player: String)
    func didSelect(systemVolume: Bool)
}

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var hostMenu: NSMenuItem!
    @IBOutlet weak var versionMenu: NSMenuItem!
    @IBOutlet weak var iTunesMenu: NSMenuItem!
    @IBOutlet weak var spotifyMenu: NSMenuItem!
    @IBOutlet weak var globalVolumeMenu: NSMenuItem!
    @IBOutlet weak var playerVolumeMenu: NSMenuItem!
    
    weak var delegate: StatusMenuControllerDelegate?
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib() {
        let icon = NSImage(named: "StatusBarIcon")
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        // TODO: update ip
        
        let appName = Bundle.main.appName
        let appVersion = Bundle.main.appVersion
        versionMenu.title = "\(appName) v\(appVersion)"
    }
    
    func setSelected(player: String) {
        if player == "itunes" {
            iTunesMenu.state = NSOnState
            spotifyMenu.state = NSOffState
        } else if player == "spotify" {
            iTunesMenu.state = NSOffState
            spotifyMenu.state = NSOnState
        }
    }
    
    func setSelected(systemVolume: Bool) {
        if systemVolume {
            globalVolumeMenu.state = NSOnState
            playerVolumeMenu.state = NSOffState
        } else {
            globalVolumeMenu.state = NSOffState
            playerVolumeMenu.state = NSOnState
        }
    }
    
    // MARK: Actions
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

    @IBAction func didTapiTunesMenu(_ sender: NSMenuItem) {
        let player = "itunes"
        setSelected(player: player)
        delegate?.didSelect(player: player)
    }
    
    @IBAction func didTapSpotifyMenu(_ sender: NSMenuItem) {
        let player = "spotify"
        setSelected(player: player)
        delegate?.didSelect(player: player)
    }
    
    @IBAction func didTapGlobalVolumeMenu(_ sender: NSMenuItem) {
        let systemVolume = true
        setSelected(systemVolume: systemVolume)
        delegate?.didSelect(systemVolume: systemVolume)
    }
    
    @IBAction func didTapPlayerVolumeMenu(_ sender: AnyObject) {
        let systemVolume = false
        setSelected(systemVolume: systemVolume)
        delegate?.didSelect(systemVolume: systemVolume)
    }
}
