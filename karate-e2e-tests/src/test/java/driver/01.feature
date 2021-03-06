Feature:

Background:
* driver serverUrl + '/01'

Scenario:
# assert page url
# match driver.url == serverUrl + '/01'
# safer
* waitForUrl(serverUrl + '/01')

# assert page title
* match driver.title == 'Page 01'

# before refresh()
* match text('#pageLoadCount') == '1'

# refresh page
* refresh()
* def expected = driverType == 'safaridriver' ? '1' : '2'
* waitForText('#pageLoadCount', expected)

# reload page
* reload()
* def expected = driverType == 'safaridriver' ? '1' : '3'
* waitForText('#pageLoadCount', expected)

# navigate to new page
* click('a')

# wait for new page to load
* waitForUrl(serverUrl + '/02')

# assert for driver title
# * match driver.title == 'Page 02'
# safer
* waitUntil("document.title == 'Page 02'")

# browser navigation: back
* back()

# wait for page to re-load
* waitForUrl(serverUrl + '/01')

# * match driver.title == 'Page 01'
# safer
* waitUntil("document.title == 'Page 01'")

# browser navigation: forward
* forward()

# wait for page to re-load
* waitForUrl(serverUrl + '/02')

# * match driver.title == 'Page 02'
# safer
* waitUntil("document.title == 'Page 02'")

* if (driverType == 'playwright') karate.abort()

# driver.dimensions
* match driver.dimensions contains { x: '#number', y: '#number', width: '#number', height: '#number' }
