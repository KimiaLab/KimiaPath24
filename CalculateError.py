import numpy as np
import h5py as h5
import sys
from sklearn.metrics import accuracy_score, confusion_matrix

data_file_path = sys.argv[1]
csv_file_path = sys.argv[2]

data = h5.File(data_file_path, 'r')
correct_labels = data['/test_data/targets']
predicted_labels = np.genfromtxt(csv_file_path)

np = accuracy_score(correct_labels, predicted_labels)*100.
cnf_mat = confusion_matrix(correct_labels, predicted_labels)
e = cnf_mat.diagonal()
nw = (e/cnf_mat.sum(axis=0)).mean()*100.
n_total = (nw*np)/100.

print n_total
