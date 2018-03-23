from scipy.io import loadmat

for i in range(12,13):
    matfile = loadmat('result_{}.mat'.format(i))

    # Obtain parameters from .mat file
    n = int(matfile['n'][0][0])
    vocab_size = matfile['k'][0][0]
    vocab_ratio = matfile['r'][0][0]
    n_pos = matfile['n_pos'][0][0]
    n_neg = matfile['n_neg'][0][0]
    method = matfile['method'][0]
    kernel_type = 'linear'
    size = 4
    step = 1
    if method == 'dsift':
        size = 3
        step = 10

    # Obtain results from .mat file
    label = 0
    img = 0
    ap = [round(float(elem),2) for elem in matfile['AP'][0]]
    mean_ap = round(matfile['MAP'][0][0],2)

    # Read HTML
    with open('../Template_Result_{}.html'.format(i),'w') as f1:
        with open('Template_Result.html','r') as f:
            for line in f:
                if '<h2>stu1_name, stu2_name</h2>' in line:
                    line = line.replace('stu1_name, stu2_name','Joris Baan, David Stap')
                elif 'SIFT step size</th><td>XXX' in line:
                    line = line.replace('XXX',str(step))
                elif 'SIFT block sizes</th><td>XXX' in line:
                    line = line.replace('XXX',str(size))
                elif 'SIFT method</th><td>XXX-SIFT' in line:
                    line = line.replace('XXX-SIFT',str(method))
                elif 'Vocabulary size</th><td>XXX' in line:
                    line = line.replace('XXX',str(vocab_size))
                elif 'Vocabulary fraction</th><td>XXX' in line:
                    line = line.replace('XXX',str(vocab_ratio))
                elif 'SVM training data</th><td>XXX positive, XXX' in line:
                    line = line.replace('SVM training data</th><td>XXX positive, XXX', \
                    'SVM training data</th><td>{} positive, {}'.format(n_pos,n_neg))
                elif 'SVM kernel type</th><td>XXX' in line:
                    line = line.replace('XXX',str(kernel_type))
                elif 'Prediction lists (MAP: 0.XXX)' in line:
                    line = line.replace('0.XXX',str(mean_ap))
                elif 'Airplanes (AP: 0.XXX)</th><th>Cars (AP: 0.XXX)</th><th>Faces (AP: 0.XXX)</th><th>Motorbikes (AP: 0.XXX)' in line:
                    line = line.replace('Airplanes (AP: 0.XXX)</th><th>Cars (AP: 0.XXX)</th><th>Faces (AP: 0.XXX)</th><th>Motorbikes (AP: 0.XXX)', \
                    'Airplanes (AP: {})</th><th>Cars (AP: {})</th><th>Faces (AP: {})</th><th>Motorbikes (AP: {})'.format(ap[0],ap[1],ap[2],ap[3]))
                elif '<tr><td><img src=\"Caltech4/ImageData/airplanes_test/img003.jpg\" /></td><td><img src=\"Caltech4/ImageData/cars_test/img024.jpg\" /></td><td><img src=\"Caltech4/ImageData/faces_test/img015.jpg\" /></td><td><img src=\"Caltech4/ImageData/motorbikes_test/img001.jpg\" /></td></tr>' in line:
                    for i in reversed(range(0,199)):
                        line = '<tr><td><img src=\"{}\" /></td><td><img src=\"{}\" /></td><td><img src=\"{}\" /></td><td><img src=\"{}\" /></td></tr>'.format(matfile['qualitative'][0][0][i][0][0],matfile['qualitative'][0][1][i][0][0],matfile['qualitative'][0][2][i][0][0],matfile['qualitative'][0][3][i][0][0])
                        f1.write(line)
                    f1.write('</tbody>')
                    f1.write('</table>')
                    f1.write('</body>')
                    f1.write('</html>')
                    quit()
                f1.write(line)
