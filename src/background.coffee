create = () ->
  url = "https://cookpad.com/recipe/#{Math.floor Math.random() * 2590000}"
  return url

getTitle = (url, callback) ->
  xhr = new XMLHttpRequest()
  xhr.onload = () ->
    title = this.responseXML.title || "no title"
    callback(url, title)
  xhr.open "GET", url, true
  xhr.responseType = "document"
  xhr.send()


run = () ->
  count += 1
  url = create()
  if count > 10
    chrome.tabs.create
      url: url
    return 0
  getTitle url, (targetUrl, title) ->
    if title == 'レシピ検索No.1／料理レシピ載せるなら クックパッド'
      run()
    else
      chrome.tabs.create
        url: url

chrome.browserAction.onClicked.addListener (activeTab) ->
  count = 0
  run()
