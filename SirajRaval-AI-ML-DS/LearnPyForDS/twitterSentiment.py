import tweepy
from textblob import TextBlob

consumer_key = '9E3QNPxals5yb0yfnnN0XXXXX'
consumer_secret = 'XXXXXv7Kwm40D4MNjfpCljqW0mVFmrh7BGZhgQ1W7Zfu4XXXXX'

access_token = '244854250-CCnlhn37pwPwUXRGLbgPAhbMRJKlJ2E3XXXXXXXX'
access_token_secret = 't4Kwep0VzMWdvR7NNa0bu6ue0G86934alV9XHXXXXXXXX'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

public_tweets = api.search('Trump')

for tweet in public_tweets:
	print(tweet.text)
	analysis = TextBlob(tweet.text)
	print(analysis.sentiment)

