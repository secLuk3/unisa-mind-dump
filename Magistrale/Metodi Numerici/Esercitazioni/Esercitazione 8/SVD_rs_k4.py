import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D


seasons = [1,2,3,4,5,6]
users = ['Ryne', 'Erin', 'Nathan', 'Pete']
# 4 utenti e loro valutazioni per 6 stagioni
A = np.array([
    [5, 5, 0, 5],  # season 1
    [5, 0, 3, 4],  # season 2
    [3, 4, 0, 3],  # season 3
    [0, 0, 5, 3],  # season 4
    [5, 4, 4, 5],  # season 5
    [5, 4, 5, 5]  # season 6
], dtype=float)

U, S, V = np.linalg.svd(A, full_matrices=False)

# k=4
U4 = U[:, :4]
V4 = V[:, :4]
S4 = np.diag(S[:4])

# Proiezione delle valutazioni di Luke
luke = np.array([5, 5, 0, 0, 0, 5])
luke4d = luke.dot(U4.dot(np.linalg.inv(S4)))

print("Valutazione Luke nello spazio 4D", luke4d)

# Osserviamo che gli angoli minori sono tra Luke e Pete e tra Luke e Ryne
#
# per quantificare la distanza usiamo la similarità coseno
# $$
# similarity (a,b) = (a,b)/(||a|| ||b||)
# $$
print(luke4d.shape)
for i, xy in enumerate(V4):
    angle = np.dot(xy, luke4d) / (np.linalg.norm(xy) * np.linalg.norm(luke4d))
    print("coseno dell'angolo tra %s e %s: %2.2g" % ('luke', users[i], angle))




