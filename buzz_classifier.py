import keras
from keras.preprocessing.image import ImageDataGenerator


train_images = ImageDataGenerator(
	rescale = 1./255,
	horizontal_flip = True
	)

val_images = ImageDataGenerator(
	rescale = 1./255
	)

traindata = train_images.flow_from_directory(
	'./Data/Noisered100ms/Train',
	color_mode = 'grayscale',
	target_size = (100, 100),
	batch_size = 74,
	class_mode = 'binary')


valdata = val_images.flow_from_directory(
	'./Data/Noisered100ms/Validate',
	color_mode = 'grayscale',
	target_size = (100, 100),
	batch_size = 40,
	class_mode = 'binary')

import numpy
numpy.set_printoptions(threshold=numpy.nan)
import  matplotlib.pyplot as plt ## Sometimes Causes 'core dump error' for some reason. Might have to do with tensorflow-gpu
from keras.preprocessing import image

# # for i, j in valdata:
# # 	print(i[9,:,:,0].round(1))
# # 	break
# # quit()

# for data_batch, labels_batch in traindata:
# 	print('data batch shape:', data_batch.shape)
# 	print('labels batch shape:', labels_batch.shape)
# 	var = data_batch[3,:,:,0].round(1)
# 	print(labels_batch[4])
# 	plt.imshow(image.array_to_img(data_batch[4]))
# 	break

# plt.show()	
# quit()


from keras import models
from keras import layers


model = models.Sequential()
model.add(layers.Conv2D(3, (2,2), activation = 'relu', input_shape = (100,100,1), padding = 'same'))
model.add(layers.BatchNormalization())
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(6, (2,2), activation = 'relu', padding = 'same'))
model.add(layers.BatchNormalization())
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(12, (2,2), activation = 'relu', padding = 'same'))
model.add(layers.BatchNormalization())
model.add(layers.MaxPooling2D(2,2))
model.add(layers.Flatten())
model.add(layers.Dense(32, activation = 'relu'))
model.add(layers.Dense(1, activation = 'sigmoid'))



model.summary()
# quit()

model.compile(
	optimizer = 'rmsprop',
	loss = 'binary_crossentropy',
	metrics = ['accuracy']
	)


history = model.fit_generator(
	traindata,
	steps_per_epoch = 4,
	epochs = 15,
	validation_data = valdata,
	validation_steps = 1,
	shuffle = True)


test_images = ImageDataGenerator(rescale=1./255)
testdata = test_images.flow_from_directory(
	'./Data/Noisered100ms/Test',
	color_mode = 'grayscale',
	target_size = (100, 100),
	batch_size = 100,
	class_mode = 'binary')



# results = model.evaluate_generator(
# 	testdata,
# 	steps = 1,
# 	verbose = 1)

# print(model.metrics_names)
# print(results)


x,y_true = testdata.next()


y_pred = model.predict(
	x,
	verbose = 1)
y_pred = y_pred.round()

# for i in range(100):
# 	print(y_true[i], y_pred[i])

from sklearn import metrics
confusion_matrix = metrics.confusion_matrix(y_true,y_pred)
print(confusion_matrix)

#model.save('100msWindow.h5')

makeplots = False

if makeplots == True:
	import matplotlib.pyplot as plt

	# Plot training & validation accuracy values
	plt.plot(history.history['acc'])
	plt.plot(history.history['val_acc'])
	plt.title('Model accuracy')
	plt.ylabel('Accuracy')
	plt.xlabel('Epoch')
	plt.legend(['Train', 'Validate'], loc='upper left')
	plt.show()

	# Plot training & validation loss values
	plt.plot(history.history['loss'])
	plt.plot(history.history['val_loss'])
	plt.title('Model loss')
	plt.ylabel('Loss')
	plt.xlabel('Epoch')
	plt.legend(['Train', 'Validate'], loc='upper left')
	plt.show()