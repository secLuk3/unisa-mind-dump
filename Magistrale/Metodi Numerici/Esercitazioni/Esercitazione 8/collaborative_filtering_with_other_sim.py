from recommendation_data import dataset
from math import sqrt
from prettytable import PrettyTable


def pearson_correlation(dataset, person1, person2):
    # Per ottenere entrambi gli articoli valutati
    both_rated = {}
    for item in dataset[person1]:
        if item in dataset[person2]:
            both_rated[item] = 1

    number_of_ratings = len(both_rated)

    # Verifica del numero di valutazioni in comune
    if number_of_ratings == 0:
        return 0

    # Somma tutte le preferenze di ogni utente
    person1_preferences_sum = sum([dataset[person1][item] for item in both_rated])
    person2_preferences_sum = sum([dataset[person2][item] for item in both_rated])

    # Somma i quadrati delle preferenze di ogni utente
    person1_square_preferences_sum = sum([pow(dataset[person1][item], 2) for item in both_rated])
    person2_square_preferences_sum = sum([pow(dataset[person2][item], 2) for item in both_rated])

    # Somma il valore del prodotto di entrambe le preferenze per ogni articolo
    product_sum_of_both_users = sum([dataset[person1][item] * dataset[person2][item] for item in both_rated])

    # Calcola la pearson score
    numerator_value = product_sum_of_both_users - (
                person1_preferences_sum * person2_preferences_sum / number_of_ratings)
    denominator_value = sqrt((person1_square_preferences_sum - pow(person1_preferences_sum, 2) / number_of_ratings) * (
                person2_square_preferences_sum - pow(person2_preferences_sum, 2) / number_of_ratings))
    if denominator_value == 0:
        return 0
    else:
        r = numerator_value / denominator_value
        return r


# Voto medio di un utente
def average_ranking(dataset, person):
    average_rank = 0;
    item_voted = 0;

    for item in dataset[person]:
        average_rank += dataset[person][item]
        item_voted += 1

    average_rank /= item_voted

    return average_rank

def most_similar_users(person, number_of_users):
    # returns the number_of_users (similar persons) for a given specific person.
    scores = [(pearson_correlation(dataset, person, other_person), other_person) for other_person in dataset if
              other_person != person]

    # Sort the similar persons so that highest scores person will appear at the first
    scores.sort()
    scores.reverse()
    return scores[0:number_of_users]

# Ottiene consigli per una persona utilizzando una media ponderata delle classifiche di ogni altro utente
def user_recommendations(dataset, person):

    totals = {}
    simSums = {}

    # Voto medio di person ( Toby)
    votoMedioPerson = average_ranking(dataset, person)

    for other in dataset:

        if other == person:
            continue
        sim = pearson_correlation(dataset, person, other)


        # ignora punteggio di 0 o minore
        if sim <= 0:
            continue
        for item in dataset[other]:

            #Calcolo punteggi del film che person non ha visto
            if item not in dataset[person] or dataset[person][item] == 0:
                votoMedioOther = average_ranking(dataset, other)


                totals.setdefault(item, 0)
                # numeratore = similarita' * (voto espresso da other - voto medio di other)
                totals[item] += sim * (dataset[other][item] - votoMedioOther)
                # somma di tutte le similarita' (per denominatore)
                simSums.setdefault(item, 0)
                simSums[item] += sim


    # Creo la lista di rank finale (voto medioPerson + numeratore / denominatore)
    rankings = [(votoMedioPerson + total / simSums[item], item) for item, total in totals.items()]
    rankings.sort()
    rankings.reverse()

    return rankings

def printSimTable(person):

    filmRaccomandati = user_recommendations(dataset, person)
    table1 = PrettyTable()

    table1.field_names = ["Film raccomandato per "+person, "Valutazioni stimate"]
    for item in filmRaccomandati:
        table1.add_row([item[1],round(item[0],2)])

    print(table1)

    table2 = PrettyTable()
    table2.field_names = ["Utente", "Indice similarità con "+person]

    utentiSimili = most_similar_users('Toby', 10)
    for user in utentiSimili:
        table2.add_row([user[1], round(user[0], 2)])
    print(table2)


    headerTable3 = ["Utente", "Indice similarità con "+person]
    for item in filmRaccomandati:
        headerTable3.append(item[0])
        headerTable3.append("S.x"+str(item[0]).replace(" ", ""))


printSimTable('Toby')