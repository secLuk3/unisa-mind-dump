# !/usr/bin/env python
# Implementation of collaborative filtering recommendation engine


from math import sqrt
import json
from prettytable import PrettyTable
from recommendation_data import dataset


def euclidean_distance(person1, person2):
    # Returns ratio Euclidean distance score of person1 and person2

    both_viewed = {}  # To get both rated items by person1 and person2

    for item in dataset[person1]:
        if item in dataset[person2]:
            both_viewed[item] = 1

        # Conditions to check they both have an common rating items
        if len(both_viewed) == 0:
            return 0

        # Finding Euclidean distance
        sum_of_eclidean_distance = []

        for item in dataset[person1]:
            if item in dataset[person2]:
                sum_of_eclidean_distance.append(pow(dataset[person1][item] - dataset[person2][item], 2))
        sum_of_eclidean_distance = sum(sum_of_eclidean_distance)

        return 1 / (1 + sqrt(sum_of_eclidean_distance))


def most_similar_users(person, number_of_users):
    # returns the number_of_users (similar persons) for a given specific person.
    scores = [(euclidean_distance(person, other_person), other_person) for other_person in dataset if
              other_person != person]

    # Sort the similar persons so that highest scores person will appear at the first
    scores.sort()
    scores.reverse()
    return scores[0:number_of_users]


def user_reommendations(person):
    # Gets recommendations for a person by using a weighted average of every other user's rankings
    totals = {}
    simSums = {}
    # don't compare me to myself
    for other in dataset:
        if other == person:
            continue

        sim = euclidean_distance(person, other)
        # print(">>>>>>>",sim)

        # ignore scores of zero or lower
        if sim <= 0:
            continue
        for item in dataset[other]:
            # only score movies i haven't seen yet
            if item not in dataset[person] or dataset[person][item] == 0:
                # Similrity * score
                totals.setdefault(item, 0)
                totals[item] += dataset[other][item] * sim
                # sum of similarities
                simSums.setdefault(item, 0)
                simSums[item] += sim

    # Create the normalized list
    rankings = [(item, total / simSums[item]) for item, total in totals.items()]
    rankings.sort()
    rankings.reverse()
    # returns the recommended items
    #recommendataions_list = [recommend_item for recommend_item, score in rankings]

    return rankings
'''
def calculateSimilarItems(prefs, n=10):
    # Create a dictionary of items showing which other items they
    # are most similar to.
    result = {}
    # Invert the preference matrix to be item-centric
    itemPrefs = transformPrefs(prefs)
    c = 0
    for item in itemPrefs:
        # Status updates for large datasets
        c += 1
        if c % 100 == 0: print("%d / %d" % (c, len(itemPrefs)))
        # Find the most similar items to this one
        scores = most_similar_users(itemPrefs, item, n=n, similarity=sim_distance)
        result[item] = scores
    return result
'''

def transformPrefs(prefs):
    result = {}
    for person in prefs:
        for item in prefs[person]:
            result.setdefault(item, {})
    # Flip item and person
    result[item][person] = prefs[person][item]
    return result

def printSimTable(person):

    filmRaccomandati = user_reommendations(person)

    table1 = PrettyTable()

    table1.field_names = ["Film raccomandato per "+person, "Valutazioni stimate"]
    for item in filmRaccomandati:
        table1.add_row([item[0],round(item[1],2)])

    print(table1)

    table2 = PrettyTable()
    table2.field_names = ["Utente", "Indice similarità con "+person]

    utentiSimili = most_similar_users('Toby', 10)
    for user in utentiSimili:
        table2.add_row([user[1], user[0]])
    print(table2)


    headerTable3 = ["Utente", "Indice similarità con "+person]
    for item in filmRaccomandati:
        headerTable3.append(item[0])
        headerTable3.append("S.x"+str(item[0]).replace(" ", ""))

    table3 = PrettyTable(headerTable3)

    Totale = []
    SimSum = []
    totale = {}
    simsum = {}

    for utente in utentiSimili:

        row = []
        row.append(utente[1])
        row.append(round(utente[0], 2))
        film = dataset[utente[1]]
        for film in filmRaccomandati:

            try:
                totale.setdefault(film[0], 0)
                simsum.setdefault(film[0], 0)
                rank = dataset[utente[1]][film[0]]
                row.append(round(rank, 2))
                rankPerSim = (rank * utente[0])
                row.append(round(rankPerSim, 2))
                totale[film[0]] += rankPerSim
                simsum[film[0]] += round(utente[0], 2)
            except KeyError:
                row.append(0)
                row.append(0)
        table3.add_row(row)


    for film  in filmRaccomandati:
        Totale.append(round(totale[film[0]], 2))
        SimSum.append(round(simsum[film[0]], 2))


    for i in range(len(filmRaccomandati)*2):
        if i % 2 == 0:
            Totale.insert(i, -1)
            SimSum.insert(i, -1)

    rowSim = ["Sim.Sum", " "]
    for i in range(len(filmRaccomandati)*2):
        if (i % 2 != 0):
            rowSim.append(SimSum[i])
        else:
            rowSim.append(" ")

    rowTotal = ["Totale", " "]
    for i in range(len(filmRaccomandati)*2):
        if (i % 2 != 0):
            rowTotal.append(Totale[i])
        else:
            rowTotal.append(" ")

    rowTotSim = ["Total/Sim.Sum", " "]
    for i in range(len(filmRaccomandati)*2):
        if (i % 2 != 0):
            rowTotSim.append(round(Totale[i] / SimSum[i], 2))
        else:
            rowTotSim.append(" ")

    table3.add_row(rowTotal)
    table3.add_row(rowSim)
    table3.add_row(rowTotSim)
    print(table3)


def getBookList(withOutperson, ds):
    booklist = []
    if withOutperson != "":
        users = getUserListWithoutPerson(withOutperson, ds)
    else:
        users = getCompleteUserList(ds)

    for user in users:
        for item in ds[user]:
            booklist.insert(len(booklist), item)

    booklist = set(booklist) #Elimino duplicati
    return list(booklist)


def getUserListWithoutPerson(person, dt):
    others = []
    for other in dt:
        if other == person:
            continue
        others.insert(len(other), other)  # Aggiungo alla fine
    return others #Lista persone senza la persona in input

def getCompleteUserList(ds):
    others = []
    for other in ds:
         others.insert(len(other), other)  # Aggiungo alla fine
    return others  # Lista persone

def riempiCampiVuoti(ds, person):
    newDs = datasetWithouPerson(person, ds)
    bookList = getBookList(person, newDs)
    if person != "":
        userList = getUserListWithoutPerson(person, newDs)
    else:
        userList = getCompleteUserList(newDs)

    for user in userList:
        for book in bookList:
            if book not in newDs[user]:
                newDs[user].update({book: 0});

    return ds

def datasetWithouPerson(person, ds):
    if person in ds:
        ds.pop(person)
    return ds


def convertiDictInFile(dict):
    with open('convert.py', 'w') as convert_file:
        convert_file.write(json.dumps(dict))


print(user_reommendations('Toby'))
printSimTable('Toby')

