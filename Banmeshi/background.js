function create() {
  var url='http://cookpad.com/recipe/' + Math.floor( Math.random() * 1840000 );
  return url;
}

function run() {
  count++;
  var url = create();
  if (count > 10) {
    chrome.tabs.create({url:url});
    return;
  }
  getTitle(url, function(targetUrl, title) {
    if (title == 'レシピ検索No.1／料理レシピ載せるなら クックパッド') {
      run();
    } else {
      chrome.tabs.create({url:url});
    }
  });
}

function getTitle(url, callback) {
  var xhr = new XMLHttpRequest()
  xhr.onload = function() {
    var title = this.responseXML.title || "no title"
    callback(url, title)
  }
  xhr.open("GET", url, true);
  xhr.responseType = "document";
  xhr.send();
}

var count;

chrome.browserAction.onClicked.addListener(function(activeTab) {
  count = 0;
  run();
});
