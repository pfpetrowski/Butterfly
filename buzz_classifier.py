import keras
from keras.preprocessing.image import ImageDataGenerator



images = ImageDataGenerator(rescale = 1./255)

traindata = images.flow_from_directory(
	'./Train',
	color_mode = 'grayscale',
	target_size = (513, 800),
	batch_size = 10,
	class_mode = 'binary')


# for data_batch, labels_batch in traindata:
# 	print('data batch shape:', data_batch.shape)
# 	print('labels batch shape:', labels_batch.shape)
# 	print(data_batch[1,:,:,0].shape)
# 	break


valdata = images.flow_from_directory(
	'./Validate',
	color_mode = 'grayscale',
	target_size = (513, 800),
	batch_size = 10,
	class_mode = 'binary')

from keras import models
from keras import layers




model = models.Sequential()
model.add(layers.Conv2D(32, (3,3), activation = 'relu', input_shape = (513,800,1)))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(64, (3,3), activation = 'relu'))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(64, (3,3), activation = 'relu'))
model.add(layers.Flatten())
model.add(layers.Dense(64, activation = 'relu'))
model.add(layers.Dense(1, activation = 'softmax'))


model.summary()


model.compile(
	optimizer = 'rmsprop',
	loss = 'binary_crossentropy',
	metrics = ['accuracy']
	)
model.fit_generator(
	traindata,
	steps_per_epoch = 8,
	epochs = 10,
	validation_data = valdata,
	validation_steps = 3)


