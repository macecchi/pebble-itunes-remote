var gui = require('nw.gui');
var iTunesAPI = require('itunes-control-api');
iTunesAPI.start(8080);

var localIP;

require('dns').lookup(require('os').hostname(), function (err, add, fam) {
  localIP = add;
	menu.insert(new gui.MenuItem({
	    label: 'Server running on ' + localIP,
	    enabled: false
	}), 0);
})

var tray = new gui.Tray({
    icon: 'resources/images/bar_icon.png'
});

var menu = new gui.Menu();
tray.menu = menu;


menu.append(new gui.MenuItem({
    type: 'separator'
}));

menu.append(new gui.MenuItem({
    label: 'Exit',
    click: function() { 
    	console.log('Clicked exit menu');
		gui.App.quit();
    }
}));