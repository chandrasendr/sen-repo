#Breaking it down
#1. Recommendation algorithms help us make decisions by learning our preferences
#2. Two types - content based & collaborative
#3. LightFM is great for getting started with recommendations


import numpy as np
from lightfm.datasets import fetch_movielens
from lightfm import LightFM

# fetch data and format it
data = fetch_movielens(min_rating=4.0)

#printtraining and testing data, fetch_movielens method will fetch and stores test and 
#train data
print(repr(data['train'])) 
print(repr(data['test']))

#create model. warp --> Weighted Approximate-Rank Pairwise model uses gradient descent 
#algorithm to iteratively find the weights and improve our prediction 
#over time. It's a hybrid model which uses both Content based + Collaborative based 
#recommendation system
model = LightFM(loss='warp')
#train model
model.fit(data['train'], epochs=30, num_threads=2)

def sample_recommendation(model, data, user_ids):

	#number of users and movies in training data
	n_users, n_items = data['train'].shape

	#generate recommendations for each user we input
	for user_id in user_ids:

		#movies they already like
		known_positives = data['item_labels'][data['train'].tocsr()[user_id].indices]

		#movies our model predicts they will like
		scores = model.predict(user_id, np.arange(n_items))
		#rank them in order of most liked to least
		top_items = data['item_labels'][np.argsort(-scores)]

		#print out the results
		print("User %s" % user_id)
		print("			known positives:")

		for x in known_positives[:3]:
			print("				%s" % x)

		print("		Recommended:")

		for x in top_items[:3]:
			print("			%s" % x)

sample_recommendation(model, data, [3, 25, 450])
