# Import Required Modules
import requests

for modelURI in modelURIs:
    # Web request to check if the model is online
    try:
        response = requests.get(f"https://chaturbate.com/{modelURI}/", timeout=10)
        online = "m3u8" in response.text
    except requests.RequestException:
        online = False

    if online:
        url_start = response.text.find("https://edge")
        url_end = response.text.find(".m3u8", url_start)
        raw_url = response.text[url_start:url_end + 5]
        clean_url = raw_url.replace("\\u002D", "-")
        stream_url = clean_url
        print(stream_url)
    else:
        print("offline")
    time.sleep(10)