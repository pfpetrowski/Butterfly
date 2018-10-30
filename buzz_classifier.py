import keras
from keras.preprocessing.image import ImageDataGenerator

images = ImageDataGenerator()

data = images.flow_from_directory(
	'/home/pfpetrowski/Bees/Buzzes/',
	target_size = (513, 800),
	batch_size = 10,
	class_mode = 'binary')

print(type(data))