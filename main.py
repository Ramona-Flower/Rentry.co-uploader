import requests

def create_rentry_paste(text, custom_url="", edit_code=""):
    session = requests.Session()
    response = session.get("https://rentry.co")
    csrf_token = session.cookies.get_dict().get("csrftoken", "")
    data = {
        "csrfmiddlewaretoken": csrf_token,
        "text": text,
        "metadata": "",
        "edit_code": edit_code,
        "url": custom_url
    }
    headers = {"Referer": "https://rentry.co"}
    post_response = session.post("https://rentry.co/api/new", data=data, headers=headers)
    return post_response.json()

print(create_rentry_paste("Hello custom!", "Ramona", "Ramona"))
