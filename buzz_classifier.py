import keras
from keras.preprocessing.image import ImageDataGenerator


train_images = ImageDataGenerator(
	rescale = 1./255,
	horizontal_flip = True)

val_images = ImageDataGenerator(rescale = 1./255)

traindata = train_images.flow_from_directory(
	'./Spectrograms/Train',
	color_mode = 'grayscale',
	target_size = (200, 200),
	batch_size = 90,
	class_mode = 'binary')


valdata = val_images.flow_from_directory(
	'./Spectrograms/Validate',
	color_mode = 'grayscale',
	target_size = (200, 200),
	batch_size = 20,
	class_mode = 'binary')


# for data_batch, labels_batch in traindata:
# 	print('data batch shape:', data_batch.shape)
# 	print('labels batch shape:', labels_batch.shape)
# 	print(data_batch[1,:,:,0].round(1))
# 	break
# quit()


from keras import models
from keras import layers


model = models.Sequential()
model.add(layers.Conv2D(3, (2,2), activation = 'relu', input_shape = (200,200,1)))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(6, (2,2), activation = 'relu'))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(6, (2,2), activation = 'relu'))
model.add(layers.MaxPooling2D((2,2)))
model.add(layers.Conv2D(6, (2,2), activation = 'relu'))
model.add(layers.Flatten())
model.add(layers.Dense(6, activation = 'relu'))
model.add(layers.Dense(1, activation = 'softmax'))


model.summary()


model.compile(
	optimizer = 'rmsprop',
	loss = 'binary_crossentropy',
	metrics = ['accuracy']
	)


model.fit_generator(
	traindata,
	steps_per_epoch = 1,
	epochs = 1000,
	validation_data = valdata,
	validation_steps = 1)


