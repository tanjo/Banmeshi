chrome.browserAction.onClicked.addListener(function(activeTab) {
  url='http://cookpad.com/recipe/' + Math.floor( Math.random() * 1840000 );
  chrome.tabs.create( { url: url} );
});
