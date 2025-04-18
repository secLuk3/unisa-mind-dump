import numpy as np
import matplotlib.pyplot as plt
import scipy.linalg as sla


# ## Problema
# 4 utenti e loro valutazioni per 6 stagioni
# 
# |        | Ryne | Erin | Nathan | Pete |
# | --- | --- | --- | --- | --- |
# | season 1 | 5 | 5 | 0 | 5 |
# | season 2 | 5 | 0 | 3 | 4 |
# | season 3 | 3 | 4 | 0 | 3 |
# | season 4 | 0 | 0 | 5 | 3 |
# | season 5 | 5 | 4 | 4 | 5 |
# | season 6 | 5 | 4 | 5 | 5 |



seasons = [1,2,3,4,5,6]
users = ['Ryne', 'Erin', 'Nathan', 'Pete']

A = np.array([            
    [5,5,0,5], # season 1
    [5,0,3,4], # season 2
    [3,4,0,3], # season 3
    [0,0,5,3], # season 4
    [5,4,4,5], # season 5
    [5,4,5,5]  # season 6
    ], dtype=float)


# ## Calcoliamo la SVD di A

print('dimensions of U, s and V')
U, S, V = sla.svd(A)
print(U.shape)
print(S.shape)
print(V.shape)
print('vector of singular values=',S)


# ### rappresentiamo i dati in uno spazio a tre dimensioni

U3 = U[:, :3]
V3 = V.T[:, :3]
S3 = np.diag(S[:3])
print('SVD troncata con k=3. Stampa di U, s e V con 2 cifre decimali')
print('U3=', U3.round(2))
print('S3=', S3.round(2))
print('V3=', V3.round(2))

luke = np.array([5,5,0,0,0,5])
print('valutazioni delle stagioni di Luke',luke)

luke3d = luke.dot(U3.dot(np.linalg.inv(S3)))
print('valutazioni di Luke proiettate nello spazio 3D')
print(luke3d)



# ### Grafichiamo la proiezione dei dati in uno spazio 3D
# 
# Le prime due colonne di U rappresentano le stagioni. Le prime due righe di V rappresentano gli utenti.
# 
#  x rappresenti la prima componente, y la seconda, z la terza

# Plot the projections of the seasons and users in a 3D space
fig = plt.figure()
ax = plt.axes(projection='3d')
ax = plt.gca()
ax.scatter(U3[:,0], U3[:,1], U3[:,2], c='b', marker='o', label='seasons')
ax.scatter(V3[:,0], V3[:,1], V3[:,2], c='r', marker='s', label='users')
ax.scatter(luke3d[0], luke3d[1], luke3d[2], c='g', marker='^', label='Luke')
ax.legend()

# Add labels for seasons and users
for i, txt in enumerate(seasons):
    ax.text(U3[i, 0], U3[i, 1], U3[i, 2], txt, ha='left', va='bottom', fontsize=12)

for i, txt in enumerate(users):
    ax.text(V3[i, 0], V3[i, 1], V3[i,2], txt, ha='right', va='top', fontsize=10)

ax.text(luke3d[0], luke3d[1], luke3d[2], "Luke", ha='right', va='bottom', fontsize=12)

# Set axis labels
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')


#plt.show()
plt.show(block=False) # così non si blocca l'esecuzione dopo il plot

# Osserviamo che gli angoli minori sono tra Luke e Pete e tra Luke e Ryne
# 
# per quantificare la distanza usiamo la similarità coseno
# $$
# similarity (a,b) = (a,b)/(||a|| ||b||)
# $$


print(luke3d.shape)

for i,xy in enumerate(V3):
    angle = np.dot(xy, luke3d) / (np.linalg.norm(xy) * np.linalg.norm(luke3d))
    print("coseno dell'angolo tra %s e %s: %2.2g" % ('luke', users[i], angle))

    


