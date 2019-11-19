#!/bin/python

import os, re, requests, string, subprocess, tempfile, time

from slackclient import SlackClient  # Run "pip install slackclient" if this fails

# Generate user token at https://api.slack.com/custom-integrations/legacy-tokens
token = '<add token here>'
sc = SlackClient(token)

# Go to the Slack customize page and evaluate "TS.boot_data.api_token" in the console.
xoxs_token = '<add token here>'

# (channel_id, msg_id) = parse('https://workspace.slack.com/archives/C1234567890/p1234567890123456')
def parse(msg_url):
    match = re.match('.+/([^/]+)/p(\d{10})(\d{6})', msg_url)
    return (match.group(1), match.group(2) + '.' + match.group(3))

# send('#bot-dev', 'Hello everyone!')
def send(channel, msg):
    sc.api_call("chat.postMessage",
            channel=channel,
            text=msg,
            as_user=True)
    return

# react('https://workspace.slack.com/archives/C1234567890/p1234567890123456', 'thumbsup')
def react(msg_url, reaction):
    (channel_id, msg_id) = parse(msg_url)
    sc.api_call("reactions.add",
            channel=channel_id,
            name=reaction,
            timestamp=msg_id)
    return

# react('https://workspace.slack.com/archives/C1234567890/p1234567890123456', 'A message in reactions')
def react_string(msg_url, s):
    letter_map = {}
    for c in s.lower():
        if c in string.lowercase:
            if c in letter_map:
                react(msg_url, '-{}{}'.format(c, letter_map[c] + 1))
                letter_map[c] += 1
            else:
                react(msg_url, '-{}'.format(c))
                letter_map[c] = 1

def upload_emoji(emoji_name, image_url):
    fd, path = tempfile.mkstemp()
    try:
        with open(fd, 'wb') as fh:
            fh.write(requests.get(image_url).content)
        subprocess.Popen([
            'curl',
            '-X', 'POST',
            'https://slack.com/api/emoji.add',
            '-H', 'Authorization: Bearer {}'.format(xoxs_token),
            '-F', 'mode=data',
            '-F', 'name={}'.format(emoji_name),
            '-F', 'image=@{}'.format(TEMP_FILE),
            ])
        time.sleep(1)
    finally:
        os.remove(path)

