from google import genai

client = genai.Client(api_key="AIzaSyAct4AELhvisu_lxhRBacKYwGtp363gW_I")

myfile = client.files.upload(file="/Users/chaimturkel/Downloads/abc.m4a")

response = client.models.generate_content(
    model="gemini-2.0-flash", contents=["Translate this audio clip in hebrew. Note there are two people in it, and transcribe the conversation in detail in hebrew.", myfile]
)

print(response.text)