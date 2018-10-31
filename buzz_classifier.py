import keras
from keras.preprocessing.image import ImageDataGenerator



images = ImageDataGenerator(rescale = 1./255)

traindata = images.flow_from_directory(
	'./Spectrograms/Train',
	color_mode = 'grayscale',
	#target_size = (513, 800),
	batch_size = 30,
	class_mode = 'binary')


# for data_batch, labels_batch in traindata:
# 	print('data batch shape:', data_batch.shape)
# 	print('labels batch shape:', labels_batch.shape)
# 	print(data_batch[1,:,:,0].shape)
# 	break


valdata = images.flow_from_directory(
	'./Spectrograms/Validate',
	color_mode = 'grayscale',
	#target_size = (513, 800),
	batch_size = 30,
	class_mode = 'binary')

from keras import models
from keras import layers




model = models.Sequential()
model.add(layers.Conv2D(12, (4,4), activation = 'relu', input_shape = (256,256,1)))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(24, (4,4), activation = 'relu'))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(24, (4,4), activation = 'relu'))
model.add(layers.Flatten())
model.add(layers.Dense(24, activation = 'relu'))
model.add(layers.Dense(1, activation = 'softmax'))


model.summary()


model.compile(
	optimizer = 'rmsprop',
	loss = 'binary_crossentropy',
	metrics = ['accuracy']
	)
model.fit_generator(
	traindata,
	steps_per_epoch = 6,
	epochs = 100,
	validation_data = valdata,
	validation_steps = 1)


